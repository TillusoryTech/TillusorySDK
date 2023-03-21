//
//  TiUIMainMenuViewModel.m
//  TiUIMainMenuViewModel
//
//  Created by N17 on 2021/8/24.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiUIMainMenuViewModel.h"
#import "TiUIManager.h"
#import "TiUIConfig.h"
#import "TiSetSDKParameters.h"

@implementation TiUIMainMenuViewModel

- (instancetype)initWithAspectRatio:(NSString *)switchAspectRatio{
    self = [super init];
    if (self) {
        self.switchAspectRatio = switchAspectRatio;
        self.isResetting = false;
        self.resetObject = @"";
        self.switchByName = @"";
        self.is_greenEdit = 1;
        // 默认隐藏
        self.sliderHidden = @1;
    }
    return self;
}

// 设置滑动条参数
- (NSDictionary *)getSliderTypeAndValue:(BOOL)isMonitor{
    TiUISliderType sliderType = TiSliderTypeOne;
    TiUIDataCategoryKey categoryKey = TI_UIDCK_SKIN_WHITENING_SLIDER;
    
    if (self.mainindex == 0) {
        NSInteger key = self.subindex;
        switch (key) {
            case 0:
                sliderType = TiSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_WHITENING_SLIDER;// 美白
                break;
            case 1:
                sliderType = TiSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER;// 磨皮
                break;
            case 2:
                sliderType = TiSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_TENDERNESS_SLIDER;// 粉嫩
                break;
            case 3:
                sliderType = TiSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_SKINBRIGGT_SLIDER;// 清晰
                break;
            case 4:
                sliderType = TiSliderTypeTwo;
                categoryKey = TI_UIDCK_SKIN_BRIGHTNESS_SLIDER;// 亮度
                break;
            case 5:
                sliderType = TiSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER;// 精细磨皮
                break;
            case 6:
                sliderType = TiSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_PRECISE_TENDERNESS_SLIDER;// 精细粉嫩
                break;
            case 7:
                sliderType = TiSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_HIGH_LIGHT_SLIDER;// 立体
                break;
            case 8:
                sliderType = TiSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_DARK_CIRCLE_SLIDER;// 黑眼圈
                break;
            case 9:
                sliderType = TiSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_CROWS_FEET_SLIDER;// 鱼尾纹
                break;
            case 10:
                sliderType = TiSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_NASOLABIAL_FOLD_SLIDER;// 法令纹
                break;
            default:
                break;
        }
    }else if (self.mainindex == 1){
        categoryKey = (self.mainindex+1)*100 + self.subindex;
        switch (self.subindex) {
            case 0:
            case 1:
            case 2:
            case 5:
            case 6:
            case 7:
            case 12:
            case 17:
            case 22:
                sliderType = TiSliderTypeOne;
                break;
            case 3:
            case 4:
            case 8:
            case 9:
            case 10:
            case 11:
            case 13:
            case 14:
            case 15:
            case 16:
            case 18:
            case 19:
            case 20:
            case 21:
                sliderType = TiSliderTypeTwo;
                break;
            default:
                break;
        }
    }else if (self.mainindex == 4){
        
        sliderType = TiSliderTypeOne;
        categoryKey = (self.mainindex-1)*100 + self.subindex;
        if (isMonitor == NO) {
            if (self.subindex != 0) {
                self.sliderHidden = @0;
            }else{
                self.sliderHidden = @1;
            }
        }
        
    }else if (self.mainindex == 9){
        
        if (self.is_greenEdit == 1) {
            sliderType = TiSliderTypeTwo;
        }else{
            sliderType = TiSliderTypeOne;
        }
        categoryKey = 700 + self.is_greenEdit;
        if (isMonitor == NO) {
            self.sliderHidden = @0;
        }
        
    }else if (self.mainindex == 10){
        
        categoryKey = TI_UIDCK_ONEKEY_SLIDER;// 一键美颜
        
    }else if (self.mainindex == 12){
        
        int thousand = (int)self.subindex/1000 *1000;// 千
        categoryKey = thousand;//  对应key
        sliderType = TiSliderTypeOne;
        if (isMonitor == NO) {
            self.sliderHidden = @0;
        }
        
    }else if (self.mainindex == 13){
        
        categoryKey = TI_UIDCK_FACESHAPE_SLIDER;// 脸型
        
    }else if (self.mainindex == 15 || self.mainindex == 18){
        
        sliderType = TiSliderTypeOne;
        categoryKey = TI_UIDCK_HAIRDRESS_SLIDER;// 美发
        if (isMonitor == NO) {
            if (self.subindex != 0) {
                self.sliderHidden = @0;
            }else{
                self.sliderHidden = @1;
            }
        }
        
    }
    NSDictionary *sliderDic = @{@"type":@(sliderType),@"key":@([TiSetSDKParameters getFloatValueForKey:categoryKey])};
    return sliderDic;
    
}

