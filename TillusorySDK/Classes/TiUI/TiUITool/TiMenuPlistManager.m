//
//  TiMenuPlistManager.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/3.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiMenuPlistManager.h"
#import "TiUITool.h"
#import "TiSetSDKParameters.h"
#import "TiUIMakeUpView.h"
#import "TiUIMenuTwoViewCell.h"

@interface TiMenuPlistManager ()

@property(nonatomic,strong)NSArray *blusherDir;
@property(nonatomic,strong)NSArray *eyebrowDir;
@property(nonatomic,strong)NSArray *eyeshadowDir;
@property(nonatomic,strong)NSArray *lipglossDir;

@property(nonatomic,strong)NSArray *blusherThumb;
@property(nonatomic,strong)NSArray *eyebrowThumb;
@property(nonatomic,strong)NSArray *eyeshadowThumb;
@property(nonatomic,strong)NSArray *lipglossThumb;

@end

static TiMenuPlistManager *shareManager = NULL;
static dispatch_once_t token;

@implementation TiMenuPlistManager

// MARK: --单例初始化方法--
+ (TiMenuPlistManager *)shareManager {
    dispatch_once(&token, ^{
        shareManager = [[TiMenuPlistManager alloc] init];
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
        
        self.blusherDir = @[NSLocalizedString(@"青涩", nil),NSLocalizedString(@"日杂", nil),NSLocalizedString(@"甜橙", nil),NSLocalizedString(@"优雅", nil),NSLocalizedString(@"微醺", nil),NSLocalizedString(@"心动", nil)];
        self.eyebrowDir = @[NSLocalizedString(@"标准眉", nil),NSLocalizedString(@"剑眉", nil),NSLocalizedString(@"柳叶眉", nil),NSLocalizedString(@"平直眉", nil),NSLocalizedString(@"流星眉", nil),NSLocalizedString(@"欧式眉", nil)];
        self.eyeshadowDir = @[NSLocalizedString(@"大地", nil),NSLocalizedString(@"女团", nil),NSLocalizedString(@"夏天", nil),NSLocalizedString(@"桃花", nil),NSLocalizedString(@"烟熏妆", nil),NSLocalizedString(@"元气", nil)];
        self.lipglossDir = @[NSLocalizedString(@"苹果红", nil),NSLocalizedString(@"番茄红", nil),NSLocalizedString(@"女团色", nil),NSLocalizedString(@"斩男色", nil),NSLocalizedString(@"肉桂蜜茶", nil),NSLocalizedString(@"正宫色", nil)];
        
        self.blusherThumb = @[@"blusher_qingse.png",@"blusher_riza.png",@"blusher_tiancheng.png",@"blusher_youya.png",@"blusher_weixun.png",@"blusher_xindong.png"];
        self.eyebrowThumb = @[@"eyebrow_biaozhunmei.png",@"eyebrow_jianmei.png",@"eyebrow_liuyemei.png",@"eyebrow_pingzhimei.png",@"eyebrow_liuxingmei.png",@"eyebrow_oushimei.png"];
        self.eyeshadowThumb = @[@"eyeshadow_dadi.png",@"eyeshadow_nvtuan.png",@"eyeshadow_summer.png",@"eyeshadow_taohua.png",@"eyeshadow_yanxunzhuang.png",@"eyeshadow_yuanqi.png"];
        self.lipglossThumb = @[@"lg_pingguohong_icon.png",@"lg_fanqiehong_icon.png",@"lg_nvtuanse_icon.png",@"lg_zhannanse_icon.png",@"lg_rouguimicha_icon.png",@"lg_zhenggongse_icon.png"];
        
        self.mainModeArr = [self jsonModeForPath:@"TiMenu"];
        
        self.beautyModeArr = [self jsonModeForPath:@"TiBeauty"];
        self.appearanceModeArr = [self jsonModeForPath:@"TiAppearance"];
        self.onekeyModeArr = [self jsonModeForPath:@"TiOneKeyBeauty"];
        self.faceshapeModeArr = [self jsonModeForPath:@"TiFaceShape"];
        
        self.filterModeArr = [self jsonModeForPath:@"TiFilter"];
        self.rockModeArr = [self jsonModeForPath:@"TiRock"];
        self.distortionModeArr = [self jsonModeForPath:@"TiDistortion"];
        
        self.stickersModeArr = [self jsonModeForPath:@"stickers" withCute:NSLocalizedString(@"萌颜", nil)];
        //贴纸
        self.stickerDownloadArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.stickersModeArr.count; i++) {
            TIMenuMode *mode = self.stickersModeArr[i];
            //获取stickersModeArr下载状态
            if (mode.downloaded == 1) {
                [self.stickerDownloadArr addObject:@"DownloadComplete"];
            }else{
                [self.stickerDownloadArr addObject:@"NotDownloaded"];
            }
        }
        
        self.giftModeArr = [self jsonModeForPath:@"gifts" withCute:NSLocalizedString(@"萌颜", nil)];
        //礼物
        self.giftDownloadArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.giftModeArr.count; i++) {
            TIMenuMode *mode = self.giftModeArr[i];
            //获取giftModeArr下载状态
            if (mode.downloaded == 1) {
                [self.giftDownloadArr addObject:@"DownloadComplete"];
            }else{
                [self.giftDownloadArr addObject:@"NotDownloaded"];
            }
        }
        
        self.watermarksModeArr = [self jsonModeForPath:@"watermarks" withCute:NSLocalizedString(@"萌颜", nil)];
        //水印
        
        self.masksModeArr = [self jsonModeForPath:@"masks" withCute:NSLocalizedString(@"萌颜", nil)];
        //面具
        self.maskDownloadArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.masksModeArr.count; i++) {
            TIMenuMode *mode = self.masksModeArr[i];
            //获取masksModeArr下载状态
            if (mode.downloaded == 1) {
                [self.maskDownloadArr addObject:@"DownloadComplete"];
            }else{
                [self.maskDownloadArr addObject:@"NotDownloaded"];
            }
        }
        
        self.greenscreensModeArr = [self jsonModeForPath:@"greenscreens" withCute:NSLocalizedString(@"萌颜", nil)];
        //绿幕
        
        self.interactionsArr = [self jsonModeForPath:@"interactions" withCute:NSLocalizedString(@"萌颜", nil)];
        //互动
        self.interactionDownloadArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.interactionsArr.count; i++) {
            TIMenuMode *mode = self.interactionsArr[i];
            //获取interactionsArr下载状态
            if (mode.downloaded == 1) {
                [self.interactionDownloadArr addObject:@"DownloadComplete"];
            }else{
                [self.interactionDownloadArr addObject:@"NotDownloaded"];
            }
        }
        
        self.portraitsModArr = [self jsonModeForPath:@"portraits" withCute:NSLocalizedString(@"萌颜", nil)];
        //人像
        self.portraitDownloadArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.portraitsModArr.count; i++) {
            TIMenuMode *mode = self.portraitsModArr[i];
            //获取portraitsModArr下载状态
            if (mode.downloaded == 1) {
                [self.portraitDownloadArr addObject:@"DownloadComplete"];
            }else{
                [self.portraitDownloadArr addObject:@"NotDownloaded"];
            }
        }
        
        self.gesturesModArr = [self jsonModeForPath:@"gestures" withCute:NSLocalizedString(@"萌颜", nil)];
        //手势
        self.gestureDownloadArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.gesturesModArr.count; i++) {
            TIMenuMode *mode = self.gesturesModArr[i];
            //获取gesturesModArr下载状态
            if (mode.downloaded == 1) {
                [self.gestureDownloadArr addObject:@"DownloadComplete"];
            }else{
                [self.gestureDownloadArr addObject:@"NotDownloaded"];
            }
        }
        
        self.makeupModArr = [self jsonModeForPath:@"TiMakeUpDef"];
        self.blusherModArr = [self jsonModeForPath:@"makeups" withType:@"blusher"];
        //腮红
        self.blusherDownloadArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.blusherModArr.count; i++) {
            TIMenuMode *mode = self.blusherModArr[i];
            //获取blusherModArr下载状态
            if (mode.downloaded == 1) {
                [self.blusherDownloadArr addObject:@"DownloadComplete"];
            }else{
                [self.blusherDownloadArr addObject:@"NotDownloaded"];
            }
        }
        self.eyebrowsModArr = [self jsonModeForPath:@"makeups" withType:@"eyebrow"];
        //眉毛
        self.eyebrowsDownloadArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.eyebrowsModArr.count; i++) {
            TIMenuMode *mode = self.eyebrowsModArr[i];
            //获取eyebrowsModArr下载状态
            if (mode.downloaded == 1) {
                [self.eyebrowsDownloadArr addObject:@"DownloadComplete"];
            }else{
                [self.eyebrowsDownloadArr addObject:@"NotDownloaded"];
            }
        }
        self.eyeshadowModArr = [self jsonModeForPath:@"makeups" withType:@"eyeshadow"];
        //眼影
        self.eyeshadowDownloadArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.eyeshadowModArr.count; i++) {
            TIMenuMode *mode = self.eyeshadowModArr[i];
            //获取eyeshadowModArr下载状态
            if (mode.downloaded == 1) {
                [self.eyeshadowDownloadArr addObject:@"DownloadComplete"];
            }else{
                [self.eyeshadowDownloadArr addObject:@"NotDownloaded"];
            }
        }
        self.lipglossModArr = [self jsonModeForPath:@"makeups" withType:@"lipgloss"];
        //唇彩
        self.lipglossDownloadArr = [[NSMutableArray alloc] init];
        for (int i = 0; i < self.lipglossModArr.count; i++) {
            TIMenuMode *mode = self.lipglossModArr[i];
            //获取lipglossModArr下载状态
            if (mode.downloaded == 1) {
                [self.lipglossDownloadArr addObject:@"DownloadComplete"];
            }else{
                [self.lipglossDownloadArr addObject:@"NotDownloaded"];
            }
        }
        
        self.hairdressModArr = [self jsonModeForPath:@"TiHairdressDef"];
        
        // 获取文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TiOneKeyBeautyParameter" ofType:@"json"];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        self.onekeyParameter = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        
        NSString *path2 = [[NSBundle mainBundle] pathForResource:@"TiFaceShapeBeautyParameter" ofType:@"json"];
        NSData *data2 = [[NSData alloc] initWithContentsOfFile:path2];
        self.faceshapeParameter = [NSJSONSerialization JSONObjectWithData:data2 options:kNilOptions error:nil];
        
        for (TIMenuMode *mod in self.mainModeArr) {
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
        
        [TiSetSDKParameters initSDK];
        
    }
    return self;
}

