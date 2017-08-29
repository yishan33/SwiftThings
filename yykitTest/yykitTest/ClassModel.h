//
//  ClassModel.h
//  yykitTest
//
//  Created by 刘赋山 on 2017/8/29.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassModel : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSNumber *studentNum;
@property (nonatomic, strong) NSArray *teachersArray;

@end
