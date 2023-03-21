//
//  TiPSPlistManager.m
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSPlistManager.h"
#import "TiPSTool.h"
#import "TiPSSetSDKParameters.h"
#import "TiPSConfig.h"

static TiPSPlistManager *shareManager = NULL;
static dispatch_once_t token;

@implementation TiPSPlistManager

// MARK: --单例初始化方法--
+ (TiPSPlistManager *)shareManager {
    dispatch_once(&token, ^{
        shareManager = [[TiPSPlistManager alloc] init];
    });
    return shareManager;
}

+ (void)releaseShareManager{
    token = 0; // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
    shareManager = nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.mainModeArr = [self jsonModeForPath:@"TiPSMenu"];
        
        self.beautyModeArr = [self jsonModeForPath:@"TiPSBeauty"];
        self.appearanceModeArr = [self jsonModeForPath:@"TiPSAppearance"];
        self.onekeyModeArr = [self jsonModeForPath:@"TiPSOneKeyBeauty"];
        self.faceshapeModeArr = [self jsonModeForPath:@"TiPSFaceShape"];
        
        self.filterModeArr = [self jsonModeForPath:@"TiPSFilter"];
        
        // 获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TiPSOneKeyParameter" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        self.onekeyParameter = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSString *path2 = [[NSBundle mainBundle] pathForResource:@"TiPSFaceShapeParameter" ofType:@"json"];
        NSData *data2 = [[NSData alloc] initWithContentsOfFile:path2];
        self.faceshapeParameter = [NSJSONSerialization JSONObjectWithData:data2 options:kNilOptions error:nil];
        
        for (TiPSMode *mod in self.mainModeArr) {
            switch (mod.menuTag) {
                case 0:
                    [[TiSDKManager shareManager] setBeautyEnable:mod.totalSwitch];
                    break;
                case 1:
                    [[TiSDKManager shareManager] setFaceTrimEnable:mod.totalSwitch];
                    break;
                case 12:
                    [[TiSDKManager shareManager] setMakeupEnable:mod.totalSwitch];
                    break;
                    
                default:
                    break;
            }
        }
        
        [TiPSSetSDKParameters initSDK];
        
    }
    return self;
}

