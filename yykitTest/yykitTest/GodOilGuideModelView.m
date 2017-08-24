//
//  GodOilGuideModelView.m
//  yykitTest
//
//  Created by 刘赋山 on 2017/7/20.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import "GodOilGuideModelView.h"
#import "Masonry.h"
#import "GuideViewStaticParaments.h"


@interface GodOilGuideModelView ()

@property (nonatomic, strong) UILabel *guideLabel;
@property (nonatomic, strong) UIImageView *guideArrowImageView;
@property (nonatomic, strong) UIImageView *targetFrontView;
@property (nonatomic, strong) UIImageView *targetBackView;
@property (nonatomic, strong) NSTimer *dismissTimer;

@end

@implementation GodOilGuideModelView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        _dismissTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
//            [self dismissMaskView];
        }];
        [self setup];
    }
    return self;
}

#pragma mark - 构造蒙版
- (void)setup {
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];
//    self.backgroundColor = [UIColor purpleColor];
    
    _guideLabel = [[UILabel alloc] init];
    NSMutableAttributedString *guideString = [[NSMutableAttributedString alloc] initWithString:@"点击为主播消除脸上的止血贴"];
    [guideString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 10)];
    [guideString addAttribute:NSForegroundColorAttributeName value:YYCOLOR range:NSMakeRange(10, 3)];
    [guideString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular" size:18.0] range:NSMakeRange(0, 13)];
    _guideLabel.attributedText = guideString;
    [self addSubview:_guideLabel];
    
    _guideArrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"channel_share_guide_finger@2x"]];
    _guideArrowImageView.transform = CGAffineTransformMakeRotation(M_PI * 3 / 2);
    [self addSubview:_guideArrowImageView];
    
    _targetBackView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hotgift_bg"]];
    [self addSubview:_targetBackView];
    
    _targetFrontView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tab_gift_selected"]];
    [_targetBackView addSubview:_targetFrontView];
    
    [_targetBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-IntervalBetweenTargetSuperH);
        make.bottom.equalTo(self.mas_bottom).with.offset(-IntervalBetweenTargetSuperV);
        make.width.equalTo(@(WidthOfTargetBackView));
        make.height.equalTo(@(WidthOfTargetBackView));
    }];
    
    [_targetFrontView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_targetBackView);
        make.width.equalTo(@(WidthOfTargetFrontView));
        make.height.equalTo(@(HeightOfTargetFrontView));
    }];
    
    [_guideArrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_targetBackView.mas_centerX).with.offset(-IntervalBetweenArrowTargetH);
        make.bottom.equalTo(_targetBackView.mas_top).with.offset(-IntervalBetweenArrowTargetV);
        make.width.equalTo(@(WidthOfGuideArrowImage));
        make.height.equalTo(@(HeightOfGuideArrowImage));
    }];
    
    [_guideLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(_guideArrowImageView.mas_top).with.offset(-IntervalBetweenGuideLabelArrowV);
    }];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMaskView)];
    [self addGestureRecognizer:tap];
    
}

#pragma mark 显示蒙版
- (void)showMaskViewInView:(UIView *)view {
    self.alpha = 0;
    [view addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
}


#pragma mark 消除蒙版
- (void)dismissMaskView {
    _dismissTimer = nil;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