- (void)reset:(NSString *)resetName{
    if ([resetName  isEqual: NSLocalizedString(@"重置美颜", nil)]) {
        //一键美颜重置
        [TiSetSDKParameters setFloatValue:OnewKeyBeautyValue forKey:TI_UIDCK_ONEKEY_SLIDER];
        [TiSetSDKParameters setOneKeyBeautySlider:OnewKeyBeautyValue Index:0];
        //重置一键美颜——发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TIUIMenuTwo_isReset" object:@(true)];
        //美颜重置
        //美白
        [TiSetSDKParameters setFloatValue:SkinWhiteningValue forKey:TI_UIDCK_SKIN_WHITENING_SLIDER];
        [[TiSDKManager shareManager] setSkinWhitening:SkinWhiteningValue];
        //磨皮
        [TiSetSDKParameters setFloatValue:SkinBlemishRemovalValue forKey:TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER];
        [[TiSDKManager shareManager] setSkinBlemishRemoval:SkinBlemishRemovalValue];
        //粉嫩
        [TiSetSDKParameters setFloatValue:SkinTendernessValue forKey:TI_UIDCK_SKIN_TENDERNESS_SLIDER];
        [[TiSDKManager shareManager] setSkinTenderness:SkinTendernessValue];
        //清晰
        [TiSetSDKParameters setFloatValue:SkinBrightValue forKey:TI_UIDCK_SKIN_SKINBRIGGT_SLIDER];
        [[TiSDKManager shareManager] setSkinSharpness:SkinBrightValue];
        //亮度
        [TiSetSDKParameters setFloatValue:SkinBrightnessValue forKey:TI_UIDCK_SKIN_BRIGHTNESS_SLIDER];
        [[TiSDKManager shareManager] setSkinBrightness:SkinBrightnessValue];
        //精细磨皮
        [TiSetSDKParameters setFloatValue:SkinPreciseBeautyValue forKey:TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER];
        [[TiSDKManager shareManager] setSkinPreciseBeauty:SkinPreciseBeautyValue];
        //精细粉嫩
        [TiSetSDKParameters setFloatValue:SkinPreciseTendernessValue forKey:TI_UIDCK_SKIN_PRECISE_TENDERNESS_SLIDER];
        [[TiSDKManager shareManager] setSkinPreciseBeauty:SkinPreciseTendernessValue];
        //立体
        [TiSetSDKParameters setFloatValue:SkinHighlightValue forKey:TI_UIDCK_SKIN_HIGH_LIGHT_SLIDER];
        [[TiSDKManager shareManager] setHighlight:SkinHighlightValue];
        //黑眼圈
        [TiSetSDKParameters setFloatValue:SkinDarkCircleValue forKey:TI_UIDCK_SKIN_DARK_CIRCLE_SLIDER];
        [[TiSDKManager shareManager] setDarkCircle:SkinDarkCircleValue];
        //鱼尾纹
        [TiSetSDKParameters setFloatValue:SkinCrowsFeetValue forKey:TI_UIDCK_SKIN_CROWS_FEET_SLIDER];
        [[TiSDKManager shareManager] setCrowsFeet:SkinCrowsFeetValue];
        //法令纹
        [TiSetSDKParameters setFloatValue:SkinNasolabialFoldValue forKey:TI_UIDCK_SKIN_NASOLABIAL_FOLD_SLIDER];
        [[TiSDKManager shareManager] setNasolabialFold:SkinNasolabialFoldValue];
        
        //脸型重置
        [TiSetSDKParameters setFloatValue:FaceShapeBeautyValue forKey:TI_UIDCK_FACESHAPE_SLIDER];
        [TiSetSDKParameters setFaceShapeBeautySlider:FaceShapeBeautyValue Index:0];
        //重置脸型——发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TIUIMenuOne_isReset" object:@(true)];
        //美型重置
        //大眼
        [TiSetSDKParameters setFloatValue:EyeMagnifyingValue forKey:TI_UIDCK_EYEMAGNIFYING_SLIDER];
        [[TiSDKManager shareManager] setEyeMagnifying:EyeMagnifyingValue];
        //瘦脸
        [TiSetSDKParameters setFloatValue:ChinSlimmingValue forKey:TI_UIDCK_CHINSLIMMING_SLIDER];
        [[TiSDKManager shareManager] setChinSlimming:ChinSlimmingValue];
        //脸部
        //窄脸
        [TiSetSDKParameters setFloatValue:FaceNarrowingValue forKey:TI_UIDCK_FACENARROWING_SLIDER];
        [[TiSDKManager shareManager] setFaceNarrowing:FaceNarrowingValue];
        //瘦颧骨
        [TiSetSDKParameters setFloatValue:CheekboneSlimmingValue forKey:TI_UIDCK_CHEEKBONESLIMMING_SLIDER];
        [[TiSDKManager shareManager] setCheekboneSlimming:CheekboneSlimmingValue];
        //瘦下颌
        [TiSetSDKParameters setFloatValue:JawboneSlimmingValue forKey:TI_UIDCK_JAWBONESLIMMING_SLIDER];
        [[TiSDKManager shareManager] setJawboneSlimming:JawboneSlimmingValue];
        //下巴
        [TiSetSDKParameters setFloatValue:JawTransformingValue forKey:TI_UIDCK_JAWTRANSFORMING_SLIDER];
        [[TiSDKManager shareManager] setJawTransforming:JawTransformingValue];
        //削下巴
        [TiSetSDKParameters setFloatValue:JawSlimmingValue forKey:TI_UIDCK_JAWSLIMMING_SLIDER];
        [[TiSDKManager shareManager] setJawSlimming:JawSlimmingValue];
        //额头
        [TiSetSDKParameters setFloatValue:ForeheadTransformingValue forKey:TI_UIDCK_FOREHEADTRANSFORMING_SLIDER];
        [[TiSDKManager shareManager] setForeheadTransforming:ForeheadTransformingValue];
        //眼部
        //内眼角
        [TiSetSDKParameters setFloatValue:EyeInnerCornersValue forKey:TI_UIDCK_EYEINNERCORNERS_SLIDER];
        [[TiSDKManager shareManager] setEyeInnerCorners:EyeInnerCornersValue];
        //外眼尾
        [TiSetSDKParameters setFloatValue:EyeOuterCornersValue forKey:TI_UIDCK_EYEOUTERCORNERS_SLIDER];
        [[TiSDKManager shareManager] setEyeOuterCorners:EyeOuterCornersValue];
        //眼间距
        [TiSetSDKParameters setFloatValue:EyeSpacingValue forKey:TI_UIDCK_EYESPACING_SLIDER];
        [[TiSDKManager shareManager] setEyeSpacing:EyeSpacingValue];
        //倾斜
        [TiSetSDKParameters setFloatValue:EyeCornersValue forKey:TI_UIDCK_EYECORNERS_SLIDER];
        [[TiSDKManager shareManager] setEyeCorners:EyeCornersValue];
        //鼻子
        //瘦鼻
        [TiSetSDKParameters setFloatValue:NoseMinifyingValue forKey:TI_UIDCK_NOSEMINIFYING_SLIDER];
        [[TiSDKManager shareManager] setNoseMinifying:NoseMinifyingValue];
        //长鼻
        [TiSetSDKParameters setFloatValue:NoseElongatingValue forKey:TI_UIDCK_NOSEELONGATING_SLIDER];
        [[TiSDKManager shareManager] setNoseElongating:NoseElongatingValue];
        //嘴巴
        //嘴型
        [TiSetSDKParameters setFloatValue:MouthTransformingValue forKey:TI_UIDCK_MOUTHTRANSFORMING_SLIDER];
        [[TiSDKManager shareManager] setMouthTransforming:MouthTransformingValue];
        //嘴高低
        [TiSetSDKParameters setFloatValue:MouthHeightValue forKey:TI_UIDCK_MOUTHHEIGHT_SLIDER];
        [[TiSDKManager shareManager] setMouthHeight:MouthHeightValue];
        //唇厚薄
        [TiSetSDKParameters setFloatValue:MouthLipSizeValue forKey:TI_UIDCK_MOUTHLIPSIZE_SLIDER];
        [[TiSDKManager shareManager] setMouthLipSize:MouthLipSizeValue];
        //扬嘴角
        [TiSetSDKParameters setFloatValue:MouthSmilingValue forKey:TI_UIDCK_MOUTHSMILING_SLIDER];
        [[TiSDKManager shareManager] setMouthSmiling:MouthSmilingValue];
        //眉毛
        //眉高低
        [TiSetSDKParameters setFloatValue:BrowHeightValue forKey:TI_UIDCK_BROWHEIGHT_SLIDER];
        [[TiSDKManager shareManager] setBrowHeight:BrowHeightValue];
        //眉长短
        [TiSetSDKParameters setFloatValue:BrowLengthValue forKey:TI_UIDCK_BROWLENGTH_SLIDER];
        [[TiSDKManager shareManager] setBrowLength:BrowLengthValue];
        //眉间距
        [TiSetSDKParameters setFloatValue:BrowSpaceValue forKey:TI_UIDCK_BROWSPACE_SLIDER];
        [[TiSDKManager shareManager] setBrowSpace:BrowSpaceValue];
        //眉粗细
        [TiSetSDKParameters setFloatValue:BrowSizeValue forKey:TI_UIDCK_BROWSIZE_SLIDER];
        [[TiSDKManager shareManager] setBrowSize:BrowSizeValue];
        //提眉峰
        [TiSetSDKParameters setFloatValue:BrowCornerValue forKey:TI_UIDCK_BROWCORNER_SLIDER];
        [[TiSDKManager shareManager] setBrowCorner:BrowCornerValue];
        
    }else if ([resetName  isEqual: NSLocalizedString(@"重置美妆", nil)]){
        //腮红
        [TiSetSDKParameters setFloatValue:CheekRedValue forKey:TI_UIDCK_CheekRed_SLIDER];
        int CheekRedIndex =  [TiSetSDKParameters getBeautyMakeupIndexForKey:TI_UIDCK_CheekRed_SLIDER];
        [[TiSDKManager shareManager] setBlusher:[TiSetSDKParameters setMakeupByIndex:CheekRedIndex] Param:CheekRedValue];
        [TiSetSDKParameters setBeautyMakeupIndex:CheekRedIndex forKey:TI_UIDCK_CheekRed_SLIDER];
        
        //睫毛
//        [TiSetSDKParameters setFloatValue:EyelashValue forKey:TI_UIDCK_Eyelash_SLIDER];
//        int EyelashIndex =  [TiSetSDKParameters getBeautyMakeupIndexForKey:TI_UIDCK_Eyelash_SLIDER];
//        [[TiSDKManager shareManager] setEyeLash:[TiSetSDKParameters setMakeupByIndex:EyelashIndex] Param:EyelashValue];
//        [TiSetSDKParameters setBeautyMakeupIndex:EyelashIndex forKey:TI_UIDCK_Eyelash_SLIDER];
        
        //眉毛
        [TiSetSDKParameters setFloatValue:EyebrowsValue forKey:TI_UIDCK_Eyebrows_SLIDER];
        int EyebrowsIndex =  [TiSetSDKParameters getBeautyMakeupIndexForKey:TI_UIDCK_Eyebrows_SLIDER];
        [[TiSDKManager shareManager] setEyeBrow:[TiSetSDKParameters setMakeupByIndex:EyebrowsIndex] Param:EyebrowsValue];
        [TiSetSDKParameters setBeautyMakeupIndex:EyebrowsIndex forKey:TI_UIDCK_Eyebrows_SLIDER];
        
        //眼影
        [TiSetSDKParameters setFloatValue:EyeshadowValue forKey:TI_UIDCK_Eyeshadow_SLIDER];
        int EyeshadowIndex =  [TiSetSDKParameters getBeautyMakeupIndexForKey:TI_UIDCK_Eyeshadow_SLIDER];
        [[TiSDKManager shareManager] setEyeShadow:[TiSetSDKParameters setMakeupByIndex:EyeshadowIndex] Param:EyeshadowValue];
        [TiSetSDKParameters setBeautyMakeupIndex:EyeshadowIndex forKey:TI_UIDCK_Eyeshadow_SLIDER];
        
        //唇彩
        [TiSetSDKParameters setFloatValue:LipGlossValue forKey:TI_UIDCK_LipGloss_SLIDER];
        int LipGlossIndex =  [TiSetSDKParameters getBeautyMakeupIndexForKey:TI_UIDCK_LipGloss_SLIDER];
        [[TiSDKManager shareManager] setLipGLoss:[TiSetSDKParameters setMakeupByIndex:LipGlossIndex] Param:LipGlossValue];
        [TiSetSDKParameters setBeautyMakeupIndex:LipGlossIndex forKey:TI_UIDCK_LipGloss_SLIDER];
        
        //眼线
//        [TiSetSDKParameters setFloatValue:EyelineValue forKey:TI_UIDCK_Eyeline_SLIDER];
//        int EyelineIndex =  [TiSetSDKParameters getBeautyMakeupIndexForKey:TI_UIDCK_Eyeline_SLIDER];
//        [[TiSDKManager shareManager] setEyeLine:[TiSetSDKParameters setMakeupByIndex:EyelineIndex] Param:EyelineValue];
//        [TiSetSDKParameters setBeautyMakeupIndex:EyelineIndex forKey:TI_UIDCK_Eyeline_SLIDER];
        
        //美妆重置完成
        makeUpResetComplete = true;
    }
    
}

