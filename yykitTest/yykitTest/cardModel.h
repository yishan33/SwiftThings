//
//  cardModel.h
//  yykitTest
//
//  Created by 刘赋山 on 2017/7/15.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const ArGiftNotify;


@interface cardModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) NSString *phoneNumber;


@end
