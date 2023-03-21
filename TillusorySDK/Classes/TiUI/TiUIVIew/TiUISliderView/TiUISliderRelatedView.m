//
//  TiUISliderRelatedView.m
//  TiUISliderRelatedView
//
//  Created by N17 on 2021/8/24.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiUISliderRelatedView.h"
#import "TiUIConfig.h"

@implementation TiUISliderRelatedView

- (TiUISliderView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[TiUISliderView alloc] init];
        WeakSelf
        [_sliderView setValueBlock:^(CGFloat value) {
            // 数值
            weakSelf.sliderLabel.text = [NSString stringWithFormat:@"%d%%",(int)value];
        }];
    }
    return _sliderView;
}

- (UILabel *)sliderLabel{
    if (!_sliderLabel) {
        _sliderLabel = [[UILabel alloc] init];
        [_sliderLabel setTextAlignment:NSTextAlignmentCenter];
        [_sliderLabel setFont:TiFontHelveticaMedium];
        [_sliderLabel setTextColor:TiColors(255.0,1.0)];
        _sliderLabel.userInteractionEnabled = NO;
        _sliderLabel.text = @"100%";
    }
    return _sliderLabel;
}

- (UIButton *)tiContrastBtn{
    if (!_tiContrastBtn) {
        _tiContrastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tiContrastBtn setImage:[UIImage imageNamed:@"icon_compare_white"] forState:UIControlStateNormal];
        [_tiContrastBtn setSelected:NO];
        _tiContrastBtn.layer.masksToBounds = NO;
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
        longPress.minimumPressDuration = 0.0; // 定义按的时间
        [_tiContrastBtn addGestureRecognizer:longPress];
    }
    return _tiContrastBtn;
}

- (void)longPress:(UILongPressGestureRecognizer*)gestureRecognizer{
    
    if ([gestureRecognizer state] == UIGestureRecognizerStateBegan) {
        [[TiSDKManager shareManager] setRenderEnable:false];
    }else if([gestureRecognizer state] == UIGestureRecognizerStateEnded){
        [[TiSDKManager shareManager] setRenderEnable:true];
    }else{
        return;
    }
    
}

- (void)setSliderHidden:(BOOL)hidden{
    [self.sliderView setHidden:hidden];
    [self.sliderLabel setHidden:hidden];
    [self.tiContrastBtn setHidden:hidden];
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        [self addSubview:self.sliderView];
        [self addSubview:self.sliderLabel];
        [self addSubview:self.tiContrastBtn];
        
        [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.mas_equalTo([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:72.5]);
            make.right.mas_equalTo(-[[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:72.5]);
            make.height.offset(TiUISlideBarHeight-1);
        }];
        [self.sliderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.mas_equalTo([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:30]);
        }];
        [self.tiContrastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.mas_equalTo(-[[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:30]);
        }];
    }
    return self;
}

- (void)setTheme:(NSString *)switchAspectRatio withSpecial:(BOOL)isSP{
    
    if ([switchAspectRatio  isEqual: @"1:1"] && isSP == false){
        [self setBackgroundColor:UIColor.whiteColor];
        [self.tiContrastBtn setImage:[UIImage imageNamed:@"compare_black"] forState:UIControlStateNormal];
        [self.sliderLabel setTextColor:TiColors(102.0, 1.0)];
    }else{
        [self setBackgroundColor:UIColor.clearColor];
        [self.tiContrastBtn setImage:[UIImage imageNamed:@"icon_compare_white"] forState:UIControlStateNormal];
        [self.sliderLabel setTextColor:UIColor.whiteColor];
    }
    [self.sliderView setTheme:switchAspectRatio withSpecial:isSP];
    
}

@end
