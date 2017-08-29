//
//  SmartQueueManager.m
//  yykitTest
//
//  Created by 刘赋山 on 2017/8/23.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import "SmartQueueManager.h"

@interface SmartQueueManager ()

@property (nonatomic, strong) NSMutableArray *eventKeyQueue;
@property (nonatomic, strong) NSMutableArray *eventQueue;
@property (nonatomic, copy) NSString *currentEventKey;
@property (nonatomic, strong) NSMutableDictionary *clientDictionary;

@property (nonatomic, assign) int queueLength;

@end

@implementation SmartQueueManager

+ (SmartQueueManager *)shareQueue {
    static SmartQueueManager *shareQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareQueue = [[self alloc] init];
        shareQueue.eventKeyQueue = [[NSMutableArray alloc] init];
        shareQueue.eventQueue = [[NSMutableArray alloc] init];
        shareQueue.clientDictionary = [[NSMutableDictionary alloc] init];
        [shareQueue addObserver:shareQueue forKeyPath:@"currentEventKey" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    });
    return shareQueue;
}

+ (void)addClient:(id<SmartQueueClientDelegate>)client forKey:(NSString *)clientKey {
    
    [[self shareQueue].clientDictionary setObject:client forKey:clientKey];

}

+ (void)addEvent:(NSDictionary *)event forClientKey:(NSString *)clientKey {
    NSLog(@"addEvent in SmartQueueManager");
    NSString *clientOrderKey = [NSString stringWithFormat:@"%@%lu", clientKey, (unsigned long)[self shareQueue].eventKeyQueue.count];
    [[self shareQueue].eventKeyQueue addObject:clientOrderKey];
    [[self shareQueue].eventQueue addObject:event];
    if ([self shareQueue].eventKeyQueue.count == 1) {
        [self shareQueue].currentEventKey = clientOrderKey;
    }
    [self shareQueue].queueLength += 1;
}

- (void)notifyClientByKey:(NSString *)eventKey {

    NSInteger index = [self.eventKeyQueue indexOfObject:eventKey];
    if (index == NSNotFound) {
        return;
    }
    NSArray *clientKeyArray = self.clientDictionary.allKeys;
    NSString *clientKey = [[NSString alloc] init];
    for (int i = 0; i < clientKeyArray.count; i++) {
        if ([eventKey hasPrefix:[clientKeyArray objectAtIndex:i]]) {
            clientKey = [clientKeyArray objectAtIndex:i];
            break;
        }
    }
    __weak typeof (self) weakself = self;
    id<SmartQueueClientDelegate> client = [self.clientDictionary objectForKey:clientKey];
    [client onReceiveSmartQueueNotify:[self.eventQueue objectAtIndex:index] completion:^{
        [weakself notifyNext];
    }];
}

- (void)notifyNext {
    if (self.eventKeyQueue.count > 0) {
        [self.eventKeyQueue removeObjectAtIndex:0];
        [self.eventQueue removeObjectAtIndex:0];
        if (self.eventKeyQueue.count > 0) {
            [self notifyClientByKey:[self.eventKeyQueue objectAtIndex:0]];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self notifyClientByKey:[change objectForKey:@"new"]];
}


//+ (void)test {
//    [self notifyClientByKey:@"mainView"];
//}

@end
