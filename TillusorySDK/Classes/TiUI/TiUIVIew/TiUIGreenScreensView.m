//
//  TiUIGreenScreensView.m
//  TiFancy
//
//  Created by N17 on 2021/4/16.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiUIGreenScreensView.h"
#import "TiSetSDKParameters.h"

@interface TiUIGreenScreensView()

@property(nonatomic,strong) TiButton *resetBtn;//恢复
@property(nonatomic,strong) UIView *dividingLine;//分割线
@property(nonatomic,strong) TiButton *similarityBtn;//相似度
@property(nonatomic,strong) TiButton *smoothBtn;//平滑度
@property(nonatomic,strong) TiButton *hyalineBtn;//透明度

@end

@implementation TiUIGreenScreensView

- (TiButton *)resetBtn{
    if (!_resetBtn) {
        _resetBtn = [[TiButton alloc] initWithScaling:1.0 withMakeUp:NO];
        [_resetBtn setTitle:NSLocalizedString(@"恢复", nil) withImage:[UIImage imageNamed:@"icon_lvmu_huifu_disabled"] withTextColor:TiColors(254.0, 0.4) forState:UIControlStateNormal];
        [_resetBtn setEnabled:NO];
        [_resetBtn addTarget:self action:@selector(ResetEdit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _resetBtn;
}

- (UIView *)dividingLine{
    if (!_dividingLine) {
        _dividingLine = [[UIView alloc]init];
        _dividingLine.backgroundColor = TiColors(149.0,1.0);
    }
    return _dividingLine;
}

- (TiButton *)similarityBtn{
    if (!_similarityBtn) {
        _similarityBtn = [[TiButton alloc] initWithScaling:1.0 withMakeUp:NO];
        [_similarityBtn setTitle:NSLocalizedString(@"相似度", nil) withImage:[UIImage imageNamed:@"icon_lvmu_xiangsi"] withTextColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_similarityBtn setTitle:NSLocalizedString(@"相似度", nil) withImage:[UIImage imageNamed:@"icon_lvmu_xiangsi"] withTextColor:TiColor(88.0, 221.0, 221.0, 1.0) forState:UIControlStateSelected];
        [_similarityBtn setBorderWidth:0.0 BorderColor:UIColor.clearColor forState:UIControlStateNormal];
        [_similarityBtn setBorderWidth:1.0 BorderColor:TiColor(88.0, 221.0, 221.0, 1.0) forState:UIControlStateSelected];
        [_similarityBtn addTarget:self action:@selector(clickEdit:) forControlEvents:UIControlEventTouchUpInside];
        [self.similarityBtn setRoundSelected:YES width:40];
    }
    return _similarityBtn;
}

- (TiButton *)smoothBtn{
    if (!_smoothBtn) {
        _smoothBtn = [[TiButton alloc] initWithScaling:1.0 withMakeUp:NO];
        [_smoothBtn setTitle:NSLocalizedString(@"平滑度", nil) withImage:[UIImage imageNamed:@"icon_lvmu_smoothness"] withTextColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_smoothBtn setTitle:NSLocalizedString(@"平滑度", nil) withImage:[UIImage imageNamed:@"icon_lvmu_smoothness"] withTextColor:TiColor(88.0, 221.0, 221.0, 1.0) forState:UIControlStateSelected];
        [_smoothBtn setBorderWidth:0.0 BorderColor:UIColor.clearColor forState:UIControlStateNormal];
        [_smoothBtn setBorderWidth:1.0 BorderColor:TiColor(88.0, 221.0, 221.0, 1.0) forState:UIControlStateSelected];
        [_smoothBtn addTarget:self action:@selector(clickEdit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smoothBtn;
}

- (TiButton *)hyalineBtn{
    if (!_hyalineBtn) {
        _hyalineBtn = [[TiButton alloc] initWithScaling:1.0 withMakeUp:NO];
        [_hyalineBtn setTitle:NSLocalizedString(@"透明度", nil) withImage:[UIImage imageNamed:@"icon_lvmu_alpha"] withTextColor:UIColor.whiteColor forState:UIControlStateNormal];
        [_hyalineBtn setTitle:NSLocalizedString(@"透明度", nil) withImage:[UIImage imageNamed:@"icon_lvmu_alpha"] withTextColor:TiColor(88.0, 221.0, 221.0, 1.0) forState:UIControlStateSelected];
        [_hyalineBtn setBorderWidth:0.0 BorderColor:UIColor.clearColor forState:UIControlStateNormal];
        [_hyalineBtn setBorderWidth:1.0 BorderColor:TiColor(88.0, 221.0, 221.0, 1.0) forState:UIControlStateSelected];
        [_hyalineBtn addTarget:self action:@selector(clickEdit:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hyalineBtn;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.resetBtn];
        [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(17.5);
            make.width.equalTo(@(24));
            make.height.equalTo(@(60));
            make.top.equalTo(self).offset(30);
        }];
        [self addSubview:self.dividingLine];
        [self.dividingLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.resetBtn.mas_right).offset(28);
            make.width.equalTo(@(0.5));
            make.height.equalTo(@(55));
            make.top.equalTo(self).offset(30);
        }];
        [self addSubview:self.similarityBtn];
        [self.similarityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dividingLine.mas_right).offset(28);
            make.width.equalTo(@(40));
            make.height.equalTo(@(70));
            make.bottom.equalTo(self.resetBtn.mas_bottom);
        }];
        [self addSubview:self.smoothBtn];
        [self.smoothBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.similarityBtn.mas_right).offset(30);
            make.width.equalTo(@(40));
            make.height.equalTo(@(70));
            make.centerY.equalTo(self.similarityBtn);
        }];
        [self addSubview:self.hyalineBtn];
        [self.hyalineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.smoothBtn.mas_right).offset(30);
            make.width.equalTo(@(40));
            make.height.equalTo(@(70));
            make.centerY.equalTo(self.smoothBtn);
        }];
        // 注册通知——通知是否可以开启恢复功能
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isResetEdit:) name:@"NotificationName_TiUIGreenScreensView_isResetEdit" object:nil];
    }
    return self;
}

