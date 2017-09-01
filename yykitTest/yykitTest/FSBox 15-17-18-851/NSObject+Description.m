//
//  NSObject+Description.m
//  yykitTest
//
//  Created by 刘赋山 on 2017/8/29.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import "NSObject+Description.h"
#import <objc/runtime.h>

@implementation NSObject (Description)

//判定属性类型
- (objectType)objectTypeOfValue:(id)value {
    if ([value isKindOfClass:[NSString class]]) {
        return objectTypeNSString;
    } else if ([value isKindOfClass:[NSNumber class]]) {
        return objectTypeNSNumber;
    } else if ([value isKindOfClass:[NSArray class]]) {
        return objectTypeNSArray;
    } else if ([value isKindOfClass:[NSDictionary class]]) {
        return objectTypeNSDictionary;
    } else if ([value isKindOfClass:[NSSet class]]) {
        return objectTypeNSSet;
    } else if ([value isKindOfClass:[NSData class]]) {
        return objectTypeNSData;
    } else if ([value isKindOfClass:[NSDate class]]) {
        return objectTypeNSDate;
    } else {
        return objectTypeUnknow;
    }
}

//将字典格式化为字符串
- (NSString*)dicString:(NSDictionary *)dic {
    NSArray *keysArray = [NSArray arrayWithArray:[dic allKeys]];
    NSArray *valuesArray = [NSArray arrayWithArray:[dic allValues]];
    NSMutableString *string = [[NSMutableString alloc] init];
    for (int i = 0; i < [keysArray count]; i++) {
        [string appendString:[NSString stringWithFormat:@"[%@:%@]", [keysArray objectAtIndex:i], [valuesArray objectAtIndex:i]]];
        if (i != (keysArray.count - 1)) {
            [string appendString:@","];
        }
    }
    return [NSString stringWithFormat:@"{%@}",string];
}

//将数组格式化为字符串
- (NSString*)arrayString:(NSArray *)array {
    
    NSMutableString *string = [[NSMutableString alloc] init];
    for (int i = 0; i < [array count]; i++) {
        if ([[array objectAtIndex:i] isKindOfClass:[NSDictionary class]]) {
        
            [string appendString:[self dicString:[array objectAtIndex:i]]];
        } else {
            id object = [array objectAtIndex:i];
            if ([object isKindOfClass:[NSString class]]) {
                [string appendString:object];
            } else {
                [string appendString:[object stringValue]];
            }
        }
        if (i != (array.count - 1)) {
            [string appendString:@","];
        }
    }
    
    return [NSString stringWithFormat:@"[%@]", string];
}

//将集合内元素格式化为字符串
- (NSString *)setString:(NSSet *)set {
    
    NSMutableArray *array = [NSMutableArray arrayWithObjects:[set allObjects], nil];
    return [self arrayString:array];
}

- (NSString *)dataString:(NSData *)data {
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)dateString:(NSDate *)date {
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"YYYY-mm-dd HH:MM:ss"];
    
    return [format stringFromDate:date];
}

#pragma mark - Main Method
- (NSString *)FSDetailDescription {
    
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableString *descriptionString = [NSMutableString new];
    
    //循环并用KVC得到每个属性的值
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name]?:@"nil";//默认值为nil字符串
        NSString *propertyString;
        switch ([self objectTypeOfValue:value]) {
            case objectTypeNSString:
                propertyString = value;
                break;
            case objectTypeNSNumber:
                propertyString = [value stringValue];
                break;
            case objectTypeNSArray:
                propertyString = [self arrayString:value];
                break;
            case objectTypeNSDictionary:
                propertyString = [self dicString:value];
                break;
            case objectTypeNSSet:
                propertyString = [self setString:value];
                break;
            case objectTypeNSData:
                propertyString = [self dataString:value];
                break;
            case objectTypeNSDate:
                propertyString = [self dateString:value];
                break;
            case objectTypeUnknow:
                propertyString = [NSString stringWithFormat:@"%@", value];
                break;
            default:
                break;
        }
        [descriptionString appendString:[NSString stringWithFormat:@"[%@:%@],", name, propertyString]];
    }
    return descriptionString;
}

@end
