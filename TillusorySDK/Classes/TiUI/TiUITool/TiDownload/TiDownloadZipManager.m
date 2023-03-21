//
//  TiDownloadZipManager.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/10.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiDownloadZipManager.h"
#import <SSZipArchive/SSZipArchive.h>

@interface TiDownloadZipManager ()<NSURLSessionDelegate,SSZipArchiveDelegate>

@property(nonatomic,copy)void(^completeBlock)(BOOL successful);
@property(nonatomic, strong) NSURLSession *session;

@end

static TiDownloadZipManager *shareManager = NULL;

@implementation TiDownloadZipManager

+ (void)releaseShareManager{
    shareManager = nil;
}

// MARK: --单例初始化方法--
+ (TiDownloadZipManager *)shareManager {
    shareManager = [[TiDownloadZipManager alloc] init];
    return shareManager;
}

- (NSURLSession *)session {
    if (!_session) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    }
    return _session;
}

- (instancetype)init
{
    self = [super init];
    return self;
}

// 下载&缓存地址
- (void)downloadSuccessedType:(DownloadedType)type MenuMode:(TIMenuMode *)mode completeBlock:(void(^)(BOOL successful))completeBlock{
    
    NSString *downloadURL = @"";
    NSString *cachePaths = @"";
    
    switch (type) {
        case TI_DOWNLOAD_TYPE_Sticker:// 贴纸
            downloadURL = [[TiSDK shareInstance].getStickerUrl stringByAppendingFormat:@"/%@.zip",mode.name];
            cachePaths =  [TiSDK shareInstance].getStickerPath;
            break;
        case TI_DOWNLOAD_STATE_Gift:// 礼物
            downloadURL = [[TiSDK shareInstance].getGiftUrl stringByAppendingFormat:@"/%@.zip",mode.name];
            cachePaths =  [TiSDK shareInstance].getGiftPath;
            break;
        case TI_DOWNLOAD_STATE_Watermark:// 水印
            downloadURL = [[TiSDK shareInstance].getWatermarkUrl stringByAppendingFormat:@"/%@.zip",mode.name];
            cachePaths =  [TiSDK shareInstance].getWatermarkPath;
            break;
        case TI_DOWNLOAD_STATE_Mask:// 面具
            downloadURL = [[TiSDK shareInstance].getMaskUrl stringByAppendingFormat:@"/%@.png",mode.name];
            cachePaths =  [TiSDK shareInstance].getMaskPath;
            cachePaths =  [cachePaths stringByAppendingFormat:@"/%@",mode.name];
            break;
        case TI_DOWNLOAD_STATE_Greenscreen:// 绿幕抠图
            downloadURL = [[TiSDK shareInstance].getGreenScreenUrl stringByAppendingFormat:@"/%@",mode.name];
            cachePaths =  [TiSDK shareInstance].getGreenScreenPath;
            break;
        case TI_DOWNLOAD_STATE_Interactions:// 互动
            downloadURL = [[TiSDK shareInstance].getInteractionUrl stringByAppendingFormat:@"/%@.zip",mode.name];
            cachePaths =  [TiSDK shareInstance].getInteractionPath;
            break;
        case TI_DOWNLOAD_STATE_Makeup:// 美妆主菜单UI
            downloadURL = [[TiSDK shareInstance].getMakeupUrl stringByAppendingFormat:@"/%@.zip",mode.name];
            cachePaths =  [TiSDK shareInstance].getMakeupPath;
            break;
        case TI_DOWNLOAD_STATE_Makeup_blusher:// 美妆-腮红
            downloadURL = [[TiSDK shareInstance].getMakeupUrl stringByAppendingFormat:@"/%@.png",mode.name];
            cachePaths =  [TiSDK shareInstance].getMakeupPath;
            cachePaths =  [cachePaths stringByAppendingFormat:@"/blusher/%@",mode.name];
            break;
            //        case TI_DOWNLOAD_STATE_Makeup_eyelash:// 美妆-睫毛
            //            downloadURL = [[TiSDK shareInstance].getMakeupUrl stringByAppendingFormat:@"/%@.png",mode.name];
            //            cachePaths =  [TiSDK shareInstance].getMakeupPath;
            //            cachePaths =  [cachePaths stringByAppendingFormat:@"/eyelash/%@",mode.name];
            //            break;
        case TI_DOWNLOAD_STATE_Makeup_eyebrow:// 美妆-眉毛
            downloadURL = [[TiSDK shareInstance].getMakeupUrl stringByAppendingFormat:@"/%@.png",mode.name];
            cachePaths =  [TiSDK shareInstance].getMakeupPath;
            cachePaths =  [cachePaths stringByAppendingFormat:@"/eyebrow/%@",mode.name];
            break;
        case TI_DOWNLOAD_STATE_Makeup_eyeshadow:// 美妆-眼影
            downloadURL = [[TiSDK shareInstance].getMakeupUrl stringByAppendingFormat:@"/%@.png",mode.name];
            cachePaths =  [TiSDK shareInstance].getMakeupPath;
            cachePaths =  [cachePaths stringByAppendingFormat:@"/eyeshadow/%@",mode.name];
            break;
            //        case TI_DOWNLOAD_STATE_Makeup_eyeline:// 美妆-眼线
            //            downloadURL = [[TiSDK shareInstance].getMakeupUrl stringByAppendingFormat:@"/%@.png",mode.name];
            //            cachePaths =  [TiSDK shareInstance].getMakeupPath;
            //            cachePaths =  [cachePaths stringByAppendingFormat:@"/eyeline/%@",mode.name];
            //            break;
        case TI_DOWNLOAD_STATE_Makeup_lipgloss:// 美妆-唇彩
            downloadURL = [[TiSDK shareInstance].getMakeupUrl stringByAppendingFormat:@"/%@.png",mode.name];
            cachePaths =  [TiSDK shareInstance].getMakeupPath;
            cachePaths =  [cachePaths stringByAppendingFormat:@"/lipgloss/%@",mode.name];
            break;
        case TI_DOWNLOAD_STATE_Portraits:// 人像抠图
            downloadURL = [[TiSDK shareInstance].getPortraitUrl stringByAppendingFormat:@"/%@.zip",mode.name];
            cachePaths =  [TiSDK shareInstance].getPortraitPath;
            break;
        case TI_DOWNLOAD_STATE_Gestures:// 手势识别
            downloadURL = [[TiSDK shareInstance].getGestureUrl stringByAppendingFormat:@"/%@.zip",mode.name];
            cachePaths =  [TiSDK shareInstance].getGesturePath;
            break;
        default:
            break;
    }
    
    if ([[downloadURL pathExtension] isEqualToString:@"png"]) {
        
        NSError *error = nil;
        NSData *data = [NSData dataWithContentsOfURL:[NSURL  URLWithString:downloadURL] options:NSDataReadingMappedIfSafe error:&error];
        
        if (data && !error) {
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *cachePaths1 =  [cachePaths stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"/%@",[cachePaths lastPathComponent]] withString:@""];
            BOOL result1 = [fileManager fileExistsAtPath:cachePaths1];
            if (!result1) {
                // 不存在目录 则创建
                [fileManager createDirectoryAtPath:cachePaths withIntermediateDirectories:NO attributes:nil error:nil];
            }
            BOOL result2 = [fileManager fileExistsAtPath:cachePaths];
            if (!result2) {
                // 不存在目录 则创建
                [fileManager createDirectoryAtPath:cachePaths withIntermediateDirectories:NO attributes:nil error:nil];
            }
            // 取得图片
            UIImage *image = [UIImage imageWithData:data];
            // 将取得的图片写入本地的沙盒中，其中0.5表示压缩比例，1表示不压缩，数值越小压缩比例越大
            NSString *file =[cachePaths  stringByAppendingPathComponent:[downloadURL lastPathComponent]];
            // 需要TiSDKResource.bundle文件夹中保存文件夹数据 因为是直接存图片没有创建文件夹 需要将bundle的文件夹拷贝过去
            // 保存图片到指定的路径
            NSData *data = UIImagePNGRepresentation(image);
            BOOL success = [data writeToFile:file atomically:YES];
            if (success){
                NSString *completePath = cachePaths;
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:completePath forKey:[NSString stringWithFormat:@"%@%ld",mode.name,(long)mode.menuTag]];
                [defaults synchronize];
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    if (completeBlock) {
                        completeBlock(YES);
                    }
                });
            }else{
                NSLog(NSLocalizedString(@"图片写入本地失败，地址%@", nil),downloadURL);
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    if (completeBlock) {
                        completeBlock(NO);
                    }
                });
            }
        }else{
            NSLog(NSLocalizedString(@"图片下载失败，地址%@", nil),downloadURL);
            dispatch_async(dispatch_get_main_queue(), ^{
                // UI更新代码
                if (completeBlock) {
                    completeBlock(NO);
                }
            });
        }
    }else{
        [[self.session downloadTaskWithURL:[NSURL URLWithString:downloadURL] completionHandler:^(NSURL *_Nullable location, NSURLResponse *_Nullable response, NSError *_Nullable error) {
            if (error) {
                NSLog(@"downloadURL  %@ -- error %@",downloadURL,error);
                dispatch_async(dispatch_get_main_queue(), ^{
                    // UI更新代码
                    if (completeBlock) {
                        completeBlock(NO);
                    }
                });
            } else {
                __block NSString *completePath = cachePaths;
                [SSZipArchive unzipFileAtPath:location.path toDestination:cachePaths progressHandler:^(NSString * _Nonnull entry, unz_file_info zipInfo, long entryNumber, long total) {} completionHandler:^(NSString * _Nonnull path, BOOL succeeded, NSError * _Nullable error) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        // UI更新代码
                        if (path&&succeeded) {
                            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                            [defaults setObject:completePath forKey:[NSString stringWithFormat:@"%@%ld",mode.name,(long)mode.menuTag]];
                            [defaults synchronize];
                            // UI更新代码
                            if (completeBlock) {
                                completeBlock(YES);
                            }
                        }else{
                            // UI更新代码
                            NSLog(NSLocalizedString(@"下载失败,地址为\n%@", nil),downloadURL);
                            if (completeBlock) {
                                completeBlock(NO);
                            }
                            
                        }
                        
                    });
                    
                }];
                
            }
            
        }] resume];
        
    }
    
}

- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *_Nullable))completionHandler {
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    __block NSURLCredential *credential = nil;
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        }
    } else {
        disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
    }
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
    
}

@end
