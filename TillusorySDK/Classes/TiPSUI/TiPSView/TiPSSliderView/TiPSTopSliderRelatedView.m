//
//  TiPSTopSliderRelatedView.m
//  TiPSTopSliderRelatedView
//
//  Created by N17 on 2021/8/24.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSTopSliderRelatedView.h"
#import "TiPSConfig.h"

@implementation TiPSTopSliderRelatedView

- (TiPSSliderView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[TiPSSliderView alloc] init];
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
        [_sliderLabel setTextColor:TiColors(102.0, 1.0)];
        _sliderLabel.userInteractionEnabled = NO;
        _sliderLabel.text = @"100%";
    }
    return _sliderLabel;
}

- (UIButton *)tiContrastBtn{
    if (!_tiContrastBtn) {
        _tiContrastBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tiContrastBtn setImage:[UIImage imageNamed:@"compare_black_ps.png"] forState:UIControlStateNormal];
        [_tiContrastBtn setSelected:NO];
        _tiContrastBtn.layer.masksToBounds = NO;
        /* === 开关 === */
        // 按下--显示原图
        [_tiContrastBtn addTarget:self action:@selector(showAncientImage:) forControlEvents:UIControlEventTouchDown];
        // 抬起--显示渲染
        [_tiContrastBtn addTarget:self action:@selector(showRenderImage:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tiContrastBtn;
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
        [self setBackgroundColor:UIColor.whiteColor];
        
        [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.mas_equalTo([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:72.5]);
            make.right.mas_equalTo(-[[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:72.5]);
            make.height.offset(TiPSSlideBarHeight-1);
        }];
        [self.sliderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.mas_equalTo([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:30]);
        }];
        [self.tiContrastBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.mas_equalTo(-[[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:30]);
        }];
    }
    return self;
}

- (void)showAncientImage:(UIButton *)sender{
    if (self.clickContrastBlock) {
        self.clickContrastBlock(@0);
    }
}

- (void)showRenderImage:(UIButton *)sender{
    if (self.clickContrastBlock) {
        self.clickContrastBlock(@1);
    }
}

@end
