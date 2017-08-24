//
//  cardModel.m
//  yykitTest
//
//  Created by 刘赋山 on 2017/7/15.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import "cardModel.h"

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


@end
