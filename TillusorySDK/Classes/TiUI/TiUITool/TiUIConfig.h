//
//  TiUIConfig.h
//  TiFancy
//
//  Created by Itachi Uchiha on 2021/8/11.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//
#ifndef _TEST_H_
#define _TEST_H_

#import <TiSDK/TiLiveView.h>
#import <TiSDK/TiSDKInterface.h>
#import <Masonry/Masonry.h>
#import "TiMenuPlistManager.h"
#import "TiUIAdapter.h"
#import "TiUIManager.h"

@interface TiUIConfig : NSObject

#pragma mark -- UI保存参数时使用到的键值枚举
typedef NS_ENUM(NSInteger, TiUIDataCategoryKey) {
    
    /* =================== 美颜 =================== */
    TI_UIDCK_SKIN_WHITENING_SLIDER = 100, // 美白滑动条
    TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER = 101, // 磨皮滑动条
    TI_UIDCK_SKIN_TENDERNESS_SLIDER = 102, // 粉嫩滑动条
    TI_UIDCK_SKIN_SKINBRIGGT_SLIDER = 103, // 清晰滑动条
    TI_UIDCK_SKIN_BRIGHTNESS_SLIDER = 104, // 亮度滑动条
    TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER = 105, // 精细磨皮滑动条
    TI_UIDCK_SKIN_PRECISE_TENDERNESS_SLIDER = 106, // 精细粉嫩滑动条
    TI_UIDCK_SKIN_HIGH_LIGHT_SLIDER = 107, // 立体滑动条
    TI_UIDCK_SKIN_DARK_CIRCLE_SLIDER = 108, // 黑眼圈滑动条
    TI_UIDCK_SKIN_CROWS_FEET_SLIDER = 109, // 鱼尾纹滑动条
    TI_UIDCK_SKIN_NASOLABIAL_FOLD_SLIDER = 110, // 法令纹滑动条
    
    /* =================== 美型 =================== */
    TI_UIDCK_EYEMAGNIFYING_SLIDER = 200, // 大眼滑动条
    TI_UIDCK_CHINSLIMMING_SLIDER = 201, // 瘦脸滑动条
    // 脸部
    TI_UIDCK_FACENARROWING_SLIDER = 202, // 窄脸滑动条
    TI_UIDCK_JAWTRANSFORMING_SLIDER = 203, // 下巴滑动条
    TI_UIDCK_FOREHEADTRANSFORMING_SLIDER = 204, // 额头滑动条
    TI_UIDCK_CHEEKBONESLIMMING_SLIDER = 205, // 瘦颧骨滑动条
    TI_UIDCK_JAWBONESLIMMING_SLIDER = 206, // 瘦下颌滑动条
    TI_UIDCK_JAWSLIMMING_SLIDER = 207, // 削下巴滑动条
    // 眼部
    TI_UIDCK_EYEINNERCORNERS_SLIDER = 208, // 内眼角滑动条
    TI_UIDCK_EYEOUTERCORNERS_SLIDER = 209, //外眼尾滑动条
    TI_UIDCK_EYESPACING_SLIDER = 210, // 眼间距滑动条
    TI_UIDCK_EYECORNERS_SLIDER = 211, // 倾斜滑动条
    // 鼻子
    TI_UIDCK_NOSEMINIFYING_SLIDER = 212, // 瘦鼻滑动条
    TI_UIDCK_NOSEELONGATING_SLIDER = 213, // 长鼻滑动条
    // 嘴巴
    TI_UIDCK_MOUTHTRANSFORMING_SLIDER = 214, // 嘴型滑动条
    TI_UIDCK_MOUTHHEIGHT_SLIDER = 215, // 嘴高低滑动条
    TI_UIDCK_MOUTHLIPSIZE_SLIDER = 216, // 唇厚薄滑动条
    TI_UIDCK_MOUTHSMILING_SLIDER = 217, // 扬嘴角滑动条
    // 眉毛
    TI_UIDCK_BROWHEIGHT_SLIDER = 218, // 眉高低滑动条
    TI_UIDCK_BROWLENGTH_SLIDER = 219, // 眉长短滑动条
    TI_UIDCK_BROWSPACE_SLIDER = 220, // 眉间距滑动条
    TI_UIDCK_BROWSIZE_SLIDER = 221, // 眉粗细滑动条
    TI_UIDCK_BROWCORNER_SLIDER = 222, // 提眉峰滑动条
    
    /* =================== 滤镜 =================== */
    TI_UIDCK_FILTER0_SLIDER = 300,// 原图滤镜滑动条
    // 自然
    TI_UIDCK_FILTER1_SLIDER = 302,// 素颜滤镜滑动条
    TI_UIDCK_FILTER2_SLIDER = 303,// 绯樱滤镜滑动条
    TI_UIDCK_FILTER3_SLIDER = 304,// 浅杏滤镜滑动条
    TI_UIDCK_FILTER4_SLIDER = 305,// 蔷薇滤镜滑动条
    TI_UIDCK_FILTER5_SLIDER = 306,// 青柠滤镜滑动条
    TI_UIDCK_FILTER6_SLIDER = 307,// 珍珠滤镜滑动条
    TI_UIDCK_FILTER7_SLIDER = 308,// 暖春滤镜滑动条
    // 清透
    TI_UIDCK_FILTER8_SLIDER = 310,// 清晰滤镜滑动条
    TI_UIDCK_FILTER9_SLIDER = 311,// 牛奶滤镜滑动条
    TI_UIDCK_FILTER10_SLIDER = 312,// 水雾滤镜滑动条
    TI_UIDCK_FILTER11_SLIDER = 313,// 盐系滤镜滑动条
    TI_UIDCK_FILTER12_SLIDER = 314,// 水光滤镜滑动条
    TI_UIDCK_FILTER13_SLIDER = 315,// 奶杏滤镜滑动条
    // 元气
    TI_UIDCK_FILTER14_SLIDER = 317,// 少女滤镜滑动条
    TI_UIDCK_FILTER15_SLIDER = 318,// 白桃滤镜滑动条
    TI_UIDCK_FILTER16_SLIDER = 319,// 日系滤镜滑动条
    TI_UIDCK_FILTER17_SLIDER = 320,// 粉夏滤镜滑动条
    TI_UIDCK_FILTER18_SLIDER = 321,// 甜美滤镜滑动条
    TI_UIDCK_FILTER19_SLIDER = 322,// 奶油滤镜滑动条
    TI_UIDCK_FILTER20_SLIDER = 323,// 日杂滤镜滑动条
    TI_UIDCK_FILTER21_SLIDER = 324,// 奶油蜜桃滤镜滑动条
    TI_UIDCK_FILTER22_SLIDER = 325,// 橘子汽水滤镜滑动条
    // 高级
    TI_UIDCK_FILTER23_SLIDER = 327,// 灰调滤镜滑动条
    TI_UIDCK_FILTER24_SLIDER = 328,// 冷淡滤镜滑动条
    TI_UIDCK_FILTER25_SLIDER = 329,// 花颜滤镜滑动条
    TI_UIDCK_FILTER26_SLIDER = 330,// 质感滤镜滑动条
    TI_UIDCK_FILTER27_SLIDER = 331,// 济州滤镜滑动条
    // 氛围
    TI_UIDCK_FILTER28_SLIDER = 333,// 油画1滤镜滑动条
    TI_UIDCK_FILTER29_SLIDER = 334,// 油画2滤镜滑动条
    TI_UIDCK_FILTER30_SLIDER = 335,// 森系滤镜滑动条
    TI_UIDCK_FILTER31_SLIDER = 336,// 仲夏梦滤镜滑动条
    // 美食
    TI_UIDCK_FILTER32_SLIDER = 338,// 美味滤镜滑动条
    TI_UIDCK_FILTER33_SLIDER = 339,// 新鲜滤镜滑动条
    TI_UIDCK_FILTER34_SLIDER = 340,// 蜜糖乌龙滤镜滑动条
    TI_UIDCK_FILTER35_SLIDER = 341,// 暖食滤镜滑动条
    TI_UIDCK_FILTER36_SLIDER = 342,// 深夜食堂滤镜滑动条
    // 假日
    TI_UIDCK_FILTER37_SLIDER = 344,// 夏日滤镜滑动条
    TI_UIDCK_FILTER38_SLIDER = 345,// 暖阳滤镜滑动条
    TI_UIDCK_FILTER39_SLIDER = 346,// 昭和滤镜滑动条
    TI_UIDCK_FILTER40_SLIDER = 347,// 波士顿滤镜滑动条
    // 胶片
    TI_UIDCK_FILTER41_SLIDER = 349,// 拍立得滤镜滑动条
    TI_UIDCK_FILTER42_SLIDER = 350,// 回忆滤镜滑动条
    TI_UIDCK_FILTER43_SLIDER = 351,// 反差色滤镜滑动条
    TI_UIDCK_FILTER44_SLIDER = 352,// 复古滤镜滑动条
    TI_UIDCK_FILTER45_SLIDER = 353,// 怀旧滤镜滑动条
    TI_UIDCK_FILTER46_SLIDER = 354,// 黑白滤镜滑动条
    TI_UIDCK_FILTER_POSITION = 399,// 滤镜选中位置
    
    TI_UIDCK_ONEKEY_SLIDER = 400, // 一键美颜
    TI_UIDCK_ONEKEY_POSITION = 499, // 一键美颜选中位置
    
    TI_UIDCK_FACESHAPE_SLIDER = 500, // 脸型
    TI_UIDCK_FACESHAPE_POSITION = 599, // 脸型选中位置
    
    TI_UIDCK_HAIRDRESS_SLIDER = 600, // 美发
    
    TI_UIDCK_SIMILARITY_SLIDER = 701, // 绿幕-相似度
    TI_UIDCK_SMOOTH_SLIDER = 702, // 绿幕-平滑度
    TI_UIDCK_HYALINE_SLIDER = 703, // 绿幕-透明度
    
    TI_UIDCK_CheekRed_SLIDER = 1000, // 美妆-腮红
    //    TI_UIDCK_Eyelash_SLIDER = 2000, // 美妆-睫毛
    TI_UIDCK_Eyebrows_SLIDER = 2000, // 美妆-眉毛
    TI_UIDCK_Eyeshadow_SLIDER = 3000, // 美妆-眼影
    TI_UIDCK_LipGloss_SLIDER = 4000, // 美妆-唇彩
    //    TI_UIDCK_Eyeline_SLIDER = 5000, // 美妆-眼线
    
};