- (void)isResetEdit:(NSNotification *)notification{
    NSNumber *isResetN = notification.object;
    BOOL isReset =  [isResetN boolValue];
    [self.resetBtn setEnabled:isReset];
    if (isReset) {
        [self.resetBtn setTitle:NSLocalizedString(@"恢复", nil) withImage:[UIImage imageNamed:@"icon_lvmu_huifu"] withTextColor:UIColor.whiteColor forState:UIControlStateNormal];
    }else{
        [self.resetBtn setTitle:NSLocalizedString(@"恢复", nil) withImage:[UIImage imageNamed:@"icon_lvmu_huifu_disabled"] withTextColor:TiColors(254.0, 0.4) forState:UIControlStateNormal];
    }
}

- (void)clickEdit:(TiButton *)sender{
    if (sender == self.similarityBtn) {
        [TiUIManager shareManager].tiUIViewBoxView.viewModel.is_greenEdit = 1;
    }
    if (sender == self.smoothBtn) {
        [TiUIManager shareManager].tiUIViewBoxView.viewModel.is_greenEdit = 2;
    }
    if (sender == self.hyalineBtn) {
        [TiUIManager shareManager].tiUIViewBoxView.viewModel.is_greenEdit = 3;
    }
    [self Edit:[TiUIManager shareManager].tiUIViewBoxView.viewModel.is_greenEdit];
}

- (void)Edit:(int)sender{
    if (sender == 1) {
        [self.similarityBtn setRoundSelected:YES width:self.similarityBtn.layer.frame.size.width];
        [self.smoothBtn setRoundSelected:NO width:0];
        [self.hyalineBtn setRoundSelected:NO width:0];
        [[TiUIManager shareManager].tiUIViewBoxView.sliderRelatedView.sliderView setSliderType:TiSliderTypeTwo WithValue:[TiSetSDKParameters getFloatValueForKey:TI_UIDCK_SIMILARITY_SLIDER]];
    }
    if (sender == 2) {
        [self.similarityBtn setRoundSelected:NO width:0];
        [self.smoothBtn setRoundSelected:YES width:self.similarityBtn.layer.frame.size.width];
        [self.hyalineBtn setRoundSelected:NO width:0];
        [[TiUIManager shareManager].tiUIViewBoxView.sliderRelatedView.sliderView setSliderType:TiSliderTypeOne WithValue:[TiSetSDKParameters getFloatValueForKey:TI_UIDCK_SMOOTH_SLIDER]];
    }
    if (sender == 3) {
        [self.similarityBtn setRoundSelected:NO width:0];
        [self.smoothBtn setRoundSelected:NO width:0];
        [self.hyalineBtn setRoundSelected:YES width:self.similarityBtn.layer.frame.size.width];
        [[TiUIManager shareManager].tiUIViewBoxView.sliderRelatedView.sliderView setSliderType:TiSliderTypeOne WithValue:[TiSetSDKParameters getFloatValueForKey:TI_UIDCK_HYALINE_SLIDER]];
    }
}

- (void)ResetEdit:(UIButton *)sender{
    // 设置相似度
    [TiSetSDKParameters setFloatValue:SimilarityValue forKey:TI_UIDCK_SIMILARITY_SLIDER];
    // 设置平滑度
    [TiSetSDKParameters setFloatValue:SmoothnessValue forKey:TI_UIDCK_SMOOTH_SLIDER];
    // 设置透明度
    [TiSetSDKParameters setFloatValue:AlphaValue forKey:TI_UIDCK_HYALINE_SLIDER];
    [[TiSDKManager shareManager] setGreenScreen:NSLocalizedString(@"绿幕抠图", nil) Similarity:SimilarityValue Smoothness:SmoothnessValue Alpha:AlphaValue];
    
    [self Edit:[TiUIManager shareManager].tiUIViewBoxView.viewModel.is_greenEdit];
    [self.resetBtn setEnabled:NO];
    [self.resetBtn setTitle:NSLocalizedString(@"恢复", nil) withImage:[UIImage imageNamed:@"icon_lvmu_huifu_disabled"] withTextColor:TiColors(254.0, 0.4) forState:UIControlStateNormal];
}

- (void)dealloc{
    // 移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
