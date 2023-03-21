//
//  TiPSMenuView.m
//  TiFancy
//
//  Created by N17 on 2021/9/23.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSMenuView.h"
#import "TiPSMenuButton.h"

@interface TiPSMenuView ()

@property(nonatomic,strong) TiPSMenuButton *oneKeyButton;
@property(nonatomic,strong) TiPSMenuButton *beautyButton;
@property(nonatomic,strong) TiPSMenuButton *faceshapeButton;
@property(nonatomic,strong) TiPSMenuButton *appearanceButton;

@property(nonatomic,strong) TiPSMenuButton *filterButton;

@property(nonatomic,strong) TiPSMenuButton *longLegButton;
@property(nonatomic,strong) TiPSMenuButton *slimBodyButton;

@end

@implementation TiPSMenuView

- (TiPSMenuButton *)oneKeyButton{
    if (!_oneKeyButton) {
        _oneKeyButton = [TiPSMenuButton buttonWithType:UIButtonTypeCustom];
        [_oneKeyButton setTitle:@"一键美颜" withStateSelected:YES];
        [_oneKeyButton addTarget:self action:@selector(clickFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _oneKeyButton;
}

- (TiPSMenuButton *)beautyButton{
    if (!_beautyButton) {
        _beautyButton = [TiPSMenuButton buttonWithType:UIButtonTypeCustom];
        [_beautyButton setTitle:@"美颜" withStateSelected:NO];
        [_beautyButton addTarget:self action:@selector(clickFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _beautyButton;
}

- (TiPSMenuButton *)faceshapeButton{
    if (!_faceshapeButton) {
        _faceshapeButton = [TiPSMenuButton buttonWithType:UIButtonTypeCustom];
        [_faceshapeButton setTitle:@"脸型" withStateSelected:NO];
        [_faceshapeButton addTarget:self action:@selector(clickFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _faceshapeButton;
}

- (TiPSMenuButton *)appearanceButton{
    if (!_appearanceButton) {
        _appearanceButton = [TiPSMenuButton buttonWithType:UIButtonTypeCustom];
        [_appearanceButton setTitle:@"美型" withStateSelected:NO];
        [_appearanceButton addTarget:self action:@selector(clickFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _appearanceButton;
}

- (TiPSMenuButton *)filterButton{
    if (!_filterButton) {
        _filterButton = [TiPSMenuButton buttonWithType:UIButtonTypeCustom];
        [_filterButton setTitle:@"滤镜" withStateSelected:NO];
        [_filterButton addTarget:self action:@selector(clickFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _filterButton;
}

- (TiPSMenuButton *)longLegButton{
    if (!_longLegButton) {
        _longLegButton = [TiPSMenuButton buttonWithType:UIButtonTypeCustom];
        [_longLegButton setTitle:@"长腿" withStateSelected:NO];
        [_longLegButton addTarget:self action:@selector(clickFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _longLegButton;
}

- (TiPSMenuButton *)slimBodyButton{
    if (!_slimBodyButton) {
        _slimBodyButton = [TiPSMenuButton buttonWithType:UIButtonTypeCustom];
        [_slimBodyButton setTitle:@"瘦身" withStateSelected:NO];
        [_slimBodyButton addTarget:self action:@selector(clickFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _slimBodyButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

- (void)setUI{
    [self addSubview:self.oneKeyButton];
    [self.oneKeyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:30]);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(52);
    }];
    [self addSubview:self.beautyButton];
    [self.beautyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneKeyButton.mas_right).offset([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:36]);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(26);
    }];
    [self addSubview:self.faceshapeButton];
    [self.faceshapeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.beautyButton.mas_right).offset([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:36]);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(26);
    }];
    [self addSubview:self.appearanceButton];
    [self.appearanceButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.faceshapeButton.mas_right).offset([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:36]);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(26);
    }];
    [self addSubview:self.filterButton];
    [self.filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:30]);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(26);
    }];
    [self addSubview:self.longLegButton];
    [self.longLegButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:30]);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(26);
    }];
    [self addSubview:self.slimBodyButton];
    [self.slimBodyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.longLegButton.mas_right).offset([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:36]);
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(26);
    }];
}

- (void)showBeauty:(NSString *)effectName{
    [self hiddenAll];
    if ([effectName  isEqual: @"美颜"]) {
        [self.oneKeyButton setHidden:NO];
        [self.beautyButton setHidden:NO];
        [self.faceshapeButton setHidden:NO];
        [self.appearanceButton setHidden:NO];
        [self clickFunctionButton:self.oneKeyButton];
    }else if ([effectName  isEqual: @"滤镜"]){
        [self.filterButton setHidden:NO];
        [self clickFunctionButton:self.filterButton];
    }else if ([effectName  isEqual: @"美体"]){
        [self.longLegButton setHidden:NO];
        [self.slimBodyButton setHidden:NO];
        [self clickFunctionButton:self.longLegButton];
    }
}

- (void)hiddenAll{
    [self.oneKeyButton setHidden:YES];
    [self.beautyButton setHidden:YES];
    [self.faceshapeButton setHidden:YES];
    [self.appearanceButton setHidden:YES];
    [self.filterButton setHidden:YES];
    [self.longLegButton setHidden:YES];
    [self.slimBodyButton setHidden:YES];
}

- (void)clickFunctionButton:(TiPSMenuButton *)sender{
    
    [_oneKeyButton setTitle:@"一键美颜" withStateSelected:NO];
    [_beautyButton setTitle:@"美颜" withStateSelected:NO];
    [_faceshapeButton setTitle:@"脸型" withStateSelected:NO];
    [_appearanceButton setTitle:@"美型" withStateSelected:NO];
    [_filterButton setTitle:@"滤镜" withStateSelected:NO];
    [_longLegButton setTitle:@"长腿" withStateSelected:NO];
    [_slimBodyButton setTitle:@"瘦身" withStateSelected:NO];
    if (sender == self.oneKeyButton) {
        if (![self.selectName  isEqual: @"一键美颜"]) {
            self.selectName = @"一键美颜";
        }
        [self.oneKeyButton setTitle:@"一键美颜" withStateSelected:YES];
    }else if (sender == self.beautyButton) {
        if (![self.selectName  isEqual: @"美颜"]) {
            self.selectName = @"美颜";
        }
        [self.beautyButton setTitle:@"美颜" withStateSelected:YES];
    }else if (sender == self.faceshapeButton) {
        if (![self.selectName  isEqual: @"脸型"]) {
            self.selectName = @"脸型";
        }
        [self.faceshapeButton setTitle:@"脸型" withStateSelected:YES];
    }else if (sender == self.appearanceButton) {
        if (![self.selectName  isEqual: @"美型"]) {
            self.selectName = @"美型";
        }
        [self.appearanceButton setTitle:@"美型" withStateSelected:YES];
    }else if (sender == self.filterButton) {
        if (![self.selectName  isEqual: @"滤镜"]) {
            self.selectName = @"滤镜";
        }
        [self.filterButton setTitle:@"滤镜" withStateSelected:YES];
    }else if (sender == self.longLegButton) {
        [self.longLegButton setTitle:@"长腿" withStateSelected:YES];
        if (self.clickShowOtherViewBlock) {
            self.clickShowOtherViewBlock(@1);
        }
    }else if (sender == self.slimBodyButton) {
        [self.slimBodyButton setTitle:@"瘦身" withStateSelected:YES];
        if (self.clickShowOtherViewBlock) {
            self.clickShowOtherViewBlock(@2);
        }
    }
    
}

@end
