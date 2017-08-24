//
//  testFile.m
//  yykitTest
//
//  Created by 刘赋山 on 2017/7/18.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import "testFile.h"
#import "Masonry.h"

@interface testFile ()
@property (nonatomic, strong) UILabel *giftCountLabel;
@end


@implementation testFile


- (void)testColor {
    //礼物统计Label
    _giftCountLabel = [[UILabel alloc] init];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"0/66"];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:242 green:166 blue:3 alpha:1] range:NSMakeRange(0, 1)];
    [string addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:255 green:255 blue:255 alpha:1] range:NSMakeRange(1, 4)];
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular"size:20.0] range:NSMakeRange(0, 4)];
    _giftCountLabel.attributedText = string;
    
    [_giftCountLabel setText:@"0/66"];
    [_giftCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(30);
        make.centerY.equalTo(self.mas_centerY);
        make.width.equalTo(@100);
        make.height.equalTo(@60);
    }];
    [self addSubview:_giftCountLabel];
    
}

- (void)test {
    [self testColor];
}

@end
