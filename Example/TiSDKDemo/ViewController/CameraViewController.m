//
//  CameraViewController.m
//  TiSDKDemo
//
//  Created by N17 on 2022/5/6.
//  Copyright © 2022 Tillusory Tech. All rights reserved.
//

#import "CameraViewController.h"
#import "TiCaptureSessionManager.h"
#import "AppDelegate.h"

//todo --- tillusory start ---
#import <TiSDK/TiSDKInterface.h>
#import "TiUIManager.h"
#import "TiSDKKey.h"
//todo --- tillusory end ---

#import <TiSDK/TiLiveView.h>

@interface CameraViewController () <TiCaptureSessionManagerDelegate,TiUIManagerDelegate,TiSDKDelegate>

@property(nonatomic,strong) UIView *navigationView;
@property(nonatomic, nonnull,strong)TiLiveView *tiLiveView;

@property(nonatomic, strong) CIImage *outputImage;
@property(nonatomic, assign) CVPixelBufferRef outputImagePixelBuffer;

@end

#define _window_width [UIScreen mainScreen].bounds.size.width
#define _window_height [UIScreen mainScreen].bounds.size.height
// 状态栏高度
#define StatusBarHeight [[UIApplication sharedApplication] statusBarFrame].size.height
// 导航栏高度
#define NavigationBarHeight (StatusBarHeight + 44)
//适配iphoneX
#define iPhoneX (_window_width== 375.f && _window_height == 812.f)||(_window_width== 414.f && _window_height == 896.f)
#define navigationView11Height (iPhoneX?(NavigationBarHeight+75):(NavigationBarHeight+60))

#define AV_CAPTURE_SESSION_PRESET_WIDTH 720
#define AV_CAPTURE_SESSION_PRESET_HEIGHT 1280

@implementation CameraViewController

- (UIView *)navigationView{
    
    if (_navigationView==nil) {
        _navigationView = [[UIView alloc]init];
        _navigationView.backgroundColor = [UIColor whiteColor];
    }
    return _navigationView;
}

- (TiLiveView *)tiLiveView{
    if (!_tiLiveView) {
        _tiLiveView = [[TiLiveView alloc] init];
        _tiLiveView.contentMode = UIViewContentModeScaleAspectFill;
        _tiLiveView.orientation = TiLiveViewOrientationLandscapeLeft;
        _tiLiveView.userInteractionEnabled = YES;
    }
    return _tiLiveView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden = YES;
    [self setUI];
    self.view.userInteractionEnabled = YES;
    if ([isSDKInit  isEqual: @"初始化失败"]) {
        [[TiSDK shareInstance] initSDK:TI_SDK_KEY withDelegate:self];
    }
    [[TiCaptureSessionManager shareManager] startAVCaptureDelegate:self];
}

- (void)setUI{
    
    [self.view addSubview:self.tiLiveView];
    
    CGFloat imageOnPreviewScale = MAX(_window_width / AV_CAPTURE_SESSION_PRESET_WIDTH, _window_height / AV_CAPTURE_SESSION_PRESET_HEIGHT);
    CGFloat previewImageWidth = AV_CAPTURE_SESSION_PRESET_WIDTH * imageOnPreviewScale;
    CGFloat previewImageHeight = AV_CAPTURE_SESSION_PRESET_HEIGHT * imageOnPreviewScale;
    
    [self.tiLiveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.view);
        make.width.mas_equalTo(previewImageWidth);
        make.height.mas_equalTo(previewImageHeight);
    }];
    
    //todo --- tillusory start ---
    [[TiUIManager shareManager] loadToWindowDelegate:self];
    [self.view addSubview:[TiUIManager shareManager].defaultButton];
    //todo --- tillusory end ---
    
}

//切换相机
- (void)SwitchCamera:(UIButton *)button{
    [[TiUIManager shareManager].delegate didClickSwitchCameraButton];
    
}

// MARK: --TiUIManagerDelegate Delegate--
- (void)didClickCameraCaptureButton{
    //拍照
    [self takePhoto];
}

- (void)didClickSwitchCameraButton{
    //切换摄像头
    [[TiCaptureSessionManager shareManager] didClickSwitchCameraButton];
}

- (void)didClickOnExitTap {
    
}

