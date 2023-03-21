//
//  TiPSSliderView.h
//  TiFancy
//
//  Created by N17 on 2021/9/18.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, TiPSSliderType) {
    TiPSSliderTypeOne,
    TiPSSliderTypeTwo
};

@interface TiPSSliderView : UISlider

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
- (void)setSliderType:(TiPSSliderType)sliderType WithValue:(float)value;

@end
