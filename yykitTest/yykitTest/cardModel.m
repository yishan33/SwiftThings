//
//  cardModel.m
//  yykitTest
//
//  Created by 刘赋山 on 2017/7/15.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import "cardModel.h"
#import <objc/runtime.h>

NSString * const ArGiftNotify = @"CrossPKArGiftNotify";


@interface cardModel (moreFunction)

- (void)showMoreFunction;

@end

@implementation cardModel

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{
             @"name" : @"n",
             @"phoneNumber" : @"num"
             };
}



- (NSString *)description {
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    uint count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        NSString *name = @(property_getName(property));
        id value = [self valueForKey:name]? : @"nil";
        if (![value isKindOfClass:[NSObject class]]) {
            NSLog(@"is not a object");
        }
        [dictionary setObject:value forKey:name];
    }
    
    free(properties);
    
    return [NSString  stringWithFormat:@"<%@: %p> -- %@", [self class], self, dictionary];
}


@end
