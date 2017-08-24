//
//  yykitTestTests.m
//  yykitTestTests
//
//  Created by 刘赋山 on 2017/7/13.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface yykitTestTests : XCTestCase

@end

@implementation yykitTestTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testExampleMy {
    int a = 1;
    int b = 2;
    XCTAssertEqual(a + b, 3);
}

@end
