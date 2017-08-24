//
//  SmartQueueManager.h
//  yykitTest
//
//  Created by 刘赋山 on 2017/8/23.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^taskEndBLock)();

@protocol SmartQueueClientDelegate <NSObject>

- (void)onReceiveSmartQueueNotify:(NSDictionary *)notify completion:(taskEndBLock)block;

@end

@interface SmartQueueManager : NSObject

@property (nonatomic, copy) taskEndBLock taskEndBlock;
+ (SmartQueueManager *)shareQueue;
+ (void)addClient:(id)client forKey:(NSString *)clientKey;
+ (void)addEvent:(NSDictionary *)event forClientKey:(NSString *)clientKey;


@end
