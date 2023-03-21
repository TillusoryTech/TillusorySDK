//
//  TiPSTopSliderRelatedView.h
//  TiPSTopSliderRelatedView
//
//  Created by N17 on 2021/8/24.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiPSSliderView.h"

@interface TiPSTopSliderRelatedView : UIView

// 自定义Slider
@property(nonatomic,strong) TiPSSliderView *sliderView;
// 显示Slider数值
@property(nonatomic,strong) UILabel *sliderLabel;
// 美颜对比开关
@property(nonatomic,strong) UIButton *tiContrastBtn;
// 开关美颜的回调
@property(nonatomic,copy) void(^clickContrastBlock)(NSNumber *renderEnable);
- (void)setSliderHidden:(BOOL)hidden;

@end
