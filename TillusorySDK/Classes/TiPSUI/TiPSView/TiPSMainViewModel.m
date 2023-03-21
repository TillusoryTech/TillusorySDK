//
//  TiPSMainViewModel.m
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSMainViewModel.h"
#import "TiPSConfig.h"


@implementation TiPSMainViewModel

- (instancetype)initWithAspectRatio:(NSString *)aspectRatio{
    self = [super init];
    if (self) {
        self.resetObject = @"";
        // 默认隐藏
        self.sliderHidden = @1;
    }
    return self;
}

// 设置滑动条参数
- (NSDictionary *)getSliderTypeAndValue:(BOOL)isMonitor{
    TiPSSliderType sliderType = TiPSSliderTypeOne;
    TiUIDataCategoryKey categoryKey = TI_UIDCK_SKIN_WHITENING_SLIDER;
    
    if (self.mainindex == 0){// 一键美颜
        categoryKey = TI_UIDCK_ONEKEY_SLIDER;
    }else if (self.mainindex == 1) {// 美颜
        NSInteger key = self.subindex;
        switch (key) {
            case 0:
                sliderType = TiPSSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_WHITENING_SLIDER;// 美白
                break;
            case 1:
                sliderType = TiPSSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER;// 磨皮
                break;
            case 2:
                sliderType = TiPSSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_TENDERNESS_SLIDER;// 粉嫩
                break;
            case 3:
                sliderType = TiPSSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_SKINBRIGGT_SLIDER;// 清晰
                break;
            case 4:
                sliderType = TiPSSliderTypeTwo;
                categoryKey = TI_UIDCK_SKIN_BRIGHTNESS_SLIDER;// 亮度
                break;
            case 5:
                sliderType = TiPSSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER;// 精细磨皮
                break;
            case 6:
                sliderType = TiPSSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_PRECISE_TENDERNESS_SLIDER;// 精细粉嫩
                break;
            case 7:
                sliderType = TiPSSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_HIGH_LIGHT_SLIDER;// 立体
                break;
            case 8:
                sliderType = TiPSSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_DARK_CIRCLE_SLIDER;// 黑眼圈
                break;
            case 9:
                sliderType = TiPSSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_CROWS_FEET_SLIDER;// 鱼尾纹
                break;
            case 10:
                sliderType = TiPSSliderTypeOne;
                categoryKey = TI_UIDCK_SKIN_NASOLABIAL_FOLD_SLIDER;// 法令纹
                break;
            default:
                break;
        }
    }else if (self.mainindex == 2){// 脸型
        categoryKey = TI_UIDCK_FACESHAPE_SLIDER;
    }else if (self.mainindex == 3){// 美型
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
                sliderType = TiPSSliderTypeOne;
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
                sliderType = TiPSSliderTypeTwo;
                break;
            default:
                break;
        }
    }else if (self.mainindex == 4){//滤镜
        sliderType = TiPSSliderTypeOne;
        categoryKey = (self.mainindex+1)*100 + self.subindex;
        if (isMonitor == NO) {
            if (self.subindex != 0) {
                self.sliderHidden = @0;
            }else{
                self.sliderHidden = @1;
            }
        }
    }
    
    NSDictionary *sliderDic = @{@"type":@(sliderType),@"key":@([TiPSSetSDKParameters getPSFloatValueForKey:categoryKey])};
    return sliderDic;
    
}

- (void)setIndexByMenuTag:(int)menuTag{
    self.mainindex = menuTag;
    switch (menuTag) {
        case 0:// 一键美颜
            for (TiPSMode *mod in [TiPSPlistManager shareManager].onekeyModeArr) {
                if (mod.selected) {
                    self.subindex = mod.menuTag;
                }
            }
            // 强制开启美颜、美型
            [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TIUIMenuOne_isOpen" object:@(true)];
            self.sliderHidden = @0;
            break;
        case 1:{// 美颜
            for (TiPSMode *mod in [TiPSPlistManager shareManager].beautyModeArr) {
                if (mod.selected) {
                    self.subindex = mod.menuTag;
                }
            }
            self.sliderHidden = @0;
            break;}
        case 2: // 脸型
            for (TiPSMode *mod in [TiPSPlistManager shareManager].faceshapeModeArr) {
                if (mod.selected) {
                    self.subindex = mod.menuTag;
                }
            }
            self.sliderHidden = @0;
            break;
        case 3:{// 美型
            for (TiPSMode *mod in [TiPSPlistManager shareManager].appearanceModeArr) {
                if (mod.selected) {
                    self.subindex = mod.menuTag;
                }
            }
            self.sliderHidden = @0;
            break;}
        case 4:// 滤镜
            for (TiPSMode *mod in [TiPSPlistManager shareManager].filterModeArr) {
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
        default:
            self.sliderHidden = @1;
            break;
    }
    
}

- (void)saveParameters:(int)value{
    
    TiUIDataCategoryKey valueForKey;
    if (self.mainindex == 0) {// 一键美颜
        if (value == 100 && self.subindex == 0) {
            self.resetObject = @"关闭重置";
        }else{
            self.resetObject = @"重置美颜";
        }
        valueForKey = TI_UIDCK_ONEKEY_SLIDER;
        
    }else if (self.mainindex == 1){// 美颜
        
        self.resetObject = @"重置美颜";
        TiPSMode *mod = [TiPSPlistManager shareManager].beautyModeArr[self.subindex];
        if (self.subindex >= 5) {
            mod = [TiPSPlistManager shareManager].beautyModeArr[self.subindex+1];
        }
        valueForKey  = (self.mainindex+1)*100 + mod.menuTag;
        if ([mod.name  isEqual: NSLocalizedString(@"磨皮", nil)] && value != 0) {
            // 调整精细磨皮参数
            [TiPSSetSDKParameters setPSFloatValue:0 forKey:TI_UIDCK_SKIN_PRECISE_BEAUTY_SLIDER];
        }else if ([mod.name  isEqual: NSLocalizedString(@"精细磨皮", nil)] && value != 0) {
            // 调整磨皮参数
            [TiPSSetSDKParameters setPSFloatValue:0 forKey:TI_UIDCK_SKIN_BLEMISH_REMOVAL_SLIDER];
        }else if ([mod.name  isEqual: NSLocalizedString(@"粉嫩", nil)] && value != 0) {
            // 调整精细粉嫩参数
            [TiPSSetSDKParameters setPSFloatValue:0 forKey:TI_UIDCK_SKIN_PRECISE_TENDERNESS_SLIDER];
        }else if ([mod.name  isEqual: NSLocalizedString(@"精细粉嫩", nil)] && value != 0) {
            // 调整粉嫩参数
            [TiPSSetSDKParameters setPSFloatValue:0 forKey:TI_UIDCK_SKIN_TENDERNESS_SLIDER];
        }
        
    }else if (self.mainindex == 2){// 脸型
        self.resetObject = @"重置美颜";
        valueForKey = TI_UIDCK_FACESHAPE_SLIDER;
    }else if (self.mainindex == 3){// 美型
        self.resetObject = @"重置美颜";
        valueForKey  = (self.mainindex+1)*100 + self.subindex;
    }else{// 滤镜
        valueForKey = (self.mainindex+1)*100 + self.subindex;
    }
    
    // 储存滑条参数
    [TiPSSetSDKParameters setPSFloatValue:value forKey:valueForKey];
    // 设置美颜参数
    [TiPSSetSDKParameters setPSBeautySlider:value forKey:valueForKey withIndex:self.subindex];
    
}

@end
