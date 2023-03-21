//
//  TiPSSetSDKParameters.m
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSSetSDKParameters.h"
#import "TiPSConfig.h"

bool is_updatePSFilter = false;
bool is_updatePSFilterValue = false;

@implementation TiPSSetSDKParameters

+ (void)initSDK{
    
    [TiPSSetSDKParameters setPSFloatValue:OnewKeyBeautyValue forKey:TI_UIDCK_ONEKEY_SLIDER];
    
    // 美白指定初始值
    [TiPSSetSDKParameters setPSFloatValue:SkinWhiteningValue forKey:TI_UIDCK_SKIN_WHITENING_SLIDER];
    [[TiSDKManager shareManager] setSkinWhitening:SkinWhiteningValue];
    
    // 磨皮指定初始值
    [TiPSSetSDKParameters setPSFloatValue:SkinBlemishRemovalValue forKey:TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER];
    [[TiSDKManager shareManager] setSkinBlemishRemoval:SkinBlemishRemovalValue];
    
    // 粉嫩
    [TiPSSetSDKParameters setPSFloatValue:SkinTendernessValue forKey:TI_UIDCK_SKIN_TENDERNESS_SLIDER];
    [[TiSDKManager shareManager] setSkinTenderness:SkinTendernessValue];
    
    // 清晰
    [TiPSSetSDKParameters setPSFloatValue:SkinBrightValue forKey:TI_UIDCK_SKIN_SKINBRIGGT_SLIDER];
    [[TiSDKManager shareManager] setSkinSharpness:SkinBrightValue];
    
    // 亮度
    [TiPSSetSDKParameters setPSFloatValue:SkinBrightnessValue forKey:TI_UIDCK_SKIN_BRIGHTNESS_SLIDER];
    [[TiSDKManager shareManager] setSkinBrightness:SkinBrightnessValue];
    
    // 精细磨皮指定初始值
    [TiPSSetSDKParameters setPSFloatValue:SkinPreciseBeautyValue forKey:TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER];
    [[TiSDKManager shareManager] setSkinPreciseBeauty:SkinPreciseBeautyValue];
    
    // 精细粉嫩指定初始值
    [TiPSSetSDKParameters setPSFloatValue:SkinPreciseTendernessValue forKey:TI_UIDCK_SKIN_PRECISE_TENDERNESS_SLIDER];
    [[TiSDKManager shareManager] setPreciseTenderness:SkinPreciseTendernessValue];
    
    // 立体指定初始值
    [TiPSSetSDKParameters setPSFloatValue:SkinHighlightValue forKey:TI_UIDCK_SKIN_HIGH_LIGHT_SLIDER];
    [[TiSDKManager shareManager] setHighlight:SkinHighlightValue];
    
    // 黑眼圈指定初始值
    [TiPSSetSDKParameters setPSFloatValue:SkinDarkCircleValue forKey:TI_UIDCK_SKIN_DARK_CIRCLE_SLIDER];
    [[TiSDKManager shareManager] setDarkCircle:SkinDarkCircleValue];
    
    // 鱼尾纹指定初始值
    [TiPSSetSDKParameters setPSFloatValue:SkinCrowsFeetValue forKey:TI_UIDCK_SKIN_CROWS_FEET_SLIDER];
    [[TiSDKManager shareManager] setCrowsFeet:SkinCrowsFeetValue];
    
    // 法令纹指定初始值
    [TiPSSetSDKParameters setPSFloatValue:SkinNasolabialFoldValue forKey:TI_UIDCK_SKIN_NASOLABIAL_FOLD_SLIDER];
    [[TiSDKManager shareManager] setNasolabialFold:SkinNasolabialFoldValue];
    
    [TiPSSetSDKParameters setPSFloatValue:FaceShapeBeautyValue forKey:TI_UIDCK_FACESHAPE_SLIDER];
    
    //    ------------------------------------------
    
    // 大眼
    [TiPSSetSDKParameters setPSFloatValue:EyeMagnifyingValue forKey:TI_UIDCK_EYEMAGNIFYING_SLIDER];
    [[TiSDKManager shareManager] setEyeMagnifying:EyeMagnifyingValue];
    // 瘦脸
    [TiPSSetSDKParameters setPSFloatValue:ChinSlimmingValue forKey:TI_UIDCK_CHINSLIMMING_SLIDER];
    [[TiSDKManager shareManager] setChinSlimming:ChinSlimmingValue];
    // 窄脸
    [TiPSSetSDKParameters setPSFloatValue:FaceNarrowingValue forKey:TI_UIDCK_FACENARROWING_SLIDER];
    [[TiSDKManager shareManager] setFaceNarrowing:FaceNarrowingValue];
    // 脸部
    // 瘦颧骨
    [TiPSSetSDKParameters setPSFloatValue:CheekboneSlimmingValue forKey:TI_UIDCK_CHEEKBONESLIMMING_SLIDER];
    [[TiSDKManager shareManager] setCheekboneSlimming:CheekboneSlimmingValue];
    // 瘦下颌
    [TiPSSetSDKParameters setPSFloatValue:JawboneSlimmingValue forKey:TI_UIDCK_JAWBONESLIMMING_SLIDER];
    [[TiSDKManager shareManager] setJawboneSlimming:JawboneSlimmingValue];
    // 下巴
    [TiPSSetSDKParameters setPSFloatValue:JawTransformingValue forKey:TI_UIDCK_JAWTRANSFORMING_SLIDER];
    [[TiSDKManager shareManager] setJawTransforming:JawTransformingValue];
    // 削下巴
    [TiPSSetSDKParameters setPSFloatValue:JawSlimmingValue forKey:TI_UIDCK_JAWSLIMMING_SLIDER];
    [[TiSDKManager shareManager] setJawSlimming:JawSlimmingValue];
    // 额头
    [TiPSSetSDKParameters setPSFloatValue:ForeheadTransformingValue forKey:TI_UIDCK_FOREHEADTRANSFORMING_SLIDER];
    [[TiSDKManager shareManager] setForeheadTransforming:ForeheadTransformingValue];
    // 眼部
    // 内眼角
    [TiPSSetSDKParameters setPSFloatValue:EyeInnerCornersValue forKey:TI_UIDCK_EYEINNERCORNERS_SLIDER];
    [[TiSDKManager shareManager] setEyeInnerCorners:EyeInnerCornersValue];
    // 外眼尾
    [TiPSSetSDKParameters setPSFloatValue:EyeOuterCornersValue forKey:TI_UIDCK_EYEOUTERCORNERS_SLIDER];
    [[TiSDKManager shareManager] setEyeOuterCorners:EyeOuterCornersValue];
    // 眼间距
    [TiPSSetSDKParameters setPSFloatValue:EyeSpacingValue forKey:TI_UIDCK_EYESPACING_SLIDER];
    [[TiSDKManager shareManager] setEyeSpacing:EyeSpacingValue];
    // 倾斜
    [TiPSSetSDKParameters setPSFloatValue:EyeCornersValue forKey:TI_UIDCK_EYECORNERS_SLIDER];
    [[TiSDKManager shareManager] setEyeCorners:EyeCornersValue];
    // 鼻子
    // 瘦鼻
    [TiPSSetSDKParameters setPSFloatValue:NoseMinifyingValue forKey:TI_UIDCK_NOSEMINIFYING_SLIDER];
    [[TiSDKManager shareManager] setNoseMinifying:NoseMinifyingValue];
    // 长鼻
    [TiPSSetSDKParameters setPSFloatValue:NoseElongatingValue forKey:TI_UIDCK_NOSEELONGATING_SLIDER];
    [[TiSDKManager shareManager] setNoseElongating:NoseElongatingValue];
    // 嘴巴
    // 嘴型
    [TiPSSetSDKParameters setPSFloatValue:MouthTransformingValue forKey:TI_UIDCK_MOUTHTRANSFORMING_SLIDER];
    [[TiSDKManager shareManager] setMouthTransforming:MouthTransformingValue];
    // 嘴高低
    [TiPSSetSDKParameters setPSFloatValue:MouthHeightValue forKey:TI_UIDCK_MOUTHHEIGHT_SLIDER];
    [[TiSDKManager shareManager] setMouthHeight:MouthHeightValue];
    // 唇厚薄
    [TiPSSetSDKParameters setPSFloatValue:MouthLipSizeValue forKey:TI_UIDCK_MOUTHLIPSIZE_SLIDER];
    [[TiSDKManager shareManager] setMouthLipSize:MouthLipSizeValue];
    // 扬嘴角
    [TiPSSetSDKParameters setPSFloatValue:MouthSmilingValue forKey:TI_UIDCK_MOUTHSMILING_SLIDER];
    [[TiSDKManager shareManager] setMouthSmiling:MouthSmilingValue];
    // 眉毛
    // 眉高低
    [TiPSSetSDKParameters setPSFloatValue:BrowHeightValue forKey:TI_UIDCK_BROWHEIGHT_SLIDER];
    [[TiSDKManager shareManager] setBrowHeight:BrowHeightValue];
    // 眉长短
    [TiPSSetSDKParameters setPSFloatValue:BrowLengthValue forKey:TI_UIDCK_BROWLENGTH_SLIDER];
    [[TiSDKManager shareManager] setBrowLength:BrowLengthValue];
    // 眉间距
    [TiPSSetSDKParameters setPSFloatValue:BrowSpaceValue forKey:TI_UIDCK_BROWSPACE_SLIDER];
    [[TiSDKManager shareManager] setBrowSpace:BrowSpaceValue];
    // 眉粗细
    [TiPSSetSDKParameters setPSFloatValue:BrowSizeValue forKey:TI_UIDCK_BROWSIZE_SLIDER];
    [[TiSDKManager shareManager] setBrowSize:BrowSizeValue];
    // 提眉峰
    [TiPSSetSDKParameters setPSFloatValue:BrowCornerValue forKey:TI_UIDCK_BROWCORNER_SLIDER];
    [[TiSDKManager shareManager] setBrowCorner:BrowCornerValue];
    
    //    ------------------------------------------
    
    // 滤镜500～554
    for (int key = 500; key <= 554; key++) {
        if (!(key == 501 || key == 509 || key == 516 || key == 526 || key == 532 || key == 537 || key == 543 || key == 548)) {
            [TiPSSetSDKParameters setPSFloatValue:FilterValue forKey:key];
        }
    }
    
    /**
     * 切换滤镜函数
     *
     * @param filterEnum 参考宏定义TiFilterEnum
     */
    [[TiSDKManager shareManager] setBeautyFilter:@"" Param:[TiPSSetSDKParameters getPSFloatValueForKey:TI_UIDCK_FILTER0_SLIDER]];
    
    // 修图
    [TiPSSetSDKParameters setPSFloatValue:LongLegValue forKey:TI_UIDCK_LONGLEG_SLIDER];
    [[TiSDKManager shareManager] setLongLeg:LongLegValue Top:0 Bottom:17];
    [TiPSSetSDKParameters setPSFloatValue:SlimBodyValue forKey:TI_UIDCK_SLIMBODY_SLIDER];
    [[TiSDKManager shareManager] setSlimBody:SlimBodyValue Left:0 Right:17];
    
}