@end

#endif


// UI版本号
#define TiUICurrentVersion @"1.7"

#ifndef TI_UI_CONFIG_H
#define TI_UI_CONFIG_H

// 屏幕宽高
#define TiUIScreenWidth [[UIScreen mainScreen] bounds].size.width
#define TiUIScreenHeight [[UIScreen mainScreen] bounds].size.height

// 点击子菜单总开关按钮发出的通知
#define NotificationCenterSubMenuOnTotalSwitch @"NotificationCenterSubMenuOnTotalSwitch"

#define WeakSelf __weak typeof(self) weakSelf = self;

#define getSafeBottomHeight ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom)
#define getSafeBottomHeight2 ([[[UIApplication sharedApplication] delegate] window].safeAreaInsets.bottom)

// 短视频录制相关
#define RecordLimitTime 15.0           //最长录制时间
#define TimerInterval 0.01         //计时器刷新频率
#define TiVideoFolder @"videoFolder" //视频录制存放文件夹

// 英文字体
#define TiFontHelvetica(s) [UIFont fontWithName:@"Helvetica" size:s]
#define TiFontHelveticaSmall [UIFont fontWithName:@"Helvetica" size:10]
#define TiFontHelveticaMedium [UIFont fontWithName:@"Helvetica" size:12]
#define TiFontHelveticaBig [UIFont fontWithName:@"Helvetica" size:14]
// 中文字体
#define TiFontRegular(s) [UIFont fontWithName:@"PingFang-SC-Regular" size:s]
#define TiFontMedium(s) [UIFont fontWithName:@"PingFang-SC-Medium" size:s]

