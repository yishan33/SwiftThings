//
//  FSTestHelper.h
//  yykitTest
//
//  Created by 刘赋山 on 2017/9/1.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#ifndef FSTestHelper_h
#define FSTestHelper_h



//我的Log
#define FSLog(xx, ...) NSLog(@"lfs_test: %s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

//时间测试
#define FSTICK NSDate *FSStartTime = [NSDate date]
#define FSTOCK FSLog(@"Use Time: %f s", -[FSStartTime timeIntervalSinceNow])


//文件路径
#define DOCUMENTSPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define CACHESPATH [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define TEMPPATH NSTemporaryDirectory()



#endif /* FSTestHelper_h */