- (void)reset:(NSString *)resetName{
    
    if ([resetName  isEqual: NSLocalizedString(@"重置美颜", nil)]) {
        //一键美颜重置
        [TiPSSetSDKParameters setPSFloatValue:OnewKeyBeautyValue forKey:TI_UIDCK_ONEKEY_SLIDER];
        [TiPSSetSDKParameters setOneKeyBeautySlider:OnewKeyBeautyValue Index:0];
        //重置一键美颜——发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TIUIMenuTwo_isReset" object:@(true)];
        //美颜重置
        //美白
        [TiPSSetSDKParameters setPSFloatValue:SkinWhiteningValue forKey:TI_UIDCK_SKIN_WHITENING_SLIDER];
        [[TiSDKManager shareManager] setSkinWhitening:SkinWhiteningValue];
        //磨皮
        [TiPSSetSDKParameters setPSFloatValue:SkinBlemishRemovalValue forKey:TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER];
        [[TiSDKManager shareManager] setSkinBlemishRemoval:SkinBlemishRemovalValue];
        //粉嫩
        [TiPSSetSDKParameters setPSFloatValue:SkinTendernessValue forKey:TI_UIDCK_SKIN_TENDERNESS_SLIDER];
        [[TiSDKManager shareManager] setSkinTenderness:SkinTendernessValue];
        //清晰
        [TiPSSetSDKParameters setPSFloatValue:SkinBrightValue forKey:TI_UIDCK_SKIN_SKINBRIGGT_SLIDER];
        [[TiSDKManager shareManager] setSkinSharpness:SkinBrightValue];
        //亮度
        [TiPSSetSDKParameters setPSFloatValue:SkinBrightnessValue forKey:TI_UIDCK_SKIN_BRIGHTNESS_SLIDER];
        [[TiSDKManager shareManager] setSkinBrightness:SkinBrightnessValue];
        //精细磨皮
        [TiPSSetSDKParameters setPSFloatValue:SkinPreciseBeautyValue forKey:TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER];
        [[TiSDKManager shareManager] setSkinPreciseBeauty:SkinPreciseBeautyValue];
        //精细粉嫩
        [TiPSSetSDKParameters setPSFloatValue:SkinPreciseTendernessValue forKey:TI_UIDCK_SKIN_PRECISE_TENDERNESS_SLIDER];
        [[TiSDKManager shareManager] setSkinPreciseBeauty:SkinPreciseTendernessValue];
        //立体
        [TiPSSetSDKParameters setPSFloatValue:SkinHighlightValue forKey:TI_UIDCK_SKIN_HIGH_LIGHT_SLIDER];
        [[TiSDKManager shareManager] setHighlight:SkinHighlightValue];
        //黑眼圈
        [TiPSSetSDKParameters setPSFloatValue:SkinDarkCircleValue forKey:TI_UIDCK_SKIN_DARK_CIRCLE_SLIDER];
        [[TiSDKManager shareManager] setDarkCircle:SkinDarkCircleValue];
        //鱼尾纹
        [TiPSSetSDKParameters setPSFloatValue:SkinCrowsFeetValue forKey:TI_UIDCK_SKIN_CROWS_FEET_SLIDER];
        [[TiSDKManager shareManager] setCrowsFeet:SkinCrowsFeetValue];
        //法令纹
        [TiPSSetSDKParameters setPSFloatValue:SkinNasolabialFoldValue forKey:TI_UIDCK_SKIN_NASOLABIAL_FOLD_SLIDER];
        [[TiSDKManager shareManager] setNasolabialFold:SkinNasolabialFoldValue];
        
        //脸型重置
        [TiPSSetSDKParameters setPSFloatValue:FaceShapeBeautyValue forKey:TI_UIDCK_FACESHAPE_SLIDER];
        [TiPSSetSDKParameters setFaceShapeBeautySlider:FaceShapeBeautyValue Index:0];
        //重置脸型——发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TIUIMenuOne_isReset" object:@(true)];
        //美型重置
        //大眼
        [TiPSSetSDKParameters setPSFloatValue:EyeMagnifyingValue forKey:TI_UIDCK_EYEMAGNIFYING_SLIDER];
        [[TiSDKManager shareManager] setEyeMagnifying:EyeMagnifyingValue];
        //瘦脸
        [TiPSSetSDKParameters setPSFloatValue:ChinSlimmingValue forKey:TI_UIDCK_CHINSLIMMING_SLIDER];
        [[TiSDKManager shareManager] setChinSlimming:ChinSlimmingValue];
        //脸部
        //窄脸
        [TiPSSetSDKParameters setPSFloatValue:FaceNarrowingValue forKey:TI_UIDCK_FACENARROWING_SLIDER];
        [[TiSDKManager shareManager] setFaceNarrowing:FaceNarrowingValue];
        //瘦颧骨
        [TiPSSetSDKParameters setPSFloatValue:CheekboneSlimmingValue forKey:TI_UIDCK_CHEEKBONESLIMMING_SLIDER];
        [[TiSDKManager shareManager] setCheekboneSlimming:CheekboneSlimmingValue];
        //瘦下颌
        [TiPSSetSDKParameters setPSFloatValue:JawboneSlimmingValue forKey:TI_UIDCK_JAWBONESLIMMING_SLIDER];
        [[TiSDKManager shareManager] setJawboneSlimming:JawboneSlimmingValue];
        //下巴
        [TiPSSetSDKParameters setPSFloatValue:JawTransformingValue forKey:TI_UIDCK_JAWTRANSFORMING_SLIDER];
        [[TiSDKManager shareManager] setJawTransforming:JawTransformingValue];
        //削下巴
        [TiPSSetSDKParameters setPSFloatValue:JawSlimmingValue forKey:TI_UIDCK_JAWSLIMMING_SLIDER];
        [[TiSDKManager shareManager] setJawSlimming:JawSlimmingValue];
        //额头
        [TiPSSetSDKParameters setPSFloatValue:ForeheadTransformingValue forKey:TI_UIDCK_FOREHEADTRANSFORMING_SLIDER];
        [[TiSDKManager shareManager] setForeheadTransforming:ForeheadTransformingValue];
        //眼部
        //内眼角
        [TiPSSetSDKParameters setPSFloatValue:EyeInnerCornersValue forKey:TI_UIDCK_EYEINNERCORNERS_SLIDER];
        [[TiSDKManager shareManager] setEyeInnerCorners:EyeInnerCornersValue];
        //外眼尾
        [TiPSSetSDKParameters setPSFloatValue:EyeOuterCornersValue forKey:TI_UIDCK_EYEOUTERCORNERS_SLIDER];
        [[TiSDKManager shareManager] setEyeOuterCorners:EyeOuterCornersValue];
        //眼间距
        [TiPSSetSDKParameters setPSFloatValue:EyeSpacingValue forKey:TI_UIDCK_EYESPACING_SLIDER];
        [[TiSDKManager shareManager] setEyeSpacing:EyeSpacingValue];
        //倾斜
        [TiPSSetSDKParameters setPSFloatValue:EyeCornersValue forKey:TI_UIDCK_EYECORNERS_SLIDER];
        [[TiSDKManager shareManager] setEyeCorners:EyeCornersValue];
        //鼻子
        //瘦鼻
        [TiPSSetSDKParameters setPSFloatValue:NoseMinifyingValue forKey:TI_UIDCK_NOSEMINIFYING_SLIDER];
        [[TiSDKManager shareManager] setNoseMinifying:NoseMinifyingValue];
        //长鼻
        [TiPSSetSDKParameters setPSFloatValue:NoseElongatingValue forKey:TI_UIDCK_NOSEELONGATING_SLIDER];
        [[TiSDKManager shareManager] setNoseElongating:NoseElongatingValue];
        //嘴巴
        //嘴型
        [TiPSSetSDKParameters setPSFloatValue:MouthTransformingValue forKey:TI_UIDCK_MOUTHTRANSFORMING_SLIDER];
        [[TiSDKManager shareManager] setMouthTransforming:MouthTransformingValue];
        //嘴高低
        [TiPSSetSDKParameters setPSFloatValue:MouthHeightValue forKey:TI_UIDCK_MOUTHHEIGHT_SLIDER];
        [[TiSDKManager shareManager] setMouthHeight:MouthHeightValue];
        //唇厚薄
        [TiPSSetSDKParameters setPSFloatValue:MouthLipSizeValue forKey:TI_UIDCK_MOUTHLIPSIZE_SLIDER];
        [[TiSDKManager shareManager] setMouthLipSize:MouthLipSizeValue];
        //扬嘴角
        [TiPSSetSDKParameters setPSFloatValue:MouthSmilingValue forKey:TI_UIDCK_MOUTHSMILING_SLIDER];
        [[TiSDKManager shareManager] setMouthSmiling:MouthSmilingValue];
        //眉毛
        //眉高低
        [TiPSSetSDKParameters setPSFloatValue:BrowHeightValue forKey:TI_UIDCK_BROWHEIGHT_SLIDER];
        [[TiSDKManager shareManager] setBrowHeight:BrowHeightValue];
        //眉长短
        [TiPSSetSDKParameters setPSFloatValue:BrowLengthValue forKey:TI_UIDCK_BROWLENGTH_SLIDER];
        [[TiSDKManager shareManager] setBrowLength:BrowLengthValue];
        //眉间距
        [TiPSSetSDKParameters setPSFloatValue:BrowSpaceValue forKey:TI_UIDCK_BROWSPACE_SLIDER];
        [[TiSDKManager shareManager] setBrowSpace:BrowSpaceValue];
        //眉粗细
        [TiPSSetSDKParameters setPSFloatValue:BrowSizeValue forKey:TI_UIDCK_BROWSIZE_SLIDER];
        [[TiSDKManager shareManager] setBrowSize:BrowSizeValue];
        //提眉峰
        [TiPSSetSDKParameters setPSFloatValue:BrowCornerValue forKey:TI_UIDCK_BROWCORNER_SLIDER];
        [[TiSDKManager shareManager] setBrowCorner:BrowCornerValue];
    }else if ([resetName  isEqual: NSLocalizedString(@"重置美体", nil)]){
        [TiPSSetSDKParameters setPSFloatValue:LongLegValue forKey:TI_UIDCK_LONGLEG_SLIDER];
        [[TiSDKManager shareManager] setLongLeg:LongLegValue Top:0 Bottom:17];
        [TiPSSetSDKParameters setPSFloatValue:SlimBodyValue forKey:TI_UIDCK_SLIMBODY_SLIDER];
        [[TiSDKManager shareManager] setSlimBody:SlimBodyValue Left:0 Right:17];
    }
    
}