//美妆json单独判断
- (NSArray *)jsonModeForPath:(NSString *)path withType:(NSString *)type{
    
    NSMutableDictionary *plistDictionary;
    //获取配置文件
    NSString *plistPath = [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"/makeup/%@.json",path]];
    NSString *filePatch = [[[TiSDK shareInstance] getMakeupPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",path]];
    
    //此获取的版本号对应version，打印出来对应为1.2.3.4.5这样的字符串
    NSString *VersionString = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] stringByAppendingFormat:@"-%@",TiUICurrentVersion];
    NSString *key = [NSString stringWithFormat:@"CFBundleShortVersionString-TiUICurrentVersion-%@",path];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *oldVersionString = [defaults stringForKey:key];
    // 创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePatch]&&[oldVersionString isEqualToString:VersionString])
    {
        plistDictionary = [TiUITool getJsonDataForPath:filePatch];
    }else{
//        首次启动，和sdk更新后 从配置文件中重新加载json
        [defaults setObject:VersionString forKey:key];
        plistDictionary = [TiUITool getJsonDataForPath:plistPath];
        [TiUITool setWriteJsonDic:plistDictionary toPath:filePatch];
    }
    [defaults synchronize];
    
    NSArray *plstArr = [plistDictionary objectForKey:@"makeups"];
    NSMutableArray *blusherArr = [[NSMutableArray alloc] init];//腮红
    NSMutableArray *eyebrowArr = [[NSMutableArray alloc] init];//眉毛
    NSMutableArray *eyeshadowArr = [[NSMutableArray alloc] init];//眼影
    NSMutableArray *lipglossArr = [[NSMutableArray alloc] init];//唇彩

    int blusher = 0;
    int eyebrow = 0;
    int eyeshadow = 0;
    int lipgloss = 0;
    int min = 0;
    int max = (int)plstArr.count;
    
    if ([type isEqualToString:@"blusher"]) {
        max = 6;
    }else if ([type isEqualToString:@"eyebrow"]){
        min = 6;
        max = 12;
    }else if ([type isEqualToString:@"eyeshadow"]){
        min = 18;
        max = 24;
    }else if ([type isEqualToString:@"lipgloss"]){
        min = 31;
        max = 37;
    }
    
    //遍历获取美妆对应的数据
    for (int i = min; i < max; i++) {
        //原本是用来单独保持下载状态 而不保存选中状态的
        NSMutableDictionary *dic = plstArr[i];
        TIMenuMode *mode = [TIMenuMode applicationWithDic:dic];
        
        if (![oldVersionString isEqualToString:VersionString]) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *folderName = [defaults objectForKey:[NSString stringWithFormat:@"%@%ld",mode.name,(long)mode.menuTag]];
            [defaults synchronize];
            if (folderName&&folderName.length!=0) {
                NSString *folderPath = [self judgePath:path];
                if ([folderName containsString:@"/Library/Tillusory"]) {//先做安全判bai断
                    NSRange subStrRange = [folderName rangeOfString:@"/Library/Tillusory"];//找出指定字符串的range
                    NSInteger index = subStrRange.location + subStrRange.length;//获得“指定的字符以后的所有字符”的起始点
                    NSString *restStr = [folderName substringFromIndex:index];//获得“指定的字符以后的所有字符”
                    
                    folderPath = [folderPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",restStr]];
                }
                if ([fileManager fileExistsAtPath:folderPath])
                {
                    mode.downloaded = YES;
                    [self modifyMakeUp:@(YES) forKey:@"downloaded" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@",path] Withtype:type];
                }
            }
        }
        
        //增加selected字段
        [dic setObject:@(NO) forKey:@"selected"];
        
        if ([mode.type isEqualToString:@"blusher"] ) {
            //增加menuTag字段
            [dic setObject:@(i+1) forKey:@"menuTag"];
            //增加dir字段
            [dic setObject:self.blusherDir[blusher] forKey:@"dir"];
            //增加Thumb字段
            [dic setObject:self.blusherThumb[blusher] forKey:@"normalThumb"];
            [dic setObject:self.blusherThumb[blusher] forKey:@"selectedThumb"];
            
            blusher++;
            mode = [TIMenuMode applicationWithDic:dic];
            //添加至blusherArr
            [blusherArr addObject:mode];
        }
        if ([mode.type isEqualToString:@"eyebrow"] ) {
            //增加menuTag字段
            [dic setObject:@(i-5) forKey:@"menuTag"];
            //增加dir字段
            [dic setObject:self.eyebrowDir[eyebrow] forKey:@"dir"];
            //增加Thumb字段
            [dic setObject:self.eyebrowThumb[eyebrow] forKey:@"normalThumb"];
            [dic setObject:self.eyebrowThumb[eyebrow] forKey:@"selectedThumb"];
            
            eyebrow++;
            mode = [TIMenuMode applicationWithDic:dic];
            //添加至eyebrowArr
            [eyebrowArr addObject:mode];
        }
        if ([mode.type isEqualToString:@"eyeshadow"] ) {
            //增加menuTag字段
            [dic setObject:@(i-17) forKey:@"menuTag"];
            //增加dir字段
            [dic setObject:self.eyeshadowDir[eyeshadow] forKey:@"dir"];
            //增加Thumb字段
            [dic setObject:self.eyeshadowThumb[eyeshadow] forKey:@"normalThumb"];
            [dic setObject:self.eyeshadowThumb[eyeshadow] forKey:@"selectedThumb"];
            
            eyeshadow++;
            mode = [TIMenuMode applicationWithDic:dic];
            //添加至eyeshadowArr
            [eyeshadowArr addObject:mode];
        }
        if ([mode.type isEqualToString:@"lipgloss"] ) {
            //增加menuTag字段
            [dic setObject:@(i-30) forKey:@"menuTag"];
            //增加dir字段
            [dic setObject:self.lipglossDir[lipgloss] forKey:@"dir"];
            //增加Thumb字段
            [dic setObject:self.lipglossThumb[lipgloss] forKey:@"normalThumb"];
            [dic setObject:self.lipglossThumb[lipgloss] forKey:@"selectedThumb"];
            
            lipgloss++;
            mode = [TIMenuMode applicationWithDic:dic];
            //添加至lipglossArr
            [lipglossArr addObject:mode];
        }
        
    }
    
    if ([type isEqualToString:@"blusher"]) {
        return blusherArr;
    } else if ([type isEqualToString:@"eyebrow"]){
        return eyebrowArr;
    } else if ([type isEqualToString:@"eyeshadow"]){
        return eyeshadowArr;
    } else{
        return lipglossArr;
    }
    
}

