//
//  cardModel.h
//  yykitTest
//
//  Created by 刘赋山 on 2017/7/15.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
extern NSString * const ArGiftNotify;


@interface cardModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSDictionary *dic;
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, assign) int testNum;
@property (nonatomic, assign) BOOL isStudent;
@property (nonatomic, strong) NSData *data;
@property (nonatomic, strong) NSSet *set;
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, assign) CGFloat myFloat;
@property (nonatomic, assign) CGSize mySize;
@property (nonatomic, assign) CGRect myRect;

@end
