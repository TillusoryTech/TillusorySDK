//
//  TiPSSliderRelatedView.h
//  TiFancy
//
//  Created by N17 on 2021/9/17.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiPSSliderView.h"

@interface TiPSSliderRelatedView : UIView

// 自定义Slider
@property(nonatomic,strong) TiPSSliderView *sliderView;
// 左右两边对应的文字
@property(nonatomic,strong) UILabel *leftLabel;
@property(nonatomic,strong) UILabel *rightLabel;

- (void)setLeftTitle:(NSString *)leftTitle andRightTitle:(NSString *)rightTitle;

@end