// MARK: --TiCaptureSessionManager Delegate--
- (void)captureSampleBuffer:(CMSampleBufferRef)sampleBuffer Rotation:(NSInteger)rotation Mirror:(BOOL)isMirror{
    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef)CMSampleBufferGetImageBuffer(sampleBuffer);
    if (pixelBuffer == NULL) {
        return;
    }
    CVPixelBufferLockBaseAddress(pixelBuffer, 0);
    unsigned char *baseAddress = (unsigned char *)CVPixelBufferGetBaseAddressOfPlane(pixelBuffer, 0);
    
    // 视频帧格式
    TiImageFormatEnum format;
    switch (CVPixelBufferGetPixelFormatType(pixelBuffer)) {
        case kCVPixelFormatType_32BGRA:
            format = BGRA;
            break;
        case kCVPixelFormatType_420YpCbCr8BiPlanarVideoRange:
            format = NV12;
            break;
        case kCVPixelFormatType_420YpCbCr8BiPlanarFullRange:
            format = NV12;
            break;
        default:
            NSLog(@"错误的视频帧格式！");
            format = BGRA;
            break;
    }
    
    int imageWidth, imageHeight;
    if (format == BGRA) {
        imageWidth = (int)CVPixelBufferGetBytesPerRow(pixelBuffer) / 4;
        imageHeight = (int)CVPixelBufferGetHeight(pixelBuffer);
    } else {
        imageWidth = (int)CVPixelBufferGetWidthOfPlane(pixelBuffer , 0);
        imageHeight = (int)CVPixelBufferGetHeightOfPlane(pixelBuffer , 0);
    }
    
    // FIXME: --QZW baseAddress pixelBuffer 不为空，但是无图像，导致渲染方法奔溃--
    /////////////////// TiFaceSDK 添加 开始 ///////////////////
    
    [[TiSDKManager shareManager] renderPixels:baseAddress Format:format Width:imageWidth Height:imageHeight Rotation:rotation Mirror:isMirror FaceNumber:5];
    /////////////////// TiFaceSDK 添加 结束 ///////////////////
    if (self.tiLiveView) {
        [self.tiLiveView startPreview:pixelBuffer isMirror:isMirror];
    }
    
    self.outputImage = [CIImage imageWithCVPixelBuffer:pixelBuffer];
    self.outputImagePixelBuffer = pixelBuffer;
    
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
    
}

- (void)takePhoto {
    if (self.outputImage) {
        /* 录制demo 前置摄像头修正图片朝向*/
        UIImage *processedImage = [self image:[self imageFromCVPixelBufferRef:_outputImagePixelBuffer] rotation:CLOCKWISE_270];
        UIImageWriteToSavedPhotosAlbum(processedImage, self, @selector(image:finishedSavingWithError:contextInfo:), nil);
    }else{
        NSLog(@"拍照失败");
    }
}

- (void)image:(UIImage *)image finishedSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    UIAlertController *alertView = [[UIAlertController alloc] init];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    [alertView addAction:cancelAction];
    [alertView setTitle:@"拍照成功"];
    
    if (error) {
        [alertView setMessage:[NSString stringWithFormat:@"拍照失败，原因：%@", error]];
        NSLog(@"save failed.");
    } else {
        [alertView setMessage:[NSString stringWithFormat:@"TiFancy已为您保存到相册！"]];
        NSLog(@"save success.");
    }
    [self presentViewController:alertView animated:NO completion:nil];
    
}

#pragma mark -- CVPixelBufferRef-BGRA转UIImage
- (UIImage *)imageFromCVPixelBufferRef:(CVPixelBufferRef)pixelBuffer{
    UIImage *image;
    @autoreleasepool {
        CGImageRef cgImage = NULL;
        CVPixelBufferRef pb = (CVPixelBufferRef)pixelBuffer;
        CVPixelBufferLockBaseAddress(pb, kCVPixelBufferLock_ReadOnly);
        OSStatus res = CreateCGImageFromCVPixelBuffer(pb,&cgImage);
        if (res == noErr){
            image= [UIImage imageWithCGImage:cgImage scale:1.0 orientation:UIImageOrientationUp];
        }
        CVPixelBufferUnlockBaseAddress(pb, kCVPixelBufferLock_ReadOnly);
        CGImageRelease(cgImage);
    }
    return image;
}