+ (void)setPSFloatValue:(float)value forKey:(TiUIDataCategoryKey)key {
    NSString *keyString = [self getTiPSDataCategoryKey:key];
    if (keyString.length == 0 || keyString == nil) {
        return;
    } else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setInteger:value forKey:keyString];
        [defaults synchronize];
    }
}

+ (float)getPSFloatValueForKey:(TiUIDataCategoryKey)key {
    NSString *keyString = [self getTiPSDataCategoryKey:key];
    if (keyString.length == 0 || keyString == nil) {
        return 0;
    } else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        return [defaults integerForKey:keyString];
    }
}

+ (NSString *)getTiPSDataCategoryKey:(TiUIDataCategoryKey)key {
    switch (key) {
            //            美颜
        case TI_UIDCK_SKIN_WHITENING_SLIDER:// 美白
            return @"TI_UIDCK_SKIN_WHITENING_SLIDER";
            break;
        case TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER:// 磨皮
            return @"TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER";
            break;
        case TI_UIDCK_SKIN_TENDERNESS_SLIDER:// 粉嫩
            return @"TI_UIDCK_SKIN_TENDERNESS_SLIDER";
            break;
        case TI_UIDCK_SKIN_SKINBRIGGT_SLIDER:// 清晰
            return @"TI_UIDCK_SKIN_SKINBRIGGT_SLIDER";
            break;
        case TI_UIDCK_SKIN_BRIGHTNESS_SLIDER:// 亮度
            return @"TI_UIDCK_SKIN_BRIGHTNESS_SLIDER";
            break;
        case TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER:// 精细磨皮
            return @"TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER";
            break;
        case TI_UIDCK_SKIN_PRECISE_TENDERNESS_SLIDER:// 精细粉嫩
            return @"TI_UIDCK_SKIN_PRECISE_TENDERNESS_SLIDER";
            break;
        case TI_UIDCK_SKIN_HIGH_LIGHT_SLIDER:// 立体
            return @"TI_UIDCK_SKIN_HIGH_LIGHT_SLIDER";
            break;
        case TI_UIDCK_SKIN_DARK_CIRCLE_SLIDER:// 黑眼圈
            return @"TI_UIDCK_SKIN_DARK_CIRCLE_SLIDER";
            break;
        case TI_UIDCK_SKIN_CROWS_FEET_SLIDER:// 鱼尾纹
            return @"TI_UIDCK_SKIN_CROWS_FEET_SLIDER";
            break;
        case TI_UIDCK_SKIN_NASOLABIAL_FOLD_SLIDER:// 法令纹
            return @"TI_UIDCK_SKIN_NASOLABIAL_FOLD_SLIDER";
            break;
            //            美型
        case TI_UIDCK_EYEMAGNIFYING_SLIDER:// 大眼
            return @"TI_UIDCK_EYEMAGNIFYING_SLIDER";
            break;
        case TI_UIDCK_CHINSLIMMING_SLIDER:// 瘦脸
            return @"TI_UIDCK_CHINSLIMMING_SLIDER";
            break;
        case TI_UIDCK_FACENARROWING_SLIDER:// 窄脸
            return @"TI_UIDCK_FACENARROWING_SLIDER";
            break;
        case TI_UIDCK_CHEEKBONESLIMMING_SLIDER:// 瘦颧骨
            return @"TI_UIDCK_CHEEKBONESLIMMING_SLIDER";
            break;
        case TI_UIDCK_JAWBONESLIMMING_SLIDER:// 瘦下颌
            return @"TI_UIDCK_JAWBONESLIMMING_SLIDER";
            break;
        case TI_UIDCK_JAWTRANSFORMING_SLIDER:// 下巴
            return @"TI_UIDCK_JAWTRANSFORMING_SLIDER";
            break;
        case TI_UIDCK_JAWSLIMMING_SLIDER:// 削下巴
            return @"TI_UIDCK_JAWSLIMMING_SLIDER";
            break;
        case TI_UIDCK_FOREHEADTRANSFORMING_SLIDER:// 额头
            return @"TI_UIDCK_FOREHEADTRANSFORMING_SLIDER";
            break;
        case TI_UIDCK_EYEINNERCORNERS_SLIDER:// 内眼角
            return @"TI_UIDCK_EYEINNERCORNERS_SLIDER";
            break;
        case TI_UIDCK_EYEOUTERCORNERS_SLIDER:// 外眼尾
            return @"TI_UIDCK_EYEOUTERCORNERS_SLIDER";
            break;
        case TI_UIDCK_EYESPACING_SLIDER:// 眼间距
            return @"TI_UIDCK_EYESPACING_SLIDER";
            break;
        case TI_UIDCK_EYECORNERS_SLIDER:// 倾斜
            return @"TI_UIDCK_EYECORNERS_SLIDER";
            break;
        case TI_UIDCK_NOSEMINIFYING_SLIDER:// 瘦鼻
            return @"TI_UIDCK_NOSEMINIFYING_SLIDER";
            break;
        case TI_UIDCK_NOSEELONGATING_SLIDER:// 长鼻
            return @"TI_UIDCK_NOSEELONGATING_SLIDER";
            break;
        case TI_UIDCK_MOUTHTRANSFORMING_SLIDER:// 嘴型
            return @"TI_UIDCK_MOUTHTRANSFORMING_SLIDER";
            break;
        case TI_UIDCK_MOUTHHEIGHT_SLIDER:// 嘴高低
            return @"TI_UIDCK_MOUTHHEIGHT_SLIDER";
            break;
        case TI_UIDCK_MOUTHLIPSIZE_SLIDER:// 唇厚薄
            return @"TI_UIDCK_MOUTHLIPSIZE_SLIDER";
            break;
        case TI_UIDCK_MOUTHSMILING_SLIDER:// 扬嘴角
            return @"TI_UIDCK_MOUTHSMILING_SLIDER";
            break;
        case TI_UIDCK_BROWHEIGHT_SLIDER:// 眉高低
            return @"TI_UIDCK_BROWHEIGHT_SLIDER";
            break;
        case TI_UIDCK_BROWLENGTH_SLIDER:// 眉长短
            return @"TI_UIDCK_BROWLENGTH_SLIDER";
            break;
        case TI_UIDCK_BROWSPACE_SLIDER:// 眉间距
            return @"TI_UIDCK_BROWSPACE_SLIDER";
            break;
        case TI_UIDCK_BROWSIZE_SLIDER:// 眉粗细
            return @"TI_UIDCK_BROWSIZE_SLIDER";
            break;
        case TI_UIDCK_BROWCORNER_SLIDER:// 提眉峰
            return @"TI_UIDCK_BROWCORNER_SLIDER";
            break;
            //            滤镜
        case TI_UIDCK_FILTER0_SLIDER:
            return @"TI_UIDCK_FILTER0_SLIDER";
            break;
        case TI_UIDCK_FILTER1_SLIDER:
            return @"TI_UIDCK_FILTER1_SLIDER";
            break;
        case TI_UIDCK_FILTER2_SLIDER:
            return @"TI_UIDCK_FILTER2_SLIDER";
            break;
        case TI_UIDCK_FILTER3_SLIDER:
            return @"TI_UIDCK_FILTER3_SLIDER";
            break;
        case TI_UIDCK_FILTER4_SLIDER:
            return @"TI_UIDCK_FILTER4_SLIDER";
            break;
        case TI_UIDCK_FILTER5_SLIDER:
            return @"TI_UIDCK_FILTER5_SLIDER";
            break;
        case TI_UIDCK_FILTER6_SLIDER:
            return @"TI_UIDCK_FILTER6_SLIDER";
            break;
        case TI_UIDCK_FILTER7_SLIDER:
            return @"TI_UIDCK_FILTER7_SLIDER";
            break;
        case TI_UIDCK_FILTER8_SLIDER:
            return @"TI_UIDCK_FILTER8_SLIDER";
            break;
        case TI_UIDCK_FILTER9_SLIDER:
            return @"TI_UIDCK_FILTER9_SLIDER";
            break;
        case TI_UIDCK_FILTER10_SLIDER:
            return @"TI_UIDCK_FILTER10_SLIDER";
            break;
        case TI_UIDCK_FILTER11_SLIDER:
            return @"TI_UIDCK_FILTER11_SLIDER";
            break;
        case TI_UIDCK_FILTER12_SLIDER:
            return @"TI_UIDCK_FILTER12_SLIDER";
            break;
        case TI_UIDCK_FILTER13_SLIDER:
            return @"TI_UIDCK_FILTER13_SLIDER";
            break;
        case TI_UIDCK_FILTER14_SLIDER:
            return @"TI_UIDCK_FILTER14_SLIDER";
            break;
        case TI_UIDCK_FILTER15_SLIDER:
            return @"TI_UIDCK_FILTER15_SLIDER";
            break;
        case TI_UIDCK_FILTER16_SLIDER:
            return @"TI_UIDCK_FILTER16_SLIDER";
            break;
        case TI_UIDCK_FILTER17_SLIDER:
            return @"TI_UIDCK_FILTER17_SLIDER";
            break;
        case TI_UIDCK_FILTER18_SLIDER:
            return @"TI_UIDCK_FILTER18_SLIDER";
            break;
        case TI_UIDCK_FILTER19_SLIDER:
            return @"TI_UIDCK_FILTER19_SLIDER";
            break;
        case TI_UIDCK_FILTER20_SLIDER:
            return @"TI_UIDCK_FILTER20_SLIDER";
            break;
        case TI_UIDCK_FILTER21_SLIDER:
            return @"TI_UIDCK_FILTER21_SLIDER";
            break;
        case TI_UIDCK_FILTER22_SLIDER:
            return @"TI_UIDCK_FILTER22_SLIDER";
            break;
        case TI_UIDCK_FILTER23_SLIDER:
            return @"TI_UIDCK_FILTER23_SLIDER";
            break;
        case TI_UIDCK_FILTER24_SLIDER:
            return @"TI_UIDCK_FILTER24_SLIDER";
            break;
        case TI_UIDCK_FILTER25_SLIDER:
            return @"TI_UIDCK_FILTER25_SLIDER";
            break;
        case TI_UIDCK_FILTER26_SLIDER:
            return @"TI_UIDCK_FILTER26_SLIDER";
            break;
        case TI_UIDCK_FILTER27_SLIDER:
            return @"TI_UIDCK_FILTER27_SLIDER";
            break;
        case TI_UIDCK_FILTER28_SLIDER:
            return @"TI_UIDCK_FILTER28_SLIDER";
            break;
        case TI_UIDCK_FILTER29_SLIDER:
            return @"TI_UIDCK_FILTER29_SLIDER";
            break;
        case TI_UIDCK_FILTER30_SLIDER:
            return @"TI_UIDCK_FILTER30_SLIDER";
            break;
        case TI_UIDCK_FILTER31_SLIDER:
            return @"TI_UIDCK_FILTER31_SLIDER";
            break;
        case TI_UIDCK_FILTER32_SLIDER:
            return @"TI_UIDCK_FILTER32_SLIDER";
            break;
        case TI_UIDCK_FILTER33_SLIDER:
            return @"TI_UIDCK_FILTER33_SLIDER";
            break;
        case TI_UIDCK_FILTER34_SLIDER:
            return @"TI_UIDCK_FILTER34_SLIDER";
            break;
        case TI_UIDCK_FILTER35_SLIDER:
            return @"TI_UIDCK_FILTER35_SLIDER";
            break;
        case TI_UIDCK_FILTER36_SLIDER:
            return @"TI_UIDCK_FILTER36_SLIDER";
            break;
        case TI_UIDCK_FILTER37_SLIDER:
            return @"TI_UIDCK_FILTER37_SLIDER";
            break;
        case TI_UIDCK_FILTER38_SLIDER:
            return @"TI_UIDCK_FILTER38_SLIDER";
            break;
        case TI_UIDCK_FILTER39_SLIDER:
            return @"TI_UIDCK_FILTER39_SLIDER";
            break;
        case TI_UIDCK_FILTER40_SLIDER:
            return @"TI_UIDCK_FILTER40_SLIDER";
            break;
        case TI_UIDCK_FILTER41_SLIDER:
            return @"TI_UIDCK_FILTER41_SLIDER";
            break;
        case TI_UIDCK_FILTER42_SLIDER:
            return @"TI_UIDCK_FILTER42_SLIDER";
            break;
        case TI_UIDCK_FILTER43_SLIDER:
            return @"TI_UIDCK_FILTER43_SLIDER";
            break;
        case TI_UIDCK_FILTER44_SLIDER:
            return @"TI_UIDCK_FILTER44_SLIDER";
            break;
        case TI_UIDCK_FILTER45_SLIDER:
            return @"TI_UIDCK_FILTER45_SLIDER";
            break;
        case TI_UIDCK_FILTER46_SLIDER:
            return @"TI_UIDCK_FILTER46_SLIDER";
            break;
            //            滤镜位置
        case TI_UIDCK_FILTER_POSITION:
            return @"TiUIDCKFilterPosition";
            break;
            //            一键美颜
        case TI_UIDCK_ONEKEY_SLIDER:
            return @"TiUIDCKOneKeySlider";
            break;
            //            一键美颜位置
        case TI_UIDCK_ONEKEY_POSITION:
            return @"TiUIDCKOneKeyPosition";
            break;
            //            脸型
        case TI_UIDCK_FACESHAPE_SLIDER:
            return @"TI_UIDCK_FACESHAPE_SLIDER";
            break;
            //            脸型位置
        case TI_UIDCK_FACESHAPE_POSITION:
            return @"TiUIDCKFaceShapePosition";
            break;
            //            长腿
        case TI_UIDCK_LONGLEG_SLIDER:
            return @"TI_UIDCK_LONGLEG_SLIDER";
            break;
            //            瘦身
        case TI_UIDCK_SLIMBODY_SLIDER:
            return @"TI_UIDCK_SLIMBODY_SLIDER";
            break;
        default:
            return @"";
            break;
    }
}