// 颜色
#define TiColor(r,g,b,a) [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:(a)]
#define TiColors(s,a) [UIColor colorWithRed:((s) / 255.0) green:((s) / 255.0) blue:((s) / 255.0) alpha:(a)]

// 不同比例对应的背景高度
#define TiPhotoSize11Height TiUIScreenWidth
#define TiPhotoSize34Height (TiUIScreenWidth*4/3)
#define TiPhotoSizeFullHeight TiUIScreenHeight

#define navigationView11Height ([[TiUIAdapter shareInstance] heightAfterAdaptionByRawHeight:107] + [[TiUIAdapter shareInstance] statusBarHeightAfterAdaption])
#define navigationView34Height ([[TiUIAdapter shareInstance] heightAfterAdaptionByRawHeight:50] + [[TiUIAdapter shareInstance] statusBarHeightAfterAdaption])
#define navigationViewFullHeight 0

#define bottomView11Height (TiUIScreenHeight - navigationView11Height - TiPhotoSize11Height)
#define bottomView34Height (TiUIScreenHeight - navigationView34Height - TiPhotoSize34Height)
#define bottomViewFullHeight 0

// MARK: --默认按钮的宽度(以拍照按钮为基准) TiUIDefaultButtonView--
#define TiDefaultButtonWidth TiUIScreenWidth/4

