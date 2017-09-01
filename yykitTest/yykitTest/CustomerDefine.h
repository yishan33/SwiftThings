//
//  CustomerDefine.h
//  yykitTest
//
//  Created by 刘赋山 on 2017/8/29.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#ifndef CustomerDefine_h
#define CustomerDefine_h

#define FSLog(xx, ...) NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define DDLog(xx, ...) NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)


#define FSTICK NSDate *FSStartTime = [NSDate date]
#define FSTOCK NSLog(@"Time: %f", -[FSStartTime timeIntervalSinceNow])


#endif /* CustomerDefine_h */