- (NSArray *)jsonModeForPath:(NSString *)path
{
    NSMutableDictionary *plistDictionary;
    //获取配置文件
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
    
    NSString *filePatch = [[[TiSDK shareInstance] getResPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",path]];
    
    //此获取的版本号对应version，打印出来对应为1.2.3.4.5这样的字符串
    NSString *VersionString = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] stringByAppendingFormat:@"-%@",TiPSCurrentVersion];
    
    NSString *key = [NSString stringWithFormat:@"CFBundleShortVersionString-TiUICurrentVersion-%@",path];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *oldVersionString = [defaults stringForKey:key];
    
    // 创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePatch]&&[oldVersionString isEqualToString:VersionString])
    {
        //        NSLog(NSLocalizedString(@"沙盒中存在 %@", nil),path);
        plistDictionary = [TiPSTool getJsonDataForPath:filePatch];
    }else{
        //        NSLog(NSLocalizedString(@"沙盒中不存在 %@", nil),path);
        //        首次启动，和sdk更新后 从配置文件中重新加载json
        [defaults setObject:VersionString forKey:key];
        plistDictionary = [TiPSTool getJsonDataForPath:plistPath];
        [TiPSTool setWriteJsonDic:plistDictionary toPath:filePatch];
    }
    [defaults synchronize];
    
    NSArray *plstArr = [plistDictionary objectForKey:@"menu"];
    NSMutableArray *modeArr = [NSMutableArray arrayWithCapacity:plstArr.count];
    for (NSDictionary *dic in plstArr) {
        TiPSMode *mode = [TiPSMode applicationWithDic:dic];
        
        if ([path isEqualToString:@"TiPSMenu"]) {
#pragma make  这里可以单独保存选中状态 除了选中区域外 其他的都默认重置选中状态
        }else{
            if (mode.menuTag == 0) {// 默认无 或者第一个按钮
                mode.selected = YES;
                [self modifyObject:@(YES) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@",path]];
            }else{
                if (mode.selected ==YES) {
                    mode.selected = NO;
                    [self modifyObject:@(NO) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@",path]];
                }
            }
        }
        [modeArr addObject:mode];
        
    }
    return modeArr;
    
}

- (void)getJsonPath:(TiPSMode *)mode forFileManager:(NSFileManager *)fileManager forPath:(NSString *)path{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *folderName = [defaults objectForKey:[NSString stringWithFormat:@"%@%ld",mode.name,(long)mode.menuTag]];
    [defaults synchronize];
    if (folderName&&folderName.length!=0) {
        NSString *folderPath =  [[TiSDK shareInstance] getResPath];
        if ([folderName containsString:@"/Library/Tillusory"]) {//先做安全判bai断
            NSRange subStrRange = [folderName rangeOfString:@"/Library/Tillusory"];//找出指定字符串的range
            NSInteger index = subStrRange.location + subStrRange.length;//获得“指定的字符以后的所有字符”的起始点
            NSString *restStr = [folderName substringFromIndex:index];//获得“指定的字符以后的所有字符”
            
            folderPath = [folderPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",restStr]];
        }
        if ([fileManager fileExistsAtPath:folderPath])
        {
            mode.downloaded = YES;
            [self modifyObject:@(YES) forKey:@"downloaded" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@",path]];
        }
    }
    
}

- (NSArray *)modifyObject:(id)obj forKey:(NSString *)key In:(NSUInteger)index WithPath:(NSString *)path{
    
    NSString *filePatch = [[[TiSDK shareInstance] getResPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",path]];
    NSMutableDictionary *plistDictionary = [TiPSTool getJsonDataForPath:filePatch];
    //修改字典里面的内容,先按照结构取到你想修改内容的小字典
    NSMutableArray *nmArr = [NSMutableArray arrayWithArray:[plistDictionary objectForKey:@"menu"]];
    NSMutableDictionary *nmDic;
    nmDic = [NSMutableDictionary dictionaryWithDictionary:nmArr[index]];
    [nmDic setObject:obj forKey:key];
    //修改完成组建成大字典写入本地
    [nmArr setObject:nmDic atIndexedSubscript:index];
    [plistDictionary setValue:nmArr forKey:@"menu"];
    [TiPSTool setWriteJsonDic:plistDictionary toPath:filePatch];
    //修改mode数组
    NSMutableArray *modeArr;
    if ([path isEqualToString:@"TiPSMenu"]) {
        modeArr = [NSMutableArray arrayWithArray:self.mainModeArr];
    }
    else if ([path isEqualToString:@"TiPSBeauty"]){
        modeArr = [NSMutableArray arrayWithArray:self.beautyModeArr];
    }
    else if ([path isEqualToString:@"TiPSAppearance"]){
        modeArr = [NSMutableArray arrayWithArray:self.appearanceModeArr];
    }
    else if ([path isEqualToString:@"TiPSFilter"]){
        modeArr = [NSMutableArray arrayWithArray:self.filterModeArr];
    }
    else if ([path isEqualToString:@"TiPSOneKeyBeauty"]){
        modeArr = [NSMutableArray arrayWithArray:self.onekeyModeArr];
    }
    else if ([path isEqualToString:@"TiPSFaceShape"]){
        modeArr = [NSMutableArray arrayWithArray:self.faceshapeModeArr];
    }
    if (modeArr.count) {
        TiPSMode *dome = [TiPSMode applicationWithDic:nmDic];
        [modeArr setObject:dome atIndexedSubscript:index];
    }
    return modeArr;
    
}

@end

@implementation TiPSMode

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        // KVC
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
    
}

+ (instancetype)applicationWithDic:(NSDictionary*)dic{
    
    TiPSMode * mode = [[TiPSMode alloc] initWithDic:dic];
    return mode;
    
}

@end
