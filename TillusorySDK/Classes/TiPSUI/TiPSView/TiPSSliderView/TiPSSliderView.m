//
//  TiPSSliderView.m
//  TiFancy
//
//  Created by N17 on 2021/9/18.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSSliderView.h"
#import "TiPSConfig.h"

@interface TiPSSliderView (){
    CGRect _trackRect;
    TiPSSliderType _sliderType;
}
@property(nonatomic,strong) UITapGestureRecognizer *tapGesture;
@property(nonatomic,strong) CADisplayLink *link;

@end

@implementation TiPSSliderView

- (UIImageView *)sliderIV{
    if (!_sliderIV) {
        _sliderIV = [[UIImageView alloc] initWithFrame:CGRectMake(-(TiPSSliderViewWidth/2)+1, -(TiPSSliderViewHeight + 3 + (TiPSSliderSize - TiPSSlideBarHeight)/2), TiPSSliderViewWidth, TiPSSliderViewHeight)];
        // 滑动图片
        [_sliderIV setImage:[UIImage imageNamed:@"drag_black_ps.png"]];
        _sliderIV.alpha = 0;
        _sliderIV.contentMode = UIViewContentModeScaleAspectFit;
        [_sliderIV addSubview:self.sliderLabel];
    }
    return _sliderIV;
}

- (UILabel *)sliderLabel{
    if (!_sliderLabel) {
        _sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.sliderIV.bounds.origin.x, self.sliderIV.bounds.origin.y, self.sliderIV.bounds.size.width, self.sliderIV.bounds.size.height-3)];
        [_sliderLabel setTextColor:UIColor.whiteColor];
        [_sliderLabel setTextAlignment:NSTextAlignmentCenter];
        [_sliderLabel setFont:TiFontHelveticaSmall];
        _sliderLabel.userInteractionEnabled = NO;
    }
    return _sliderLabel;
}

- (UIView *)slideBar{
    if (!_slideBar) {
        _slideBar = [[UIView alloc] init];
        _slideBar.frame = _trackRect;
        _slideBar.backgroundColor = TiColors(102.0, 1.0);
        _slideBar.layer.cornerRadius = TiPSSlideBarHeight/2;
        _slideBar.userInteractionEnabled = NO;
    }
    return _slideBar;
}

- (UIView *)splitPoint{
    if (!_splitPoint) {
        _splitPoint = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TiPSSplitPointSize, TiPSSplitPointSize)];
        _splitPoint.hidden = YES;
        _splitPoint.backgroundColor = TiColors(102.0, 1.0);
        _splitPoint.userInteractionEnabled = NO;
        _splitPoint.layer.cornerRadius = TiPSSplitPointSize/2;
    }
    return _splitPoint;
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        _trackRect = CGRectZero;
        [self setBackgroundColor:TiColors(221.0, 1.0)];
        self.minimumTrackTintColor = [UIColor clearColor];
        self.maximumTrackTintColor = [UIColor clearColor];
        // 滑块背景
        [self setThumbImage:[self resizeImage:[UIImage imageNamed:@"icon_huakuai_ps.png"] toSize:CGSizeMake(TiPSSliderSize, TiPSSliderSize)] forState:UIControlStateNormal];
        [self setThumbImage:[self resizeImage:[UIImage imageNamed:@"icon_huakuai_ps.png"] toSize:CGSizeMake(TiPSSliderSize+2, TiPSSliderSize+2)] forState:UIControlStateHighlighted];
        // 滑动条圆角
        self.layer.cornerRadius = TiPSSlideBarHeight/2;
        [self addSubview:self.sliderIV];
        [self addSubview:self.slideBar];
        [self addSubview:self.splitPoint];
        // ios 14.0
        [self insertSubview:self.splitPoint atIndex:0];
        [self insertSubview:self.slideBar atIndex:0];
        [self insertSubview:self.sliderIV atIndex:0];
        [self addTarget:self action:@selector(didBeginUpdateValue:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(didUpdateValue:) forControlEvents:UIControlEventValueChanged];
        [self addTarget:self action:@selector(didEndUpdateValue:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside|UIControlEventTouchCancel];
    }
    return self;
    
}

- (void)setSliderType:(TiPSSliderType)sliderType WithValue:(float)value{
    _sliderType = sliderType;
    [self refreshWithValue:value isSet:YES];
    if (sliderType == TiPSSliderTypeOne)
    {
        self.splitPoint.hidden = YES;
        self.minimumValue = 0;
        self.maximumValue = 100;
        [self setValue:value animated:YES];
    }else if (sliderType == TiPSSliderTypeTwo){
        self.splitPoint.hidden = NO;
        self.minimumValue = -50;
        self.maximumValue = 50;
        [self setValue:value animated:YES];
    }
}

