//
//  GodOilGuideModelView.h
//  yykitTest
//
//  Created by 刘赋山 on 2017/7/20.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GodOilGuideModelView : UIView

typedef void(^dismissBlock_t)();

@property (nonatomic, copy) dismissBlock_t dismissBlock;

//启动蒙版
- (void)showMaskViewInView:(UIView *)view;

//销毁蒙版view(默认点击空白区自动销毁)
- (void)dismissMaskView;

@end