- (void)setIndexByMenuTag:(int)menuTag{
    self.mainindex = menuTag;
    [TiUIManager shareManager].tiUIViewBoxView.sliderRelatedView.userInteractionEnabled = YES;
    switch (menuTag) {
        case 0:{
            for (TIMenuMode *mod in [TiMenuPlistManager shareManager].beautyModeArr) {
                if (mod.selected) {
                    self.subindex = mod.menuTag;
                }
            }
            TIMenuMode *beautyMod = [TiMenuPlistManager shareManager].mainModeArr[0];
            [TiUIManager shareManager].tiUIViewBoxView.sliderRelatedView.userInteractionEnabled = beautyMod.totalSwitch;
            self.sliderHidden = @0;
            break;}
        case 1:{
            for (TIMenuMode *mod in [TiMenuPlistManager shareManager].appearanceModeArr) {
                if (mod.selected) {
                    self.subindex = mod.menuTag;
                }
            }
            TIMenuMode *appearanceMod = [TiMenuPlistManager shareManager].mainModeArr[1];
            [TiUIManager shareManager].tiUIViewBoxView.sliderRelatedView.userInteractionEnabled = appearanceMod.totalSwitch;
            self.sliderHidden = @0;
            break;}
        case 4:
            for (TIMenuMode *mod in [TiMenuPlistManager shareManager].filterModeArr) {
                if (mod.selected) {
                    self.subindex = mod.menuTag;
                }
            }
            if (self.subindex != 0) {
                self.sliderHidden = @0;
            }else{
                self.sliderHidden = @1;
            }
            break;
        case 10:
            for (TIMenuMode *mod in [TiMenuPlistManager shareManager].onekeyModeArr) {
                if (mod.selected) {
                    self.subindex = mod.menuTag;
                }
            }
            // 强制开启美颜、美型
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TIUIMenuOne_isOpen" object:@(true)];
            self.sliderHidden = @0;
            break;
        case 11:
            for (TIMenuMode *mod in [TiMenuPlistManager shareManager].interactionsArr) {
                if (mod.selected) {
                    [[TiUIManager shareManager] setInteractionHintL:mod.hint];
                }
            }
            self.sliderHidden = @1;
            break;
        case 12:{ // 美妆
            TIMenuMode *makeUpMod = [TiMenuPlistManager shareManager].mainModeArr[12];
            [TiUIManager shareManager].tiUIViewBoxView.sliderRelatedView.userInteractionEnabled = makeUpMod.totalSwitch;
            self.sliderHidden = @1;
            break;}
        case 13: // 脸型
            for (TIMenuMode *mod in [TiMenuPlistManager shareManager].faceshapeModeArr) {
                if (mod.selected) {
                    self.subindex = mod.menuTag;
                }
            }
            self.sliderHidden = @0;
            break;
        case 15:// 美发
            for (TIMenuMode *mod in [TiMenuPlistManager shareManager].hairdressModArr) {
                if (mod.selected) {
                    self.subindex = mod.menuTag;
                }
            }
            if (self.subindex != 0) {
                self.sliderHidden = @0;
            }else{
                self.sliderHidden = @1;
            }
            // 隐藏重置按钮
            self.resetObject = @"";
            break;
        case 16:
            for (TIMenuMode *mod in [TiMenuPlistManager shareManager].gesturesModArr) {
                if (mod.selected) {
                    [[TiUIManager shareManager] setInteractionHintL:mod.hint];
                }
            }
            self.sliderHidden = @1;
            break;
        default:
            self.sliderHidden = @1;
            break;
    }
    
}

