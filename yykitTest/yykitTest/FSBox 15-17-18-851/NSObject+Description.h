//
//  NSObject+Description.h
//  yykitTest
//
//  Created by 刘赋山 on 2017/8/29.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, objectType) {
    objectTypeNSString = 0,
    objectTypeNSNumber = 1,
    objectTypeNSArray = 2,
    objectTypeNSDictionary = 3,
    objectTypeNSSet = 4,
    objectTypeNSDate = 5,
    objectTypeNSData = 6,
    objectTypeUnknow = 255,
};

@interface NSObject (Description)

- (NSString *)FSDetailDescription;

@end
