//
//  TiPSSetSDKParameters.h
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

// 全局变量——用于判断是否同步滤镜
extern bool is_updatePSFilterValue;

@interface TiPSSetSDKParameters : NSObject

#pragma mark -- UI保存参数时使用到的键值枚举
typedef NS_ENUM(NSInteger, TiUIDataCategoryKey) {
    
    TI_UIDCK_ONEKEY_SLIDER = 100, // 一键美颜
    TI_UIDCK_ONEKEY_POSITION = 199, // 一键美颜选中位置
    
    TI_UIDCK_SKIN_WHITENING_SLIDER = 200, // 美白滑动条
    TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER = 201, // 磨皮滑动条
    TI_UIDCK_SKIN_TENDERNESS_SLIDER = 202, // 粉嫩滑动条
    TI_UIDCK_SKIN_SKINBRIGGT_SLIDER = 203, // 清晰滑动条
    TI_UIDCK_SKIN_BRIGHTNESS_SLIDER = 204, // 亮度滑动条
    
    TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER = 205, // 精细磨皮滑动条
    TI_UIDCK_SKIN_PRECISE_TENDERNESS_SLIDER = 206, // 精细粉嫩滑动条
    TI_UIDCK_SKIN_HIGH_LIGHT_SLIDER = 207, // 立体滑动条
    TI_UIDCK_SKIN_DARK_CIRCLE_SLIDER = 208, // 黑眼圈滑动条
    TI_UIDCK_SKIN_CROWS_FEET_SLIDER = 209, // 鱼尾纹滑动条
    TI_UIDCK_SKIN_NASOLABIAL_FOLD_SLIDER = 210, // 法令纹滑动条
    
    TI_UIDCK_FACESHAPE_SLIDER = 300, // 脸型
    TI_UIDCK_FACESHAPE_POSITION = 399, // 脸型选中位置
    
    TI_UIDCK_EYEMAGNIFYING_SLIDER = 400, // 大眼滑动条
    TI_UIDCK_CHINSLIMMING_SLIDER = 401, // 瘦脸滑动条
    // 脸部
    TI_UIDCK_FACENARROWING_SLIDER = 402, // 窄脸滑动条
    TI_UIDCK_JAWTRANSFORMING_SLIDER = 403, // 下巴滑动条
    TI_UIDCK_FOREHEADTRANSFORMING_SLIDER = 404, // 额头滑动条
    TI_UIDCK_CHEEKBONESLIMMING_SLIDER = 405, // 瘦颧骨滑动条
    TI_UIDCK_JAWBONESLIMMING_SLIDER = 406, // 瘦下颌滑动条
    TI_UIDCK_JAWSLIMMING_SLIDER = 407, // 削下巴滑动条
    // 眼部
    TI_UIDCK_EYEINNERCORNERS_SLIDER = 408, // 内眼角滑动条
    TI_UIDCK_EYEOUTERCORNERS_SLIDER = 409, //外眼尾滑动条
    TI_UIDCK_EYESPACING_SLIDER = 410, // 眼间距滑动条
    TI_UIDCK_EYECORNERS_SLIDER = 411, // 倾斜滑动条
    // 鼻子
    TI_UIDCK_NOSEMINIFYING_SLIDER = 412, // 瘦鼻滑动条
    TI_UIDCK_NOSEELONGATING_SLIDER = 413, // 长鼻滑动条
    // 嘴巴
    TI_UIDCK_MOUTHTRANSFORMING_SLIDER = 414, // 嘴型滑动条
    TI_UIDCK_MOUTHHEIGHT_SLIDER = 415, // 嘴高低滑动条
    TI_UIDCK_MOUTHLIPSIZE_SLIDER = 416, // 唇厚薄滑动条
    TI_UIDCK_MOUTHSMILING_SLIDER = 417, // 扬嘴角滑动条
    // 眉毛
    TI_UIDCK_BROWHEIGHT_SLIDER = 418, // 眉高低滑动条
    TI_UIDCK_BROWLENGTH_SLIDER = 419, // 眉长短滑动条
    TI_UIDCK_BROWSPACE_SLIDER = 420, // 眉间距滑动条
    TI_UIDCK_BROWSIZE_SLIDER = 421, // 眉粗细滑动条
    TI_UIDCK_BROWCORNER_SLIDER = 422, // 提眉峰滑动条
    
    TI_UIDCK_FILTER0_SLIDER = 500,// 原图滤镜滑动条
    // 自然
    TI_UIDCK_FILTER1_SLIDER = 502,// 素颜滤镜滑动条
    TI_UIDCK_FILTER2_SLIDER = 503,// 绯樱滤镜滑动条
    TI_UIDCK_FILTER3_SLIDER = 504,// 浅杏滤镜滑动条
    TI_UIDCK_FILTER4_SLIDER = 505,// 蔷薇滤镜滑动条
    TI_UIDCK_FILTER5_SLIDER = 506,// 青柠滤镜滑动条
    TI_UIDCK_FILTER6_SLIDER = 507,// 珍珠滤镜滑动条
    TI_UIDCK_FILTER7_SLIDER = 508,// 暖春滤镜滑动条
    // 清透
    TI_UIDCK_FILTER8_SLIDER = 510,// 清晰滤镜滑动条
    TI_UIDCK_FILTER9_SLIDER = 511,// 牛奶滤镜滑动条
    TI_UIDCK_FILTER10_SLIDER = 512,// 水雾滤镜滑动条
    TI_UIDCK_FILTER11_SLIDER = 513,// 盐系滤镜滑动条
    TI_UIDCK_FILTER12_SLIDER = 514,// 水光滤镜滑动条
    TI_UIDCK_FILTER13_SLIDER = 515,// 奶杏滤镜滑动条
    // 元气
    TI_UIDCK_FILTER14_SLIDER = 517,// 少女滤镜滑动条
    TI_UIDCK_FILTER15_SLIDER = 518,// 白桃滤镜滑动条
    TI_UIDCK_FILTER16_SLIDER = 519,// 日系滤镜滑动条
    TI_UIDCK_FILTER17_SLIDER = 520,// 粉夏滤镜滑动条
    TI_UIDCK_FILTER18_SLIDER = 521,// 甜美滤镜滑动条
    TI_UIDCK_FILTER19_SLIDER = 522,// 奶油滤镜滑动条
    TI_UIDCK_FILTER20_SLIDER = 523,// 日杂滤镜滑动条
    TI_UIDCK_FILTER21_SLIDER = 524,// 奶油蜜桃滤镜滑动条
    TI_UIDCK_FILTER22_SLIDER = 525,// 橘子汽水滤镜滑动条
    // 高级
    TI_UIDCK_FILTER23_SLIDER = 527,// 灰调滤镜滑动条
    TI_UIDCK_FILTER24_SLIDER = 528,// 冷淡滤镜滑动条
    TI_UIDCK_FILTER25_SLIDER = 529,// 花颜滤镜滑动条
    TI_UIDCK_FILTER26_SLIDER = 530,// 质感滤镜滑动条
    TI_UIDCK_FILTER27_SLIDER = 531,// 济州滤镜滑动条
    // 氛围
    TI_UIDCK_FILTER28_SLIDER = 533,// 油画1滤镜滑动条
    TI_UIDCK_FILTER29_SLIDER = 534,// 油画2滤镜滑动条
    TI_UIDCK_FILTER30_SLIDER = 535,// 森系滤镜滑动条
    TI_UIDCK_FILTER31_SLIDER = 536,// 仲夏梦滤镜滑动条
    // 美食
    TI_UIDCK_FILTER32_SLIDER = 538,// 美味滤镜滑动条
    TI_UIDCK_FILTER33_SLIDER = 539,// 新鲜滤镜滑动条
    TI_UIDCK_FILTER34_SLIDER = 540,// 蜜糖乌龙滤镜滑动条
    TI_UIDCK_FILTER35_SLIDER = 541,// 暖食滤镜滑动条
    TI_UIDCK_FILTER36_SLIDER = 542,// 深夜食堂滤镜滑动条
    // 假日
    TI_UIDCK_FILTER37_SLIDER = 544,// 夏日滤镜滑动条
    TI_UIDCK_FILTER38_SLIDER = 545,// 暖阳滤镜滑动条
    TI_UIDCK_FILTER39_SLIDER = 546,// 昭和滤镜滑动条
    TI_UIDCK_FILTER40_SLIDER = 547,// 波士顿滤镜滑动条
    // 胶片
    TI_UIDCK_FILTER41_SLIDER = 549,// 拍立得滤镜滑动条
    TI_UIDCK_FILTER42_SLIDER = 550,// 回忆滤镜滑动条
    TI_UIDCK_FILTER43_SLIDER = 551,// 反差色滤镜滑动条
    TI_UIDCK_FILTER44_SLIDER = 552,// 复古滤镜滑动条
    TI_UIDCK_FILTER45_SLIDER = 553,// 怀旧滤镜滑动条
    TI_UIDCK_FILTER46_SLIDER = 554,// 黑白滤镜滑动条
    TI_UIDCK_FILTER_POSITION = 599,// 滤镜选中位置
    
    // 修图
    TI_UIDCK_LONGLEG_SLIDER = 901,// 长腿滑动条
    TI_UIDCK_SLIMBODY_SLIDER = 902,// 瘦身滑动条
    
};

// 保存key float值
+ (void)setPSFloatValue:(float)value forKey:(TiUIDataCategoryKey)key;
// 获取key float值
+ (float)getPSFloatValueForKey:(TiUIDataCategoryKey)key;

+ (void)initSDK;

+ (void)setPSBeautySlider:(float)v forKey:(TiUIDataCategoryKey)key withIndex:(NSInteger)index;

+ (void)setOneKeyBeautySlider:(float)v Index:(NSInteger)index;
+ (void)setFaceShapeBeautySlider:(float)v Index:(NSInteger)index;

@end
