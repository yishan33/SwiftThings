//
//  MaskView.m
//  yykitTest
//
//  Created by 刘赋山 on 2017/7/17.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import "CrownGuideModelView.h"
#import "Masonry.h"
#import "GuideViewStaticParaments.h"


@interface CrownGuideModelView ()

@property (nonatomic, strong) UILabel *guideLabel;
@property (nonatomic, strong) UIImageView *guideArrowImageView;
@property (nonatomic, strong) UIImageView *targetFrontView;
@property (nonatomic, strong) UIImageView *targetBackView;
@property (nonatomic, strong) UILabel *giftCountLabel;
@property (nonatomic, strong) NSTimer *dismissTimer;

@end

@implementation CrownGuideModelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

static const int IntervalBetweenSuperGuideCountLabelH = 15;
static const int IntervalBetweenSuperGuideCountLabelV = 299;  //横屏：59  距super底部
static const int WidthOfGuideCountLabel = 50;

#pragma mark - 初始化
//- (instancetype)initWithFrame:(CGRect)frame {
//    self = [super initWithFrame:[UIScreen mainScreen].bounds];
//    if (self) {
//        _dismissTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
////            [self dismissMaskView];
//            ;
//        }];
//        [self setUp];
//    }
//    return self;
//}

- (instancetype)init {
    self = [super init];
    if (self) {
        _dismissTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
            //            [self dismissMaskView];
        
        }];
        [self setUp];
        
    }
    return self;
}

#pragma mark - 蒙版内容构造
- (void)setUp {
    
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8];

    //礼物统计Label
    _giftCountLabel = [[UILabel alloc] init];
    NSLog(@"gift begin");
    NSMutableAttributedString *countString = [[NSMutableAttributedString alloc] initWithString:@"0/66"];
    [countString addAttribute:NSForegroundColorAttributeName value:YYCOLOR range:NSMakeRange(0, 1)];
    [countString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(1, 3)];
    [countString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular"size:10.0] range:NSMakeRange(0, 4)];
  
    _giftCountLabel.attributedText = countString;
    _giftCountLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_giftCountLabel];

    NSLog(@"gift error");
    
    //引导词内容填充
    NSLog(@"guideLabel begin");
    _guideLabel = [[UILabel alloc] init];
    NSMutableAttributedString *guideString = [[NSMutableAttributedString alloc] initWithString:@"我方领先，快为主播加冕吧!"];
    [guideString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 9)];
    [guideString addAttribute:NSForegroundColorAttributeName value:YYCOLOR range:NSMakeRange(9, 2)];
    [guideString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(11, 2)];
    [guideString addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"PingFang-SC-Regular"size:18.0] range:NSMakeRange(0, 13)];
    _guideLabel.attributedText = guideString;
    [self addSubview:_guideLabel];
    
    //加冕按钮视图由两部分构成，一个背景view，一个前景view
    _targetBackView = [[UIImageView alloc] init];
    [_targetBackView setImage:[UIImage imageNamed:@"happypk_crown_bg"]];
    [self addSubview:_targetBackView];

    
    _targetFrontView = [[UIImageView alloc] init];
    [_targetFrontView setImage:[UIImage imageNamed:@"tab_gift_selected"]];
    [_targetBackView addSubview:_targetFrontView];
    
    //把指引箭头的位置摆好
    _guideArrowImageView = [[UIImageView alloc] init];
    [_guideArrowImageView setImage:[UIImage imageNamed:@"channel_share_guide_finger"]];
    _guideArrowImageView.transform = CGAffineTransformMakeRotation(M_PI * 3 / 2);
    [self addSubview:_guideArrowImageView];
    
    if (SCREENWIDTH > SCREENHEIGHT) {
        [_targetBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-8);
            make.bottom.equalTo(self.mas_bottom).with.offset(-56);
            make.width.equalTo(@(WidthOfTargetBackView));
            make.height.equalTo(@(HeightOfTargetBackView));
        }];
        NSLog(@"LandscapeLeft");
        
    } else {
        [_targetBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-IntervalBetweenTargetSuperH);
            make.bottom.equalTo(self.mas_bottom).with.offset(-IntervalBetweenTargetSuperV);
            make.width.equalTo(@(WidthOfTargetBackView));
            make.height.equalTo(@(HeightOfTargetBackView));
        }];
        NSLog(@"Normal");
    }
   
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
        //        make.right.equalTo(self.mas_right);
    }];
    
    if (SCREENWIDTH > SCREENHEIGHT) {
        [_giftCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_centerX).with.offset(-15);
            make.bottom.equalTo(self.mas_bottom).with.offset(-59);
            make.width.equalTo(@(WidthOfGuideCountLabel));
        }];
        NSLog(@"countlabel rotate");
    } else {
        [_giftCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).with.offset(IntervalBetweenSuperGuideCountLabelH);
            make.bottom.equalTo(self.mas_bottom).with.offset(-IntervalBetweenSuperGuideCountLabelV);
            make.width.equalTo(@(WidthOfGuideCountLabel));
        }];
    }
    
   

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissMaskView)];
    [self addGestureRecognizer:tap];
    

}

#pragma mark - 旋转通知
- (void)OrientationDidChange:(NSNotification *)notify {
    [_giftCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).with.offset(-15);
        make.bottom.equalTo(self.mas_bottom).with.offset(-59);
        make.width.equalTo(@(WidthOfGuideCountLabel));
    }];
    NSLog(@"countlabel rotate");
    
    [_targetBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).with.offset(-8);
        make.bottom.equalTo(self.mas_bottom).with.offset(-56);
        make.width.equalTo(@(WidthOfTargetBackView));
        make.height.equalTo(@(HeightOfTargetBackView));
    }];
    NSLog(@"LandscapeLeft");
}

#pragma mark - 显示蒙版
- (void)showMaskViewInView:(UIView *)view {
    self.alpha = 0;
    [view addSubview:self];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.superview);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1;
    }];
    
}

#pragma mark - 移除蒙版
- (void)dismissMaskView {
    _dismissTimer = nil;
    __weak typeof(self)weakSelf = self;
    [UIView animateWithDuration:0.5 animations:^{
        weakSelf.alpha = 0;
    } completion:^(BOOL finished) {
        if (self.dismissBlock) {
            self.dismissBlock();
        }
        [weakSelf removeFromSuperview];
    }];
}


@end
