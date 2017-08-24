//
//  Header.h
//  yykitTest
//
//  Created by 刘赋山 on 2017/7/24.
//  Copyright © 2017年 刘赋山. All rights reserved.
//

#import "UIColor+YYAdd.h"

#define YYCOLOR [UIColor colorWithHexString:@"#f2a603"]
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

//引导词Label与手势的间距
static const int IntervalBetweenGuideLabelArrowV = 30;

//手势引导图长宽
static const int WidthOfGuideArrowImage = 70;
static const int HeightOfGuideArrowImage = 70;

//手势引导图与目标按钮的间距
static const int IntervalBetweenArrowTargetH = 15;
static const int IntervalBetweenArrowTargetV = 20;

//目标按钮背景图长宽
static const int WidthOfTargetBackView = 32;
static const int HeightOfTargetBackView = 32;

//目标按钮前景图长宽
static const int WidthOfTargetFrontView = 20;
static const int HeightOfTargetFrontView = 20;

//目标按钮与右侧视图，底部的间隔
static const int IntervalBetweenTargetSuperH = 54;   //Normal 横：36 + 10 + 8   支持我横：71 + 10 + 8
                                                      //Normal 纵：36 + 10 + 10  支持我纵：36 + 10 + 10
static const int IntervalBetweenTargetSuperV = 10;


