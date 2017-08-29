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
    
    return string;
}


- (NSString*)arrayString:(NSArray *)array {
    
    NSMutableString *string = [[NSMutableString alloc] init];
    for (int i = 0; i < [array count]; i++) {
        if ([[array objectAtIndex:i] isKindOfClass:[NSDictionary class]]) {
        
            [string appendString:[NSString stringWithFormat:@"{%@}", [self dicString:[array objectAtIndex:i]]]];
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
    
    return string;
}


- (NSString *)detailDescription {
    
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    NSMutableString *descriptionString = [NSMutableString new];
    //循环并用KVC得到每个属性的值
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name]?:@"nil";//默认值为nil字符串
        NSString *propertyString;
        if ([value isKindOfClass:[NSArray class]]) {
            propertyString = [self arrayString:value];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            propertyString = [NSString stringWithFormat:@"{%@}",[self dicString:value]];
        }  else if ([value isKindOfClass:[NSNumber class]]) {
            propertyString = [value stringValue];
        } else if ([value isKindOfClass:[NSString class]]) {
            propertyString = value;
        } else {
            propertyString = @"";
        }
        [descriptionString appendString:[NSString stringWithFormat:@"[%@:%@],", name, propertyString]];
    }

    return descriptionString;
}


- (NSString *)description {
    return [self detailDescription];
}

@end
