//
//  TiCaptureSessionManager.h
//  TiSDKDemo
//
//  Created by N17 on 2021/2/23.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <Masonry/Masonry.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@protocol TiCaptureSessionManagerDelegate <NSObject>

- (void)captureSampleBuffer:(CMSampleBufferRef)sampleBuffer Rotation:(NSInteger)rotation Mirror:(BOOL)isMirror;

@end

@interface TiCaptureSessionManager : NSObject
/**
 *   初始化单例
 */
+ (TiCaptureSessionManager *)shareManager;
/**
 * 释放资源
 */
- (void)destroy;

- (void)startAVCaptureDelegate:(id<TiCaptureSessionManagerDelegate>)delegate;

- (void)didClickSwitchCameraButton;

@property(nonatomic, weak) id <TiCaptureSessionManagerDelegate> delegate;

@property (nonatomic, strong) AVCaptureDevice *cameraPosition;
@property (nonatomic, strong) AVCaptureSession *session;

@end
