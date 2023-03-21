//
//  TiUISliderView.h
//  TiUISliderView
//
//  Created by N17 on 2021/8/23.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TiUISliderType) {
    TiSliderTypeOne,
    TiSliderTypeTwo
};

@interface TiUISliderView : UISlider

@property(nonatomic,copy) void(^refreshValueBlock)(CGFloat value);
@property(nonatomic,copy) void(^valueBlock)(CGFloat value);

// 滑动的标记View & 对应进度的文字
@property(nonatomic,strong) UIImageView *sliderIV;
@property(nonatomic,strong) UILabel *sliderLabel;
// 覆盖底层的上方滑动条
@property(nonatomic,strong) UIView *slideBar;
// 标记分割的点（用于第二种滑动条类型)
@property(nonatomic,strong) UIView *splitPoint;

// 调整标记view大小
- (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size;
// 设置滑动条类型&参数
- (void)setSliderType:(TiUISliderType)sliderType WithValue:(float)value;
// 设置主题色
- (void)setTheme:(NSString *)switchAspectRatio withSpecial:(BOOL)isSP;

@end
