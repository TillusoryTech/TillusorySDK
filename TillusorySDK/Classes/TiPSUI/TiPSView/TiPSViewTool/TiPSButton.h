//
//  TiPSButton.h
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TiPSButton : UIButton
// scaling 为图片缩放比
- (instancetype _Nonnull )initWithScaling:(CGFloat)scaling withMakeUp:(BOOL)isMakeUp;

- (void)setTitle:(nullable NSString *)title withImage:(nullable UIImage *)image withTextColor:(nullable UIColor *)color forState:(UIControlState)state;

- (void)setTextFont:(UIFont *_Nullable)font;

- (void)setSelectedText:(NSString *_Nullable)text;

// 设置遮罩层
- (void)setViewforState;

- (void)setBorderWidth:(CGFloat)W BorderColor:(nullable UIColor *)color forState:(UIControlState)state;

// 分类专属方法
- (void)setClassifyText:(nullable NSString *)title withTextColor:(nullable UIColor *)color;

// 设置选中状态下的圆形边框
- (void)setRoundSelected:(BOOL)selected width:(CGFloat)width;

// 调整内部图片缩放比
- (void)setScaling:(CGFloat)scaling;

@end
