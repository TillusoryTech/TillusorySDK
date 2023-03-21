//
//  TiPSSliderRelatedView.m
//  TiFancy
//
//  Created by N17 on 2021/9/17.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSSliderRelatedView.h"
#import "TiPSConfig.h"

@implementation TiPSSliderRelatedView

- (TiPSSliderView *)sliderView {
    if (!_sliderView) {
        _sliderView = [[TiPSSliderView alloc] init];
    }
    return _sliderView;
}

- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        [_leftLabel setTextAlignment:NSTextAlignmentCenter];
        [_leftLabel setFont:TiFontRegular(12)];
        [_leftLabel setTextColor:TiColors(102,1.0)];
        _leftLabel.userInteractionEnabled = NO;
        _leftLabel.text = @"短";
    }
    return _leftLabel;
}

- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        [_rightLabel setTextAlignment:NSTextAlignmentCenter];
        [_rightLabel setFont:TiFontRegular(12)];
        [_rightLabel setTextColor:TiColors(102,1.0)];
        _rightLabel.userInteractionEnabled = NO;
        _rightLabel.text = @"长";
    }
    return _rightLabel;
}

- (instancetype)init{
    
    self = [super init];
    if (self) {
        [self addSubview:self.sliderView];
        [self addSubview:self.leftLabel];
        [self addSubview:self.rightLabel];
        
        [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.left.mas_equalTo([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:72.5]);
            make.right.mas_equalTo(-[[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:72.5]);
            make.height.offset(TiPSSlideBarHeight-1);
        }];
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.mas_equalTo([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:40]);
        }];
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.right.mas_equalTo(-[[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:40]);
        }];
    }
    return self;
}

- (void)setLeftTitle:(NSString *)leftTitle andRightTitle:(NSString *)rightTitle{
    self.leftLabel.text = leftTitle;
    self.rightLabel.text = rightTitle;
}

@end
