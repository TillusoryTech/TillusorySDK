//
//  TiUISliderView.m
//  TiUISliderView
//
//  Created by N17 on 2021/8/23.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiUISliderView.h"
#import "TiUIConfig.h"

@interface TiUISliderView ()<UIGestureRecognizerDelegate>{
    CGRect _trackRect;
    TiUISliderType _sliderType;
}

@property(nonatomic,strong) UITapGestureRecognizer *tapGesture;

@end

@implementation TiUISliderView

- (UIImageView *)sliderIV{
    if (!_sliderIV) {
        _sliderIV = [[UIImageView alloc] initWithFrame:CGRectMake(-(TiUISliderViewWidth/2)+1, -(TiUISliderViewHeight + 3 + (TiUISliderSize - TiUISlideBarHeight)/2), TiUISliderViewWidth, TiUISliderViewHeight)];
        // 滑动图片
        [_sliderIV setImage:[UIImage imageNamed:@"icon_drag_white.png"]];
        _sliderIV.alpha = 0;
        _sliderIV.contentMode = UIViewContentModeScaleAspectFit;
        [_sliderIV addSubview:self.sliderLabel];
    }
    return _sliderIV;
}

- (UILabel *)sliderLabel{
    if (!_sliderLabel) {
        _sliderLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.sliderIV.bounds.origin.x, self.sliderIV.bounds.origin.y, self.sliderIV.bounds.size.width, self.sliderIV.bounds.size.height-3)];
        [_sliderLabel setTextColor:TiColors(45.0, 1.0)];
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
        _slideBar.backgroundColor = UIColor.whiteColor;
        _slideBar.layer.cornerRadius = TiUISlideBarHeight/2;
        _slideBar.userInteractionEnabled = NO;
    }
    return _slideBar;
}

- (UIView *)splitPoint{
    if (!_splitPoint) {
        _splitPoint = [[UIView alloc] initWithFrame:CGRectMake(0, 0, TiUISplitPointSize, TiUISplitPointSize)];
        _splitPoint.hidden = YES;
        _splitPoint.backgroundColor = UIColor.whiteColor;
        _splitPoint.userInteractionEnabled = NO;
        _splitPoint.layer.cornerRadius = TiUISplitPointSize/2;
    }
    return _splitPoint;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _trackRect = CGRectZero;
        [self setBackgroundColor:TiColors(238.0, 0.5)];
        self.minimumTrackTintColor = [UIColor clearColor];
        self.maximumTrackTintColor = [UIColor clearColor];
        
        // 滑块背景
        [self setThumbImage:[self resizeImage:[UIImage imageNamed:@"icon_huakuai"] toSize:CGSizeMake(TiUISliderSize, TiUISliderSize)]  forState:UIControlStateNormal];
        [self setThumbImage:[self resizeImage:[UIImage imageNamed:@"icon_huakuai"] toSize:CGSizeMake(TiUISliderSize+2, TiUISliderSize+2)] forState:UIControlStateHighlighted];
        // 滑动条圆角
        self.layer.cornerRadius = TiUISlideBarHeight/2;
        
        [self addSubview:self.sliderIV];
        [self addSubview:self.slideBar];
        [self addSubview:self.splitPoint];
        
        self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTapGesture:)];
        self.tapGesture.delegate = self;
        [self addGestureRecognizer:self.tapGesture];
        
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

- (void)actionTapGesture:(UITapGestureRecognizer *)sender {
    //    CGPoint touchPoint = [sender locationInView:_slider];
    //    CGFloat value = (_slider.maximumValue - _slider.minimumValue) * (touchPoint.x / _slider.frame.size.width );
    //    [_slider setValue:value animated:YES];
}