// MARK:  滑动条View --TiUISliderRelatedView--
#define TiUISliderRelatedViewHeight [[TiUIAdapter shareInstance] heightAfterAdaptionByRawHeight:64]

// MARK:  菜单View高度
#define TiUIMenuViewHeight [[TiUIAdapter shareInstance] heightAfterAdaptionByRawHeight:40]

// MARK:  右边返回按钮View宽度
#define TiUIBackViewWidth [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:55]

// MARK: --美颜弹框视图总高度 TiUIManager--
#define TiUIViewBoxTotalHeight ([[TiUIAdapter shareInstance] heightAfterAdaptionByRawHeight:224] + TiUISliderRelatedViewHeight)

// MARK:  滑块View --TiUISliderView--
#define TiUISlideBarHeight [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:3]
#define TiUISliderViewWidth [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:33]
#define TiUISliderViewHeight [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:41]
#define TiUISliderSize [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:20]
#define TiUISplitPointSize [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:7]

// MARK:  子菜单状态1View --TiUISubMenuOneView--
#define TiUISubMenuOneViewTiButtonWidth [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:46]
#define TiUISubMenuOneViewTiButtonHeight [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:66]

#define TiUISubMenuTwoViewTiButtonWidth [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:60]
#define TiUISubMenuTwoViewTiButtonHeight [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:76]

#define TiUISubMenuThreeViewTiButtonWidth [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:62]
#define TiUISubMenuThreeViewTiButtonHeight [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:62]

#define TiUISubMenuMakeUpViewTiButtonWidth [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:62]
#define TiUISubMenuMakeUpViewTiButtonHeight [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:70]

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
// 脸部
#define FaceNarrowingValue 15 // 窄脸滑动条默认参数
#define JawTransformingValue 0 // 下巴滑动条默认参数
#define ForeheadTransformingValue 0 // 额头滑动条默认参数
#define CheekboneSlimmingValue 0 // 瘦颧骨滑动条默认参数
#define JawboneSlimmingValue 0 // 瘦下颌滑动条默认参数
#define JawSlimmingValue 0 // 削下巴滑动条默认参数
// 眼部
#define EyeInnerCornersValue 0 // 内眼角滑动条默认参数
#define EyeOuterCornersValue 0 // 外眼尾滑动条默认参数
#define EyeSpacingValue 0 // 眼间距滑动条默认参数
#define EyeCornersValue 0 // 倾斜滑动条默认参数
// 鼻子
#define NoseMinifyingValue 0 // 瘦鼻滑动条默认参数
#define NoseElongatingValue 0 // 长鼻滑动条默认参数
// 嘴巴
#define MouthTransformingValue 0 // 嘴型滑动条默认参数
#define MouthHeightValue 0 // 嘴高低滑动条默认参数
#define MouthLipSizeValue 0 // 唇厚薄滑动条默认参数
#define MouthSmilingValue 0 // 扬嘴角滑动条默认参数
// 眉毛
#define BrowHeightValue 0 // 眉高低滑动条默认参数
#define BrowLengthValue 0 // 眉长短滑动条默认参数
#define BrowSpaceValue 0 // 眉间距滑动条默认参数
#define BrowSizeValue 0 // 眉粗细滑动条默认参数
#define BrowCornerValue 0 // 提眉峰滑动条默认参数

#define FilterValue 100 // 滤镜滑动条默认参数

#define OnewKeyBeautyValue 100 // 一键美颜
#define FaceShapeBeautyValue 100 // 脸型

#define SimilarityValue 0 //相似度滑动条默认参数
#define SmoothnessValue 0 //平滑度滑动条默认参数
#define AlphaValue 0 //透明度滑动条默认参数

#define CheekRedValue 100 //腮红默认参数
//#define EyelashValue 100 //睫毛默认参数
#define EyebrowsValue 100 //眉毛默认参数
#define EyeshadowValue 100 //眼影默认参数
//#define EyelineValue 100 //眼线默认参数
#define LipGlossValue 100 //唇彩默认参数

#define HairdressValue 100 //美发滑动条默认参数

#endif /* TI_UI_CONFIG_H */
 