// 开始拖拽
- (void)didBeginUpdateValue:(UISlider *)sender {
    [self refreshWithValue:sender.value isSet:NO];
    [UIView animateWithDuration:0.3 animations:^{
        [self.sliderIV setAlpha:1.0f];
    }];
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(linkClick)];
    // 单位是帧，屏幕刷新多少帧时调用一次selector
    // 默认值为0，选择使用设备的最高屏幕刷新频率（iOS为60次每秒）
    // 所以执行时间间隔为：preferredFramesPerSecond * 最高屏幕刷新间隔，如iOS设备：preferredFramesPerSecond * 1/60 秒
    if (@available(iOS 10.0, *)) {
        self.link.preferredFramesPerSecond = 20;
    } else {
        // Fallback on earlier versions
    }
    // 注册到runLoop中监听 加进去才会执行
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)linkClick
{
    [self refreshWithValue:self.value isSet:NO];
}

// 正在拖拽
- (void)didUpdateValue:(UISlider *)sender {
    //    [self refreshWithValue:sender.value isSet:NO];
}

// 结束拖拽
- (void)didEndUpdateValue:(UISlider *)sender {
    // 从runloop移除
    [self.link invalidate];
    self.link = nil;
    [self refreshWithValue:sender.value isSet:NO];
    [UIView animateWithDuration:0.1 animations:^{
        [self.sliderIV setAlpha:0];
    }];
}

- (void)refreshWithValue:(float)value isSet:(BOOL)set{
    if (self.refreshValueBlock&&!set) {
        self.refreshValueBlock(value);
    }
    if(self.valueBlock){
        self.valueBlock(value);
    }
    if (self->_sliderType == TiPSSliderTypeOne)
    {
        self.slideBar.frame = CGRectMake(0, 0, self->_trackRect.origin.x + TiPSSliderSize/2, TiPSSlideBarHeight);
    }
    else if (self->_sliderType == TiPSSliderTypeTwo)
    {
        CGFloat W = -(self.frame.size.width/2 - (self->_trackRect.origin.x + TiPSSliderSize/2));
        self.slideBar.frame = CGRectMake(self.frame.size.width/2, 0, W, TiPSSlideBarHeight);
    }
    self.sliderIV.center = CGPointMake(self->_trackRect.origin.x + (TiPSSliderSize+1)/2,self.sliderIV.center.y);
    [self.sliderLabel setText:[NSString stringWithFormat:@"%d%@", (int)value, @"%"]];
    
}

// 返回滑块轨迹的绘制矩形。
- (CGRect)trackRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, MAX(bounds.size.height, 2.0));
}

// 调整中间滑块位置，并获取滑块坐标
- (CGRect)thumbRectForBounds:(CGRect)bounds trackRect:(CGRect)rect value:(float)value{
    rect.origin.x = rect.origin.x;
    rect.size.width = rect.size.width;
    _trackRect = [super thumbRectForBounds:bounds trackRect:rect value:value];
    return _trackRect;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *result = [super hitTest:point withEvent:event];
    if (point.x < 0 || point.x > self.bounds.size.width){
        return result;
    }
    if ((point.y >= -TiPSSliderSize) && (point.y < _trackRect.size.height + TiPSSliderSize)) {
        float value = 0.0;
        value = point.x - self.bounds.origin.x;
        value = value/self.bounds.size.width;
        
        value = value < 0? 0 : value;
        value = value > 1? 1: value;
        
        value = value * (self.maximumValue - self.minimumValue) + self.minimumValue;
        [self setValue:value animated:YES];
    }
    return result;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL result = [super pointInside:point withEvent:event];
    if (!result && point.y > -10) {
        if ((point.x >= _trackRect.origin.x - TiPSSliderSize) && (point.x <= (_trackRect.origin.x + _trackRect.size.width + TiPSSliderSize)) && (point.y < (_trackRect.size.height + TiPSSliderSize))) {
            result = YES;
        }
        
    }
    return result;
}

// FIXME: --layoutSubviews--
- (void)layoutSubviews
{
    [super layoutSubviews];
    //使用 mas //这里才能获取到self.frame 并且刷新Value 视图变动的时候也会调用
    self.splitPoint.frame = CGRectMake(self.frame.size.width/2, -TiPSSplitPointSize/2 + TiPSSlideBarHeight/2, TiPSSplitPointSize, TiPSSplitPointSize);
    [self refreshWithValue:self.value isSet:YES];
    
}

- (UIImage *)resizeImage:(UIImage *)image toSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage * scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

@end