+ (void)setPSBeautySlider:(float)v forKey:(TiUIDataCategoryKey)key withIndex:(NSInteger)index{
    switch (key) {
        case TI_UIDCK_SKIN_WHITENING_SLIDER:
            //美白
            [[TiSDKManager shareManager] setSkinWhitening:v];
            break;
        case TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER:
            //磨皮
            [[TiSDKManager shareManager] setSkinBlemishRemoval:v];
            break;
        case TI_UIDCK_SKIN_TENDERNESS_SLIDER:
            //粉嫩
            [[TiSDKManager shareManager] setSkinTenderness:v];
            break;
            //清晰
        case TI_UIDCK_SKIN_SKINBRIGGT_SLIDER:
            [[TiSDKManager shareManager] setSkinSharpness:v];
            break;
        case TI_UIDCK_SKIN_BRIGHTNESS_SLIDER:
            //亮度
            [[TiSDKManager shareManager] setSkinBrightness:v];
            break;
        case TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER:
            //精细磨皮
            [[TiSDKManager shareManager] setSkinPreciseBeauty:v];
            break;
        case TI_UIDCK_SKIN_PRECISE_TENDERNESS_SLIDER:
            //精细粉嫩
            [[TiSDKManager shareManager] setPreciseTenderness:v];
            break;
        case TI_UIDCK_SKIN_HIGH_LIGHT_SLIDER:
            //立体
            [[TiSDKManager shareManager] setHighlight:v];
            break;
        case TI_UIDCK_SKIN_DARK_CIRCLE_SLIDER:
            //黑眼圈
            [[TiSDKManager shareManager] setDarkCircle:v];
            break;
        case TI_UIDCK_SKIN_CROWS_FEET_SLIDER:
            // 鱼尾纹
            [[TiSDKManager shareManager] setCrowsFeet:v];
            break;
        case TI_UIDCK_SKIN_NASOLABIAL_FOLD_SLIDER:
            // 法令纹
            [[TiSDKManager shareManager] setNasolabialFold:v];
            break;
            // 美型
        case TI_UIDCK_EYEMAGNIFYING_SLIDER:
            // 大眼
            [[TiSDKManager shareManager] setEyeMagnifying:v];
            break;
        case TI_UIDCK_CHINSLIMMING_SLIDER:
            // 瘦脸
            [[TiSDKManager shareManager] setChinSlimming:v];
            break;
        case TI_UIDCK_FACENARROWING_SLIDER:
            // 窄脸
            [[TiSDKManager shareManager] setFaceNarrowing:v];
            break;
        case TI_UIDCK_CHEEKBONESLIMMING_SLIDER:
            // 瘦颧骨
            [[TiSDKManager shareManager] setCheekboneSlimming:v];
            break;
        case TI_UIDCK_JAWBONESLIMMING_SLIDER:
            // 瘦下颌
            [[TiSDKManager shareManager] setJawboneSlimming:v];
            break;
        case TI_UIDCK_JAWTRANSFORMING_SLIDER:
            // 下巴
            [[TiSDKManager shareManager] setJawTransforming:v];
            break;
        case TI_UIDCK_JAWSLIMMING_SLIDER:
            // 削下巴
            [[TiSDKManager shareManager] setJawSlimming:v];
            break;
        case TI_UIDCK_FOREHEADTRANSFORMING_SLIDER:
            // 额头
            [[TiSDKManager shareManager] setForeheadTransforming:v];
            break;
        case TI_UIDCK_EYEINNERCORNERS_SLIDER:
            // 内眼角
            [[TiSDKManager shareManager] setEyeInnerCorners:v];
            break;
        case TI_UIDCK_EYEOUTERCORNERS_SLIDER:
            // 外眼尾
            [[TiSDKManager shareManager] setEyeOuterCorners:v];
            break;
        case TI_UIDCK_EYESPACING_SLIDER:
            // 眼间距
            [[TiSDKManager shareManager] setEyeSpacing:v];
            break;
        case TI_UIDCK_EYECORNERS_SLIDER:
            // 倾斜
            [[TiSDKManager shareManager] setEyeCorners:v];
            break;
        case TI_UIDCK_NOSEMINIFYING_SLIDER:
            // 瘦鼻
            [[TiSDKManager shareManager] setNoseMinifying:v];
            break;
        case TI_UIDCK_NOSEELONGATING_SLIDER:
            // 长鼻
            [[TiSDKManager shareManager] setNoseElongating:v];
            break;
        case TI_UIDCK_MOUTHTRANSFORMING_SLIDER:
            // 嘴型
            [[TiSDKManager shareManager] setMouthTransforming:v];
            break;
        case TI_UIDCK_MOUTHHEIGHT_SLIDER:
            // 嘴高低
            [[TiSDKManager shareManager] setMouthHeight:v];
            break;
        case TI_UIDCK_MOUTHLIPSIZE_SLIDER:
            // 唇厚薄
            [[TiSDKManager shareManager] setMouthLipSize:v];
            break;
        case TI_UIDCK_MOUTHSMILING_SLIDER:
            // 扬嘴角
            [[TiSDKManager shareManager] setMouthSmiling:v];
            break;
        case TI_UIDCK_BROWHEIGHT_SLIDER:
            // 眉高低
            [[TiSDKManager shareManager] setBrowHeight:v];
            break;
        case TI_UIDCK_BROWLENGTH_SLIDER:
            // 眉长短
            [[TiSDKManager shareManager] setBrowLength:v];
            break;
        case TI_UIDCK_BROWSPACE_SLIDER:
            // 眉间距
            [[TiSDKManager shareManager] setBrowSpace:v];
            break;
        case TI_UIDCK_BROWSIZE_SLIDER:
            // 眉粗细
            [[TiSDKManager shareManager] setBrowSize:v];
            break;
        case TI_UIDCK_BROWCORNER_SLIDER:
            // 提眉峰
            [[TiSDKManager shareManager] setBrowCorner:v];
            break;
            
        case TI_UIDCK_FILTER0_SLIDER:
        case TI_UIDCK_FILTER1_SLIDER:
        case TI_UIDCK_FILTER2_SLIDER:
        case TI_UIDCK_FILTER3_SLIDER:
        case TI_UIDCK_FILTER4_SLIDER:
        case TI_UIDCK_FILTER5_SLIDER:
        case TI_UIDCK_FILTER6_SLIDER:
        case TI_UIDCK_FILTER7_SLIDER:
        case TI_UIDCK_FILTER8_SLIDER:
        case TI_UIDCK_FILTER9_SLIDER:
        case TI_UIDCK_FILTER10_SLIDER:
        case TI_UIDCK_FILTER11_SLIDER:
        case TI_UIDCK_FILTER12_SLIDER:
        case TI_UIDCK_FILTER13_SLIDER:
        case TI_UIDCK_FILTER14_SLIDER:
        case TI_UIDCK_FILTER15_SLIDER:
        case TI_UIDCK_FILTER16_SLIDER:
        case TI_UIDCK_FILTER17_SLIDER:
        case TI_UIDCK_FILTER18_SLIDER:
        case TI_UIDCK_FILTER19_SLIDER:
        case TI_UIDCK_FILTER20_SLIDER:
        case TI_UIDCK_FILTER21_SLIDER:
        case TI_UIDCK_FILTER22_SLIDER:
        case TI_UIDCK_FILTER23_SLIDER:
        case TI_UIDCK_FILTER24_SLIDER:
        case TI_UIDCK_FILTER25_SLIDER:
        case TI_UIDCK_FILTER26_SLIDER:
        case TI_UIDCK_FILTER27_SLIDER:
        case TI_UIDCK_FILTER28_SLIDER:
        case TI_UIDCK_FILTER29_SLIDER:
        case TI_UIDCK_FILTER30_SLIDER:
        case TI_UIDCK_FILTER31_SLIDER:
        case TI_UIDCK_FILTER32_SLIDER:
        case TI_UIDCK_FILTER33_SLIDER:
        case TI_UIDCK_FILTER34_SLIDER:
        case TI_UIDCK_FILTER35_SLIDER:
        case TI_UIDCK_FILTER36_SLIDER:
        case TI_UIDCK_FILTER37_SLIDER:
        case TI_UIDCK_FILTER38_SLIDER:
        case TI_UIDCK_FILTER39_SLIDER:
        case TI_UIDCK_FILTER40_SLIDER:
        case TI_UIDCK_FILTER41_SLIDER:
        case TI_UIDCK_FILTER42_SLIDER:
        case TI_UIDCK_FILTER43_SLIDER:
        case TI_UIDCK_FILTER44_SLIDER:
        case TI_UIDCK_FILTER45_SLIDER:
        case TI_UIDCK_FILTER46_SLIDER:
            if (is_updatePSFilterValue){
                // 调整滤镜滑动条参数
                TiPSMode *filterMod = [TiPSPlistManager shareManager].filterModeArr[index];
                [[TiSDKManager shareManager] setBeautyFilter:filterMod.effectName Param:v];
            }else{
                for (TiPSMode *mod in [TiPSPlistManager shareManager].filterModeArr) {
                    if (mod.menuTag == index) {
                        [[TiSDKManager shareManager] setBeautyFilter:mod.effectName Param:v];
                    }
                }
            }
            break;
        case TI_UIDCK_ONEKEY_SLIDER:
            // 一键美颜
            [TiPSSetSDKParameters setOneKeyBeautySlider:v Index:index];
            break;
        case TI_UIDCK_FACESHAPE_SLIDER:
            // 脸型
            [TiPSSetSDKParameters setFaceShapeBeautySlider:v Index:index];
            break;
        default:
            break;
            
    }
    
}

