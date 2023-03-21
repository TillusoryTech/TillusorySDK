//
//  TiDownloadZipManager.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/10.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TiUIConfig.h"

@interface TiDownloadZipManager : NSObject

typedef NS_ENUM(NSInteger, DownloadedType) {
    TI_DOWNLOAD_TYPE_Sticker = 2, // 贴纸
    TI_DOWNLOAD_STATE_Gift = 3, // 礼物
    TI_DOWNLOAD_STATE_Watermark = 7,// 水印
    TI_DOWNLOAD_STATE_Mask = 8,// 面具
    TI_DOWNLOAD_STATE_Greenscreen = 9,// 绿幕
    TI_DOWNLOAD_STATE_Interactions = 11,// 互动贴纸
    TI_DOWNLOAD_STATE_Portraits = 14,// 抠图
    TI_DOWNLOAD_STATE_Gestures = 16,// 手势识别
    
    TI_DOWNLOAD_STATE_Makeup = 12,// 美妆
    TI_DOWNLOAD_STATE_Makeup_blusher = 1201,// 美妆-腮红
    //    TI_DOWNLOAD_STATE_Makeup_eyelash = 1202,// 美妆-睫毛
    TI_DOWNLOAD_STATE_Makeup_eyebrow = 1202,// 美妆-眉毛
    TI_DOWNLOAD_STATE_Makeup_eyeshadow = 1203,// 美妆-眼影
    TI_DOWNLOAD_STATE_Makeup_lipgloss = 1204,// 美妆-唇彩
    //    TI_DOWNLOAD_STATE_Makeup_eyeline = 1205,// 美妆-眼线
    
};

// MARK: --单例初始化方法--
+ (TiDownloadZipManager *)shareManager;
+ (void)releaseShareManager;

- (void)downloadSuccessedType:(DownloadedType)type MenuMode:(TIMenuMode *)mode completeBlock:(void(^)(BOOL successful))completeBlock;

@end
