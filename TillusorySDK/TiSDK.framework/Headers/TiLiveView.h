//
//  TiView.h
//  TiSDK
//
//  Created by Cat66 on 2018/7/13.
//  Copyright © 2018年 Tillusory Tech. All rights reserved.
//

#import <GLKit/GLKit.h>
#import <AVFoundation/AVCaptureSession.h>

typedef NS_ENUM(NSInteger, TiLiveViewOrientation) {
    TiLiveViewOrientationPortrait              = 0,
    TiLiveViewOrientationLandscapeRight        = 1,
    TiLiveViewOrientationPortraitUpsideDown    = 2,
    TiLiveViewOrientationLandscapeLeft         = 3,
};

@interface TiLiveView : UIView

@property (nonatomic, assign) TiLiveViewOrientation orientation;

- (void)startPreview:(CVPixelBufferRef)pixelBuffer isMirror:(BOOL)isMirror;

@end