static OSStatus CreateCGImageFromCVPixelBuffer(CVPixelBufferRef pixelBuffer, CGImageRef *imageOut)
{
    OSStatus err = noErr;
    OSType sourcePixelFormat;
    size_t width, height, sourceRowBytes;
    void *sourceBaseAddr = NULL;
    CGBitmapInfo bitmapInfo;
    CGColorSpaceRef colorspace = NULL;
    CGDataProviderRef provider = NULL;
    CGImageRef image = NULL;
    sourcePixelFormat = CVPixelBufferGetPixelFormatType( pixelBuffer );
    if ( kCVPixelFormatType_32ARGB == sourcePixelFormat )
        bitmapInfo = kCGBitmapByteOrder32Big | kCGImageAlphaNoneSkipFirst;
    else if ( kCVPixelFormatType_32BGRA == sourcePixelFormat )
        bitmapInfo = kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst;
    else
        return -95014; // only uncompressed pixel formats
    sourceRowBytes = CVPixelBufferGetBytesPerRow( pixelBuffer );
    width = CVPixelBufferGetWidth( pixelBuffer );
    height = CVPixelBufferGetHeight( pixelBuffer );
    CVPixelBufferLockBaseAddress( pixelBuffer, 0 );
    sourceBaseAddr = CVPixelBufferGetBaseAddress( pixelBuffer );
    colorspace = CGColorSpaceCreateDeviceRGB();
    CVPixelBufferRetain( pixelBuffer );
    provider = CGDataProviderCreateWithData( (void *)pixelBuffer, sourceBaseAddr, sourceRowBytes * height, ReleaseCVPixelBuffer);
    image = CGImageCreate(width, height, 8, 32, sourceRowBytes, colorspace, bitmapInfo, provider, NULL, true, kCGRenderingIntentDefault);
    if ( err && image ) {
        CGImageRelease( image );
        image = NULL;
    }
    if ( provider ) CGDataProviderRelease( provider );
    if ( colorspace ) CGColorSpaceRelease( colorspace );
    *imageOut = image;
    return err;
}

static void ReleaseCVPixelBuffer(void *pixel, const void *data, size_t size)
{
    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef)pixel;
    CVPixelBufferUnlockBaseAddress(pixelBuffer, 0);
    CVPixelBufferRelease(pixelBuffer);
}

#pragma mark -- 旋转UIImage为正向
- (UIImage *)image:(UIImage *)image rotation:(TiRotationEnum) orientation
{
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    
    switch (orientation) {
        case CLOCKWISE_90:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case CLOCKWISE_270:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width/rect.size.height;
            scaleX = rect.size.height/rect.size.width;
            break;
        case CLOCKWISE_180:
            rotate = M_PI;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = -rect.size.width;
            translateY = -rect.size.height;
            break;
        default:
            rotate = 0.0;
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            translateX = 0;
            translateY = 0;
            break;
    }
    
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //做CTM变换
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextRotateCTM(context, rotate);
    CGContextTranslateCTM(context, translateX, translateY);
    
    CGContextScaleCTM(context, scaleX, scaleY);
    //绘制图片
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    if ([[TiCaptureSessionManager shareManager].cameraPosition position] == AVCaptureDevicePositionFront) {
        //前置摄像头要转换镜像图片
        newPic = [self convertMirrorImage:newPic];
    }
    
    return newPic;
}

- (UIImage *)convertMirrorImage:(UIImage *)image {
    //Quartz重绘图片
    CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
    UIGraphicsBeginImageContextWithOptions(rect.size, false, 2);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    CGContextClipToRect(currentContext, rect);
    CGContextRotateCTM(currentContext, (CGFloat) M_PI);
    CGContextTranslateCTM(currentContext, -rect.size.width, -rect.size.height);
    CGContextDrawImage(currentContext, rect, image.CGImage);
    
    //翻转图片
    UIImage *drawImage = UIGraphicsGetImageFromCurrentImageContext();
    UIImage *flipImage = [[UIImage alloc] initWithCGImage:drawImage.CGImage];
    
    return flipImage;
}

- (void)dealloc {
    //todo --- tillusory start ---
    [[TiSDKManager shareManager] destroy];
    [[TiUIManager shareManager] destroy];
    //todo --- tillusory end ---
}

- (void)failure {
    isSDKInit = @"初始化失败";
}

- (void)success {
    isSDKInit = @"初始化成功";
}

- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    
}

- (void)traitCollectionDidChange:(nullable UITraitCollection *)previousTraitCollection {
    
}

- (void)preferredContentSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)systemLayoutFittingSizeDidChangeForChildContentContainer:(nonnull id<UIContentContainer>)container {
    
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)willTransitionToTraitCollection:(nonnull UITraitCollection *)newCollection withTransitionCoordinator:(nonnull id<UIViewControllerTransitionCoordinator>)coordinator {
    
}

- (void)didUpdateFocusInContext:(nonnull UIFocusUpdateContext *)context withAnimationCoordinator:(nonnull UIFocusAnimationCoordinator *)coordinator {
    
}

- (void)setNeedsFocusUpdate {
    
}

- (void)updateFocusIfNeeded {
    
}

@end
