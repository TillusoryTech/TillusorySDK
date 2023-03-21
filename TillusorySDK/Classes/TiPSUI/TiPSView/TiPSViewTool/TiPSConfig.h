//
//  TiPSConfig.h
//  TiFancy
//
//  Created by N17 on 2021/9/18.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <Masonry/Masonry.h>
#import "TiPSPlistManager.h"
#import "TiPSAdapter.h"
#import <TiSDK/TiLiveView.h>
#import <TiSDK/TiSDKInterface.h>

// UI版本号
#define TiPSCurrentVersion @"1.0"

#ifndef TI_PS_CONFIG_H
#define TI_PS_CONFIG_H

#define WeakSelf __weak typeof(self) weakSelf = self;

// 颜色
#define TiColor(r,g,b,a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define TiColors(s,a) [UIColor colorWithRed:((s) / 255.0) green:((s) / 255.0) blue:((s) / 255.0) alpha:(a)]

// 英文字体
#define TiFontHelvetica(s) [UIFont fontWithName:@"Helvetica" size:s]
#define TiFontHelveticaSmall [UIFont fontWithName:@"Helvetica" size:10]
#define TiFontHelveticaMedium [UIFont fontWithName:@"Helvetica" size:12]
#define TiFontHelveticaBig [UIFont fontWithName:@"Helvetica" size:14]

// 中文字体
#define TiFontRegular(s) [UIFont fontWithName:@"PingFang-SC-Regular" size:s]
#define TiFontMedium(s) [UIFont fontWithName:@"PingFang-SC-Medium" size:s]

#define getSafeBottomHeight ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom)

// MARK:  滑动条View --TiPSSliderRelatedView--
#define TiPSSliderRelatedViewHeight [[TiPSAdapter shareInstance] heightAfterAdaptionByRawHeight:64]
// MARK: --美颜弹框视图总高度 TiPSManager--
#define TiPSViewBoxTotalHeight ([[TiPSAdapter shareInstance] heightAfterAdaptionByRawHeight:224] + TiPSSliderRelatedViewHeight)
// MARK:  菜单View高度
#define TiPSMenuViewHeight [[TiPSAdapter shareInstance] heightAfterAdaptionByRawHeight:40]

// MARK:  滑块View --TiPSSliderView--
#define TiPSSlideBarHeight [[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:3]

#define TiPSSliderViewWidth [[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:33]
#define TiPSSliderViewHeight [[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:41]

#define TiPSSliderSize [[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:20]
#define TiPSSplitPointSize [[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:7]

// MARK:  子菜单状态View --TiPSViewCell--
#define TiPSWithSwitchViewCellWidth [[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:46]
#define TiPSWithSwitchViewCellHeight [[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:66]

#define TiPSWithoutSwitchViewCellWidth [[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:60]
#define TiPSWithoutSwitchViewCellHeight [[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:76]

#define TiPSSubMenuThreeViewTiButtonWidth [[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:62]
#define TiPSSubMenuThreeViewTiButtonHeight [[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:62]

// MARK: -- 与一键美颜中“标准” 类型参数一致
#define SkinWhiteningValue 70 // 美白滑动条默认参数
#define SkinBlemishRemovalValue 70 // 磨皮滑动条默认参数
#define SkinTendernessValue 40 // 粉嫩滑动条默认参数
#define SkinBrightValue 60 // 清晰滑动条默认参数
#define SkinBrightnessValue 0 // 亮度滑动条默认参数，0表示无亮度效果，[-50, 0]表示降低亮度，[0, 50]表示提升亮度

#define SkinPreciseBeautyValue 0 // 精细磨皮滑动条默认参数
#define SkinPreciseTendernessValue 0 // 精细粉嫩滑动条默认参数
#define SkinHighlightValue 0 // 立体滑动条默认参数
#define SkinDarkCircleValue 0 // 黑眼圈滑动条默认参数
#define SkinCrowsFeetValue 0 // 鱼尾纹滑动条默认参数
#define SkinNasolabialFoldValue 0 // 法令纹滑动条默认参数

#define EyeMagnifyingValue 60 // 大眼滑动条默认参数
#define ChinSlimmingValue 60 // 瘦脸滑动条默认参数
//脸部
#define FaceNarrowingValue 15 // 窄脸滑动条默认参数
#define JawTransformingValue 0 // 下巴滑动条默认参数
#define ForeheadTransformingValue 0 // 额头滑动条默认参数
#define CheekboneSlimmingValue 0 // 瘦颧骨滑动条默认参数
#define JawboneSlimmingValue 0 // 瘦下颌滑动条默认参数
#define JawSlimmingValue 0 // 削下巴滑动条默认参数
//眼部
#define EyeInnerCornersValue 0 // 内眼角滑动条默认参数
#define EyeOuterCornersValue 0 // 外眼尾滑动条默认参数
#define EyeSpacingValue 0 // 眼间距滑动条默认参数
#define EyeCornersValue 0 // 倾斜滑动条默认参数
//鼻子
#define NoseMinifyingValue 0 // 瘦鼻滑动条默认参数
#define NoseElongatingValue 0 // 长鼻滑动条默认参数
//嘴巴
#define MouthTransformingValue 0 // 嘴型滑动条默认参数
#define MouthHeightValue 0 // 嘴高低滑动条默认参数
#define MouthLipSizeValue 0 // 唇厚薄滑动条默认参数
#define MouthSmilingValue 0 // 扬嘴角滑动条默认参数
//眉毛
#define BrowHeightValue 0 // 眉高低滑动条默认参数
#define BrowLengthValue 0 // 眉长短滑动条默认参数
#define BrowSpaceValue 0 // 眉间距滑动条默认参数
#define BrowSizeValue 0 // 眉粗细滑动条默认参数
#define BrowCornerValue 0 // 提眉峰滑动条默认参数

#define FilterValue 100 // 滤镜滑动条默认参数

#define OnewKeyBeautyValue 100 // 一键美颜
#define FaceShapeBeautyValue 100 // 脸型

#define LongLegValue 0 // 长腿默认参数
#define SlimBodyValue 0 // 瘦身默认参数

#endif /* TI_PS_CONFIG_H */