//萌颜json单独判断
- (NSArray *)jsonModeForPath:(NSString *)path withCute:(NSString *)cute{
    
    NSMutableDictionary *plistDictionary;
    //获取配置文件
    NSString *plistPath;
    if ([path isEqualToString:@"gestures"]) {
        plistPath = [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"/gesture/%@.json",path]];
    }
    if ([path isEqualToString:@"gifts"]) {
        plistPath = [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"/gift/%@.json",path]];
    }
    if ([path isEqualToString:@"greenscreens"]) {
        plistPath = [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"/greenscreen/%@.json",path]];
    }
    if ([path isEqualToString:@"interactions"]) {
        plistPath = [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"/interaction/%@.json",path]];
    }
    if ([path isEqualToString:@"masks"]) {
        plistPath = [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"/mask/%@.json",path]];
    }
    if ([path isEqualToString:@"portraits"]) {
        plistPath = [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"/portrait/%@.json",path]];
    }
    if ([path isEqualToString:@"stickers"]) {
        plistPath = [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"/sticker/%@.json",path]];
    }
    if ([path isEqualToString:@"watermarks"]) {
        plistPath = [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:[NSString stringWithFormat:@"/watermark/%@.json",path]];
    }
    
    NSString *filePatch = [[self judgePath:path] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",path]];
    
    //此获取的版本号对应version，打印出来对应为1.2.3.4.5这样的字符串
    NSString *VersionString = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] stringByAppendingFormat:@"-%@",TiUICurrentVersion];
    NSString *key = [NSString stringWithFormat:@"CFBundleShortVersionString-TiUICurrentVersion-%@",path];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *oldVersionString = [defaults stringForKey:key];
    
    // 创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePatch]&&[oldVersionString isEqualToString:VersionString])
    {
        plistDictionary = [TiUITool getJsonDataForPath:filePatch];
    }else{
        
//        首次启动，和sdk更新后 从配置文件中重新加载json
        [defaults setObject:VersionString forKey:key];
        plistDictionary = [TiUITool getJsonDataForPath:plistPath];
        [TiUITool setWriteJsonDic:plistDictionary toPath:filePatch];
    }
    [defaults synchronize];
    
    NSArray *plstArr;
    if ([path isEqualToString:@"greenscreens"]) {
        plstArr = [plistDictionary objectForKey:@"greenScreens"];
    }else if ([path isEqualToString:@"gestures"] ||
        [path isEqualToString:@"gifts"] ||
        [path isEqualToString:@"interactions"] ||
        [path isEqualToString:@"masks"] ||
        [path isEqualToString:@"portraits"] ||
        [path isEqualToString:@"stickers"] ||
        [path isEqualToString:@"watermarks"]) {
        plstArr = [plistDictionary objectForKey:path];
    }
    NSMutableArray *modeArr = [NSMutableArray arrayWithCapacity:plstArr.count];
    TIMenuMode *mode;
    
    //增加第一个
    NSDictionary *dic0 = @{ @"dir":@"",@"thumb":@"tiezhi_wu_selected.png",@"normalThumb":@"tiezhi_wu_normal.png",@"name":@"",@"category":@"default",@"voiced":@(NO),@"downloaded":@(YES),@"selected":@(YES),@"menuTag":@(0)};
    mode = [TIMenuMode applicationWithDic:dic0];
    [self getJsonPath:mode forFileManager:fileManager forPath:path];
    [modeArr addObject:mode];
    
    if ([path isEqualToString:@"greenscreens"]) {
        //绿幕增加编辑
        NSDictionary *dic1 = @{ @"name":@"",@"thumb":@"icon_lvmu_bianji.png",@"normalThumb":@"icon_lvmu_bianji.png",@"downloaded":@(YES),@"selected":@(NO),@"menuTag":@(1)};
        mode = [TIMenuMode applicationWithDic:dic1];
        [self getJsonPath:mode forFileManager:fileManager forPath:path];
        [modeArr addObject:mode];
    }
    
    for (int i = 0; i < plstArr.count; i++) {
        //原本是用来单独保持下载状态 而不保存选中状态的
        NSMutableDictionary *dic = plstArr[i];
        mode = [TIMenuMode applicationWithDic:dic];
        
        if (![oldVersionString isEqualToString:VersionString]) {
            [self getJsonPath:mode forFileManager:fileManager forPath:path];
        }
        
        //增加menuTag字段
        if ([path isEqualToString:@"greenscreens"]) {
            [dic setObject:@(i+2) forKey:@"menuTag"];
        }else{
            [dic setObject:@(i+1) forKey:@"menuTag"];
        }
        //增加selected字段
        [dic setObject:@(NO) forKey:@"selected"];
        mode = [TIMenuMode applicationWithDic:dic];
        
        if (mode.menuTag == 0) {// 默认无 或者第一个按钮
            mode.selected = YES;
            [self modifyObject:@(YES) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@",path]];
        }else{
            if (mode.selected ==YES) {
                mode.selected = NO;
                [self modifyObject:@(NO) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@",path]];
            }
        }
        [modeArr addObject:mode];
        
    }
    
    return modeArr;
    
}

+ (NSBundle *)bundleWithBundleName:(NSString *)bundleName podName:(NSString *)podName{
    if (bundleName == nil && podName == nil) {
        @throw @"bundleName和podName不能同时为空";
    }else if (bundleName == nil ) {
        bundleName = podName;
    }else if (podName == nil) {
        podName = bundleName;
    }
    
    
    if ([bundleName containsString:@".bundle"]) {
        bundleName = [bundleName componentsSeparatedByString:@".bundle"].firstObject;
    }
    //没使用framwork的情况下
    NSURL *associateBundleURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    //使用framework形式
    if (!associateBundleURL) {
        associateBundleURL = [[NSBundle mainBundle] URLForResource:@"Frameworks" withExtension:nil];
        associateBundleURL = [associateBundleURL URLByAppendingPathComponent:podName];
        associateBundleURL = [associateBundleURL URLByAppendingPathExtension:@"framework"];
        NSBundle *associateBunle = [NSBundle bundleWithURL:associateBundleURL];
        associateBundleURL = [associateBunle URLForResource:bundleName withExtension:@"bundle"];
    }
    
    NSAssert(associateBundleURL, @"取不到关联bundle");
    //生产环境直接返回空
    return associateBundleURL?[NSBundle bundleWithURL:associateBundleURL]:nil;
}

- (NSArray *)jsonModeForPath:(NSString *)path
{
    NSMutableDictionary *plistDictionary;
    //获取配置文件
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:path ofType:@"json"];
 
    NSString *filePatch = [[[TiSDK shareInstance] getResPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",path]];
    
    //此获取的版本号对应version，打印出来对应为1.2.3.4.5这样的字符串
    NSString *VersionString = [[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"] stringByAppendingFormat:@"-%@",TiUICurrentVersion];
    
    NSString *key = [NSString stringWithFormat:@"CFBundleShortVersionString-TiUICurrentVersion-%@",path];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *oldVersionString = [defaults stringForKey:key];
    
    // 创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if ([fileManager fileExistsAtPath:filePatch]&&[oldVersionString isEqualToString:VersionString])
    {
//        NSLog(NSLocalizedString(@"沙盒中存在 %@", nil),path);
        plistDictionary = [TiUITool getJsonDataForPath:filePatch];
    }else{
//        NSLog(NSLocalizedString(@"沙盒中不存在 %@", nil),path);
//        首次启动，和sdk更新后 从配置文件中重新加载json
        [defaults setObject:VersionString forKey:key];
        plistDictionary = [TiUITool getJsonDataForPath:plistPath];
        [TiUITool setWriteJsonDic:plistDictionary toPath:filePatch];
    }
    [defaults synchronize];
    
    NSArray *plstArr = [plistDictionary objectForKey:@"menu"];
    NSMutableArray *modeArr = [NSMutableArray arrayWithCapacity:plstArr.count];
    for (NSDictionary *dic in plstArr) {
        TIMenuMode *mode = [TIMenuMode applicationWithDic:dic];
        
        if ([path isEqualToString:@"TiMenu"]) {
  #pragma make  这里可以单独保存选中状态 除了选中区域外 其他的都默认重置选中状态
        }else{
            if ([path isEqualToString:@"TiOneKeyBeauty"]) {
                // 获取一键美颜选中位置
                NSIndexPath *newsIndexPath = [NSIndexPath indexPathForRow:[TiSetSDKParameters getSelectPositionForKey:TI_UIDCK_ONEKEY_POSITION] inSection:0];
                if (mode.menuTag == newsIndexPath.row) {
                    mode.selected = YES;
                    [self modifyObject:@(YES) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@",path]];
                }else{
                    if (mode.selected == YES) {
                        mode.selected = NO;
                        [self modifyObject:@(NO) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@",path]];
                    }
                }
            }else if ([path isEqualToString:@"TiFilter"]){
                // 获取滤镜选中位置
                NSIndexPath *newsIndexPath = [NSIndexPath indexPathForRow:[TiSetSDKParameters getSelectPositionForKey:TI_UIDCK_FILTER_POSITION] inSection:0];
                if (mode.menuTag == newsIndexPath.row) {
                    mode.selected = YES;
                    [self modifyObject:@(YES) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@",path]];
                }else{
                    if (mode.selected == YES) {
                        mode.selected = NO;
                        [self modifyObject:@(NO) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@",path]];
                    }
                }
            }else if ([path isEqualToString:@"TiFaceShape"]) {
                // 获取脸型选中位置
                NSIndexPath *newsIndexPath = [NSIndexPath indexPathForRow:[TiSetSDKParameters getSelectPositionForKey:TI_UIDCK_FACESHAPE_POSITION] inSection:0];
                if (mode.menuTag == newsIndexPath.row) {
                    mode.selected = YES;
                    [self modifyObject:@(YES) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@",path]];
                }else{
                    if (mode.selected == YES) {
                        mode.selected = NO;
                        [self modifyObject:@(NO) forKey:@"selected" In:mode.menuTag WithPath:[NSString stringWithFormat:@"%@",path]];
                    }
                }
            }else{
//                [path isEqualToString:@"TiDistortion"]
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
            
        }
        [modeArr addObject:mode];
        
    }
    return modeArr;
    
}

- (void)getJsonPath:(TIMenuMode *)mode forFileManager:(NSFileManager *)fileManager forPath:(NSString *)path{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *folderName = [defaults objectForKey:[NSString stringWithFormat:@"%@%ld",mode.name,(long)mode.menuTag]];
    [defaults synchronize];
    if (folderName&&folderName.length!=0) {
        NSString *folderPath = [self judgePath:path];
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

- (NSArray *)modifyMakeUp:(id)obj forKey:(NSString *)key In:(NSUInteger)index WithPath:(NSString *)path Withtype:(NSString *)type{
    
    NSString *filePatch = [[[TiSDK shareInstance] getMakeupPath] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",path]];
    NSMutableDictionary *plistDictionary = [TiUITool getJsonDataForPath:filePatch];
    
    //修改字典里面的内容,先按照结构取到你想修改内容的小字典
    NSMutableArray *nmArr = [NSMutableArray arrayWithArray:[plistDictionary objectForKey:@"makeups"]];
    
    NSUInteger finalIndex;
    if ([type  isEqual: @"blusher"]) {
        finalIndex = index;
    }else if ([type  isEqual: @"eyebrow"]){
        finalIndex = index+6;
    }else if ([type  isEqual: @"eyeshadow"]){
        finalIndex = index+18;
    }else{
        finalIndex = index+31;
    }
    NSMutableDictionary *nmDic = [NSMutableDictionary dictionaryWithDictionary:nmArr[finalIndex]];
    if ([key isEqual:@"menuTag"]) {
        [nmDic setObject:@([obj intValue]+1) forKey:key];
    }else{
        [nmDic setObject:obj forKey:key];
    }
    //增加dir字段
    if ([type  isEqual: @"blusher"]) {
        [nmDic setObject:self.blusherDir[index] forKey:@"dir"];
        //增加Thumb字段
        [nmDic setObject:self.blusherThumb[index] forKey:@"normalThumb"];
        [nmDic setObject:self.blusherThumb[index] forKey:@"selectedThumb"];
    }else if ([type  isEqual: @"eyebrow"]){
        [nmDic setObject:self.eyebrowDir[index] forKey:@"dir"];
        //增加Thumb字段
        [nmDic setObject:self.eyebrowThumb[index] forKey:@"normalThumb"];
        [nmDic setObject:self.eyebrowThumb[index] forKey:@"selectedThumb"];
    }else if([type isEqual:@"eyeshadow"]){
        [nmDic setObject:self.eyeshadowDir[index] forKey:@"dir"];
        //增加Thumb字段
        [nmDic setObject:self.eyeshadowThumb[index] forKey:@"normalThumb"];
        [nmDic setObject:self.eyeshadowThumb[index] forKey:@"selectedThumb"];
    }else{
        [nmDic setObject:self.lipglossDir[index] forKey:@"dir"];
        //增加Thumb字段
        [nmDic setObject:self.lipglossThumb[index] forKey:@"normalThumb"];
        [nmDic setObject:self.lipglossThumb[index] forKey:@"selectedThumb"];
    }
    //修改完成组建成大字典写入本地
    [nmArr setObject:nmDic atIndexedSubscript:finalIndex];
    [plistDictionary setValue:nmArr forKey:@"makeups"];
    [TiUITool setWriteJsonDic:plistDictionary toPath:filePatch];
    
    //修改mode数组
    NSMutableArray *modeArr;
    if ([type  isEqual: @"blusher"]) {
        modeArr = [NSMutableArray arrayWithArray:self.blusherModArr];
    }else if ([type  isEqual: @"eyebrow"]){
        modeArr = [NSMutableArray arrayWithArray:self.eyebrowsModArr];
    }else if ([type  isEqual: @"eyeshadow"]){
        modeArr = [NSMutableArray arrayWithArray:self.eyeshadowModArr];
    }else if ([type  isEqual: @"lipgloss"]){
        modeArr = [NSMutableArray arrayWithArray:self.lipglossModArr];
    }
    
    if (modeArr.count) {
        TIMenuMode *dome = [TIMenuMode applicationWithDic:nmDic];
        [modeArr setObject:dome atIndexedSubscript:index];
    }
    
    return modeArr;
//
//
//    //修改完成组建成大字典写入本地
//    NSMutableDictionary *nmDic;
//    if ([type  isEqual: @"blusher"]) {
//        //增加dir字段
//        mode.dir = self.blusherDir[index];
//        //增加Thumb字段
//        mode.normalThumb = self.blusherThumb[index];
//        mode.selectedThumb = self.blusherThumb[index];
//
//        nmDic = [NSMutableDictionary dictionaryWithDictionary:menuArr[index]];
//        [nmDic setValue:obj forKey:key];
//        [blusherArr replaceObjectAtIndex:index withObject:mode];
//        [menuArr setObject:nmDic atIndexedSubscript:index];
//    }
//    if ([type  isEqual: @"eyebrow"]) {
//        //增加dir字段
//        mode.dir = self.eyebrowDir[index];
//        //增加Thumb字段
//        mode.normalThumb = self.eyebrowThumb[index];
//        mode.selectedThumb = self.eyebrowThumb[index];
//
//        nmDic = [NSMutableDictionary dictionaryWithDictionary:menuArr[index+6]];
//        [nmDic setValue:obj forKey:key];
//        [eyebrowArr replaceObjectAtIndex:index withObject:mode];
//        [menuArr setObject:nmDic atIndexedSubscript:index+6];
//    }
//    if ([type  isEqual: @"eyeshadow"]){
//        //增加dir字段
//        mode.dir = self.eyeshadowDir[index];
//        //增加Thumb字段
//        mode.normalThumb = self.eyeshadowThumb[index];
//        mode.selectedThumb = self.eyeshadowThumb[index];
//
//        nmDic = [NSMutableDictionary dictionaryWithDictionary:menuArr[index+18]];
//        [nmDic setValue:obj forKey:key];
//        [eyeshadowArr replaceObjectAtIndex:index withObject:mode];
//        [menuArr setObject:nmDic atIndexedSubscript:index+18];
//    }
//
//    [plistDictionary setValue:menuArr forKey:@"makeups"];
//    [TiUITool setWriteJsonDic:plistDictionary toPath:filePatch];
//
//    if ([type  isEqual: @"blusher"]) {
//        return blusherArr;
//    }
//    else if ([type  isEqual: @"eyebrow"]) {
//        return eyebrowArr;
//    }
//    else{
//        return eyeshadowArr;
//    }

}
    
- (NSArray *)modifyObject:(id)obj forKey:(NSString *)key In:(NSUInteger)index WithPath:(NSString *)path{
    
    if (([path isEqualToString:@"gestures"] ||
         [path isEqualToString:@"gifts"] ||
         [path isEqualToString:@"greenscreens"] ||
         [path isEqualToString:@"interactions"] ||
         [path isEqualToString:@"TiMakeUpDef"] ||
         [path isEqualToString:@"masks"] ||
         [path isEqualToString:@"portraits"] ||
         [path isEqualToString:@"stickers"] ||
         [path isEqualToString:@"watermarks"]) && (index == 0)) {
        
        //修改mode数组
        NSMutableArray *modeArr;
        
        if ([path isEqualToString:@"gestures"]){
            modeArr = [NSMutableArray arrayWithArray:self.gesturesModArr];
        }
        
        else if ([path isEqualToString:@"gifts"]){
            modeArr = [NSMutableArray arrayWithArray:self.giftModeArr];
        }
        
        else if ([path isEqualToString:@"greenscreens"]){
            modeArr = [NSMutableArray arrayWithArray:self.greenscreensModeArr];
        }
        
        else if ([path isEqualToString:@"interactions"]){
            modeArr = [NSMutableArray arrayWithArray:self.interactionsArr];
        }
        
        else if ([path isEqualToString:@"TiMakeUpDef"]){
            modeArr = [NSMutableArray arrayWithArray:self.makeupModArr];
        }
        
        else if ([path isEqualToString:@"masks"]){
            modeArr = [NSMutableArray arrayWithArray:self.masksModeArr];
        }
        
        else if ([path isEqualToString:@"portraits"]){
            modeArr = [NSMutableArray arrayWithArray:self.portraitsModArr];
        }
        
        else if ([path isEqualToString:@"stickers"]){
            modeArr = [NSMutableArray arrayWithArray:self.stickersModeArr];
        }
        
        else if ([path isEqualToString:@"watermarks"]){
            modeArr = [NSMutableArray arrayWithArray:self.watermarksModeArr];
        }
        
        TIMenuMode *mode = modeArr[0];
        
        if ([key isEqual:@"selected"]) {
            mode.selected = [obj boolValue];
        }
        if ([key isEqual:@"downloaded"]) {
            mode.downloaded = [obj boolValue];
        }
        if ([key isEqual:@"menuTag"]) {
            mode.menuTag = [obj intValue];
        }
        
        if (modeArr.count) {
            [modeArr replaceObjectAtIndex:0 withObject:mode];
        }
        
        return modeArr;
        
    }else{
        
        if ([path isEqualToString:@"greenscreens"] && (index == 1)) {
            
            //修改mode数组
            NSMutableArray *modeArr = [NSMutableArray arrayWithArray:self.greenscreensModeArr];
            TIMenuMode *mode = modeArr[1];
            if ([key  isEqual: @"menuTag"]) {
                mode.menuTag = 1;
            }else{
                NSLog(@"");
            }
            if (modeArr.count) {
                [modeArr replaceObjectAtIndex:1 withObject:mode];
            }
            return modeArr;
            
        }else{
            
            NSString *filePatch = [[self judgePath:path] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.json",path]];
            NSMutableDictionary *plistDictionary = [TiUITool getJsonDataForPath:filePatch];
            
            //修改字典里面的内容,先按照结构取到你想修改内容的小字典
            NSMutableArray *nmArr = [NSMutableArray arrayWithArray:[plistDictionary objectForKey:@"menu"]];
            if ([path isEqualToString:@"greenscreens"]) {
                nmArr = [NSMutableArray arrayWithArray:[plistDictionary objectForKey:@"greenScreens"]];
            }else if ([path isEqualToString:@"gestures"] ||
                [path isEqualToString:@"gifts"] ||
                [path isEqualToString:@"interactions"] ||
                [path isEqualToString:@"masks"] ||
                [path isEqualToString:@"portraits"] ||
                [path isEqualToString:@"stickers"] ||
                [path isEqualToString:@"watermarks"]) {
                nmArr = [NSMutableArray arrayWithArray:[plistDictionary objectForKey:path]];
            }
            
            NSMutableDictionary *nmDic;
            if ([path isEqualToString:@"greenscreens"]) {
                nmDic = [NSMutableDictionary dictionaryWithDictionary:nmArr[index-2]];
            }else if ([path isEqualToString:@"gestures"] ||
                [path isEqualToString:@"gifts"] ||
                [path isEqualToString:@"interactions"] ||
                [path isEqualToString:@"masks"] ||
                [path isEqualToString:@"portraits"] ||
                [path isEqualToString:@"stickers"] ||
                [path isEqualToString:@"watermarks"]) {
                nmDic = [NSMutableDictionary dictionaryWithDictionary:nmArr[index-1]];
            }else {
                nmDic = [NSMutableDictionary dictionaryWithDictionary:nmArr[index]];
            }
            [nmDic setObject:obj forKey:key];
            
            //修改完成组建成大字典写入本地
            if ([path isEqualToString:@"greenscreens"]) {
                [nmArr setObject:nmDic atIndexedSubscript:index-2];
                [plistDictionary setValue:nmArr forKey:@"greenScreens"];
            }else if ([path isEqualToString:@"gestures"] ||
                [path isEqualToString:@"gifts"] ||
                [path isEqualToString:@"interactions"] ||
                [path isEqualToString:@"TiMakeUpDef"] ||
                [path isEqualToString:@"masks"] ||
                [path isEqualToString:@"portraits"] ||
                [path isEqualToString:@"stickers"] ||
                [path isEqualToString:@"watermarks"]) {
                [nmArr setObject:nmDic atIndexedSubscript:index-1];
                [plistDictionary setValue:nmArr forKey:path];
            }else{
                [nmArr setObject:nmDic atIndexedSubscript:index];
                [plistDictionary setValue:nmArr forKey:@"menu"];
            }
            [TiUITool setWriteJsonDic:plistDictionary toPath:filePatch];
            
            //修改mode数组
            NSMutableArray *modeArr;
            if ([path isEqualToString:@"TiMenu"]) {
                modeArr = [NSMutableArray arrayWithArray:self.mainModeArr];
            }
            
            else if ([path isEqualToString:@"TiBeauty"]){
                modeArr = [NSMutableArray arrayWithArray:self.beautyModeArr];
            }
            
            else if ([path isEqualToString:@"TiAppearance"]){
                modeArr = [NSMutableArray arrayWithArray:self.appearanceModeArr];
            }
            
            else if ([path isEqualToString:@"TiFilter"]){
                modeArr = [NSMutableArray arrayWithArray:self.filterModeArr];
            }
            
            else if ([path isEqualToString:@"TiRock"]){
                modeArr = [NSMutableArray arrayWithArray:self.rockModeArr];
            }
            
            else if ([path isEqualToString:@"TiDistortion"]){
                modeArr = [NSMutableArray arrayWithArray:self.distortionModeArr];
            }
            
            else if ([path isEqualToString:@"gestures"]){
                modeArr = [NSMutableArray arrayWithArray:self.gesturesModArr];
            }
            
            else if ([path isEqualToString:@"gifts"]){
                modeArr = [NSMutableArray arrayWithArray:self.giftModeArr];
            }
            
            else if ([path isEqualToString:@"greenscreens"]){
                modeArr = [NSMutableArray arrayWithArray:self.greenscreensModeArr];
            }
            
            else if ([path isEqualToString:@"interactions"]){
                modeArr = [NSMutableArray arrayWithArray:self.interactionsArr];
            }
            
            else if ([path isEqualToString:@"masks"]){
                modeArr = [NSMutableArray arrayWithArray:self.masksModeArr];
            }
            
            else if ([path isEqualToString:@"portraits"]){
                modeArr = [NSMutableArray arrayWithArray:self.portraitsModArr];
            }
            
            else if ([path isEqualToString:@"stickers"]){
                modeArr = [NSMutableArray arrayWithArray:self.stickersModeArr];
            }
            
            else if ([path isEqualToString:@"watermarks"]){
                modeArr = [NSMutableArray arrayWithArray:self.watermarksModeArr];
            }
            
            else if ([path isEqualToString:@"TiOneKeyBeauty"]){
                modeArr = [NSMutableArray arrayWithArray:self.onekeyModeArr];
            }
            
            else if ([path isEqualToString:@"TiFaceShape"]){
                modeArr = [NSMutableArray arrayWithArray:self.faceshapeModeArr];
            }
            
            else if ([path isEqualToString:@"TiHairdressDef"]){
                modeArr = [NSMutableArray arrayWithArray:self.hairdressModArr];
            }
            
            if (modeArr.count) {
                TIMenuMode *dome = [TIMenuMode applicationWithDic:nmDic];
                [modeArr setObject:dome atIndexedSubscript:index];
            }
            
            return modeArr;
            
        }
        
    }
    
}

//萌颜json单独判断
- (NSString *)judgePath:(NSString *)path{
    
    NSString *folderPath = [[TiSDK shareInstance] getResPath];
    if ([path isEqualToString:@"gestures"]) {
        folderPath = [[TiSDK shareInstance] getGesturePath];
    }
    if ([path isEqualToString:@"gifts"]) {
        folderPath = [[TiSDK shareInstance] getGiftPath];
    }
    if ([path isEqualToString:@"greenscreens"]) {
        folderPath = [[TiSDK shareInstance] getGreenScreenPath];
    }
    if ([path isEqualToString:@"interactions"]) {
        folderPath = [[TiSDK shareInstance] getInteractionPath];
    }
    if ([path isEqualToString:@"masks"]) {
        folderPath = [[TiSDK shareInstance] getMaskPath];
    }
    if ([path isEqualToString:@"portraits"]) {
        folderPath = [[TiSDK shareInstance] getPortraitPath];
    }
    if ([path isEqualToString:@"stickers"]) {
        folderPath = [[TiSDK shareInstance] getStickerPath];
    }
    if ([path isEqualToString:@"watermarks"]) {
        folderPath = [[TiSDK shareInstance] getWatermarkPath];
    }
    return folderPath;
    
}

- (void)getResourceFromJsonName:(NSString *)name{
    
    NSString *resourcesPath = [[[TiSDK shareInstance] getResPath] stringByAppendingPathComponent:name];
    if (![[NSFileManager defaultManager] fileExistsAtPath:resourcesPath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:resourcesPath withIntermediateDirectories:NO attributes:nil error:nil];
    }
    NSString *bundleJson = @"";
    
    if ([name isEqualToString:@"sticker"])
    {
        bundleJson = @"stickers.json";
    }
    else if([name isEqualToString:@"gift"])
    {
        bundleJson = @"TiGifts.json";
    }
    else if ([name isEqualToString:@"watermark"])
    {
        bundleJson = @"TiWaterMarks.json";
    }
    else if([name isEqualToString:@"mask"])
    {
        bundleJson = @"TiMasks.json";
    }
    else if([name isEqualToString:@"greenscreen"])
    {
        bundleJson = @"greenscreens.json";
    }
    else if([name isEqualToString:@"interactions"])
    {
        bundleJson = @"interactions.json";
    }
    else if([name isEqualToString:@"portrait"])
    {
        bundleJson = @"TiPortraits.json";
    }
    else if([name isEqualToString:@"gesture"])
    {
        bundleJson = @"TiGestures.json";
    }
    
    NSString *configPath = [[NSBundle mainBundle].bundlePath stringByAppendingPathComponent:bundleJson];
    if (![[NSFileManager defaultManager] fileExistsAtPath:configPath isDirectory:NULL]) {
        NSLog(@"The general configuration file for the json in the resource directory does not exist");
        return ;
    }
    NSError *error = nil;
    NSData *data = [NSData dataWithContentsOfFile:configPath];
    NSDictionary *oldDict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (!oldDict || error) {
        NSLog(@"Resource directory under the general configuration file to read the jsonS failed:%@",error);
        return ;
    }
    
    //拷贝本地贴纸到沙盒
//    NSString *localPath = [[[NSBundle mainBundle] pathForResource:@"TiSDKResource" ofType:@"bundle"] stringByAppendingPathComponent:name];
//    NSArray *dirArr = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:localPath error:NULL];
//    for (NSString *stickerName in dirArr) {
//        if (![[NSFileManager defaultManager] fileExistsAtPath:[resourcesPath stringByAppendingPathComponent:stickerName]]) {
//            [[NSFileManager defaultManager] copyItemAtPath:[localPath stringByAppendingPathComponent:stickerName] toPath:[resourcesPath stringByAppendingPathComponent:stickerName] error:NULL];
//        }
//        //判断bundle中是否含有json文件 如果有 将json文件赋值给UITool 配置json文件
//        if ([stickerName containsString:@".json"]) {}
//           //修改配置文件json
//       }
}


@end


@implementation TIMenuMode

- (instancetype)initWithDic:(NSDictionary *)dic{
    
    if (self = [super init]) {
        // KVC
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
    
}

+ (instancetype)applicationWithDic:(NSDictionary*)dic{
    
     TIMenuMode * mode = [[TIMenuMode alloc] initWithDic:dic];
     return mode;
    
}
 
@end