- (void)setSliderType:(TiUISliderType)sliderType WithValue:(float)value{
    _sliderType = sliderType;
    [self refreshWithValue:value isSet:YES];
    if (sliderType == TiSliderTypeOne)
    {
        self.splitPoint.hidden = YES;
        self.minimumValue = 0;
        self.maximumValue = 100;
        [self setValue:value animated:YES];
    }else if (sliderType == TiSliderTypeTwo){
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
}

// 正在拖拽
- (void)didUpdateValue:(UISlider *)sender {
    [self refreshWithValue:sender.value isSet:NO];
}

// 结束拖拽
- (void)didEndUpdateValue:(UISlider *)sender {
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
    if (self->_sliderType == TiSliderTypeOne)
    {
        self.slideBar.frame = CGRectMake(0, 0, self->_trackRect.origin.x + TiUISliderSize/2, TiUISlideBarHeight);
    }
    else if (self->_sliderType == TiSliderTypeTwo)
    {
        CGFloat W = -(self.frame.size.width/2 - (self->_trackRect.origin.x + TiUISliderSize/2));
        self.slideBar.frame = CGRectMake(self.frame.size.width/2, 0, W, TiUISlideBarHeight);
    }
    self.sliderIV.center = CGPointMake(self->_trackRect.origin.x + (TiUISliderSize+1)/2,self.sliderIV.center.y);
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
    if ((point.y >= -TiUISliderSize) && (point.y < _trackRect.size.height + TiUISliderSize)) {
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
        if ((point.x >= _trackRect.origin.x - TiUISliderSize) && (point.x <= (_trackRect.origin.x + _trackRect.size.width + TiUISliderSize)) && (point.y < (_trackRect.size.height + TiUISliderSize))) {
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
    self.splitPoint.frame = CGRectMake(self.frame.size.width/2, -TiUISplitPointSize/2 + TiUISlideBarHeight/2, TiUISplitPointSize, TiUISplitPointSize);
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

- (void)setTheme:(NSString *)switchAspectRatio withSpecial:(BOOL)isSP{
    
    if ([switchAspectRatio  isEqual: @"1:1"] && isSP == false){
        [self.sliderIV setImage:[UIImage imageNamed:@"drag_black.png"]];
        [self setBackgroundColor:TiColors(221.0, 1.0)];
        [self setThumbImage:[self resizeImage:[UIImage imageNamed:@"icon_huakuai_black"] toSize:CGSizeMake(TiUISliderSize, TiUISliderSize)] forState:UIControlStateNormal];
        [self setThumbImage:[self resizeImage:[UIImage imageNamed:@"icon_huakuai_black"] toSize:CGSizeMake(TiUISliderSize+2, TiUISliderSize+2)] forState:UIControlStateHighlighted];
        [self.splitPoint setBackgroundColor:TiColors(102.0, 1.0)];
        [self.slideBar setBackgroundColor:TiColors(102.0, 1.0)];
        [self.sliderLabel setTextColor:[UIColor whiteColor]];
    }else{
        [self.sliderIV setImage:[UIImage imageNamed:@"icon_drag_white.png"]];
        [self setBackgroundColor:TiColors(238.0, 0.5)];
        [self setThumbImage:[self resizeImage:[UIImage imageNamed:@"icon_huakuai"] toSize:CGSizeMake(TiUISliderSize, TiUISliderSize)] forState:UIControlStateNormal];
        [self setThumbImage:[self resizeImage:[UIImage imageNamed:@"icon_huakuai"] toSize:CGSizeMake(TiUISliderSize+2, TiUISliderSize+2)] forState:UIControlStateHighlighted];
        [self.splitPoint setBackgroundColor:UIColor.whiteColor];
        [self.slideBar setBackgroundColor:UIColor.whiteColor];
        [self.sliderLabel setTextColor:TiColors(45.0, 1.0)];
    }
    
}

- (IBAction)sliderTouchDown:(UISlider *)sender {
    _tapGesture.enabled = NO;
}

- (IBAction)sliderTouchUp:(UISlider *)sender {
    _tapGesture.enabled = YES;
}

@end