+ (void)setOneKeyBeautySlider:(float)v Index:(NSInteger)index{
    
    // 设置一键美颜效果
    [[TiSDKManager shareManager] setOnekeyBeauty:index Param:v];
    CGFloat a = v/100;
    NSDictionary *onekeyParameter = [[TiPSPlistManager shareManager].onekeyParameter objectAtIndex:index];
    // 将一键美颜对应的参数储存本地——美颜
    for (int beauty = 0; beauty < 11; beauty ++) {
        CGFloat value1 = [[onekeyParameter objectForKey:[TiPSSetSDKParameters getTiPSDataCategoryKey:200+beauty]] floatValue];
        [TiPSSetSDKParameters setPSFloatValue:value1  * a forKey:200+beauty];
    }
    // 将一键美颜对应的参数储存本地——美型
    for (int facetrim = 0; facetrim < 23; facetrim ++) {
        CGFloat value2 = [[onekeyParameter objectForKey:[TiPSSetSDKParameters getTiPSDataCategoryKey:400+facetrim]] floatValue];
        [TiPSSetSDKParameters setPSFloatValue:value2  * a forKey:400+facetrim];
    }
    // 将一键美颜对应的参数储存本地——滤镜
    NSInteger filterId = [[onekeyParameter objectForKey:@"TiFilterIndex"] intValue];
    TiPSMode *filterMod = [TiPSPlistManager shareManager].filterModeArr[filterId];
    CGFloat valueFilter = [[onekeyParameter objectForKey:[TiPSSetSDKParameters getTiPSDataCategoryKey:500+filterMod.menuTag]] floatValue];
    [TiPSSetSDKParameters setPSFloatValue:valueFilter  * a forKey:500+filterMod.menuTag];
    // 将一键美颜的参数储存本地
    [TiPSSetSDKParameters setPSBeautySlider:valueFilter * a forKey:500+filterMod.menuTag withIndex:[[onekeyParameter objectForKey:@"TiFilterIndex"] intValue]];
    
}

+ (void)setFaceShapeBeautySlider:(float)v Index:(NSInteger)index{
    
    // 设置脸型效果
    [[TiSDKManager shareManager] setFaceShape:index Param:v];
    CGFloat a = v/100;
    NSDictionary *FaceShapeParameter = [[TiPSPlistManager shareManager].faceshapeParameter objectAtIndex:index];
    
    // 将脸型对应的参数储存本地——美型
    for (int facetrim = 0; facetrim < 23; facetrim ++) {
        CGFloat valueF = [[FaceShapeParameter objectForKey:[TiPSSetSDKParameters getTiPSDataCategoryKey:400+facetrim]] floatValue];
        [TiPSSetSDKParameters setPSFloatValue:valueF  * a forKey:400+facetrim];
    }
    
}

@end
