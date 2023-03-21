//
//  TiUISliderRelatedView.h
//  TiUISliderRelatedView
//
//  Created by N17 on 2021/8/24.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiUISliderView.h"

@interface TiUISliderRelatedView : UIView

// 自定义Slider
@property(nonatomic,strong) TiUISliderView *sliderView;
// 显示Slider数值
@property(nonatomic,strong) UILabel *sliderLabel;
// 美颜对比开关
@property(nonatomic,strong) UIButton *tiContrastBtn;

- (void)setSliderHidden:(BOOL)hidden;

// 设置主题色
- (void)setTheme:(NSString *)switchAspectRatio withSpecial:(BOOL)isSP;

@end