- (void)saveParameters:(int)value{
    
    TiUIDataCategoryKey valueForKey;
    if (self.mainindex == 10) {// 一键美颜
        if (value == 100 && self.subindex == 0) {
            self.resetObject = @"关闭重置";
        }else{
            self.resetObject = @"重置美颜";
        }
        valueForKey = TI_UIDCK_ONEKEY_SLIDER;
        
    }else if (self.mainindex == 0){// 美颜
        
        self.resetObject = @"重置美颜";
        TIMenuMode *mod = [TiMenuPlistManager shareManager].beautyModeArr[self.subindex];
        if (self.subindex >= 5) {
            mod = [TiMenuPlistManager shareManager].beautyModeArr[self.subindex+1];
        }
        valueForKey  = (self.mainindex+1)*100 + mod.menuTag;
        if ([mod.name  isEqual: NSLocalizedString(@"磨皮", nil)] && value != 0) {
            // 调整精细磨皮参数
            [TiSetSDKParameters setFloatValue:0 forKey:TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER];
        }else if ([mod.name  isEqual: NSLocalizedString(@"精细磨皮", nil)] && value != 0) {
            // 调整磨皮参数
            [TiSetSDKParameters setFloatValue:0 forKey:TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER];
        }else if ([mod.name  isEqual: NSLocalizedString(@"粉嫩", nil)] && value != 0) {
            // 调整精细粉嫩参数
            [TiSetSDKParameters setFloatValue:0 forKey:TI_UIDCK_SKIN_PRECISE_TENDERNESS_SLIDER];
        }else if ([mod.name  isEqual: NSLocalizedString(@"精细粉嫩", nil)] && value != 0) {
            // 调整粉嫩参数
            [TiSetSDKParameters setFloatValue:0 forKey:TI_UIDCK_SKIN_TENDERNESS_SLIDER];
        }
        
    }else if (self.mainindex == 13){// 脸型
        self.resetObject = @"重置美颜";
        valueForKey = TI_UIDCK_FACESHAPE_SLIDER;
    }else if (self.mainindex == 1){// 美型
        self.resetObject = @"重置美颜";
        valueForKey  = (self.mainindex+1)*100 + self.subindex;
    }else if (self.mainindex==4) {// 滤镜
        valueForKey = (self.mainindex-1)*100 + self.subindex;
    }else if (self.mainindex == 9){// 绿幕
        valueForKey = 700 + self.is_greenEdit;
        // 开启绿幕编辑恢复功能
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TiUIGreenScreensView_isResetEdit" object:@(true)];
    }else if(self.mainindex ==12){// 美妆
        self.resetObject = @"重置美妆";
        int thousand =  (int)self.subindex/1000 *1000;// 千
        valueForKey = thousand;
    }else if (self.mainindex==15 || self.mainindex==18) {// 美发
        valueForKey = TI_UIDCK_HAIRDRESS_SLIDER;
    }else{
        valueForKey  = (self.mainindex+1)*100 + self.subindex;
    }
    
    // 储存滑条参数
    [TiSetSDKParameters setFloatValue:value forKey:valueForKey];
    // 设置美颜参数
    [TiSetSDKParameters setBeautySlider:value forKey:valueForKey withIndex:self.subindex];
    
}

@end
