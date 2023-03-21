//
//  TiPSMainView.m
//  TiFancy
//
//  Created by N17 on 2021/9/16.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSMainView.h"
#import "TiPSConfig.h"
#import "TiPSBeautyView.h"
#import "TiPSMenuButton.h"

@interface TiPSMainView ()

// 中间的美颜选择区域
@property(nonatomic,strong) TiPSBeautyView *beautyView;
// 中间美体的滑动区域
@property(nonatomic,strong) TiPSSliderRelatedView *bodySliderRelatedView;
// 下方的功能选择区域
@property(nonatomic,strong) UIView *menuView;
@property(nonatomic,strong) UIButton *beautyBtn;
@property(nonatomic,strong) UIButton *filterBtn;
@property(nonatomic,strong) UIButton *bodyShapingBtn;
// 重置部分
@property(nonatomic,strong) UIView *_Nullable masklayersView;
@property(nonatomic,strong) UIView *_Nullable resetBgView;
@property(nonatomic,strong) UILabel *_Nullable resetBgLabel;
@property(nonatomic,strong) UIButton *_Nullable reset_MY_YesBtn;
@property(nonatomic,strong) UIButton *_Nullable reset_MY_NoBtn;

@end

@implementation TiPSMainView

- (TiPSTopSliderRelatedView *)sliderRelatedView{
    if (!_sliderRelatedView) {
        _sliderRelatedView = [[TiPSTopSliderRelatedView alloc] init];
        // 默认美白滑动条
        [_sliderRelatedView.sliderView setSliderType:TiPSSliderTypeOne WithValue:100];
        WeakSelf;
        // 滑动滑动条调用成回调
        [_sliderRelatedView.sliderView setRefreshValueBlock:^(CGFloat value) {
            [weakSelf.viewModel saveParameters:value];
            weakSelf.renderEnable = @1;
        }];
        // 点击美颜开关回调
        [_sliderRelatedView setClickContrastBlock:^(NSNumber *renderEnable) {
            weakSelf.renderEnable = renderEnable;
        }];
    }
    return _sliderRelatedView;
}

- (TiPSBeautyView *)beautyView{
    if (!_beautyView) {
        _beautyView = [[TiPSBeautyView alloc] init];
        WeakSelf
        [_beautyView setClickChangeResetObjectBlock:^(NSString * _Nonnull resetObject) {
            weakSelf.viewModel.resetObject = resetObject;
        }];
        [_beautyView setClickChangeRenderBlock:^(NSNumber * _Nonnull renderEnable) {
            weakSelf.renderEnable = renderEnable;
        }];
        [_beautyView setClickShowOtherViewBlock:^(NSNumber * _Nonnull showOtherView) {
            weakSelf.showOtherView = showOtherView;
            if ([showOtherView intValue] == 1) {
                // 设置对应滑动条参数
                [weakSelf.bodySliderRelatedView.sliderView setSliderType:TiPSSliderTypeTwo WithValue:[TiPSSetSDKParameters getPSFloatValueForKey:TI_UIDCK_LONGLEG_SLIDER]];
                [weakSelf.bodySliderRelatedView setLeftTitle:@"短" andRightTitle:@"长"];
            }else if ([showOtherView intValue] == 2){
                [weakSelf.bodySliderRelatedView.sliderView setSliderType:TiPSSliderTypeTwo WithValue:[TiPSSetSDKParameters getPSFloatValueForKey:TI_UIDCK_SLIMBODY_SLIDER]];
                [weakSelf.bodySliderRelatedView setLeftTitle:@"粗" andRightTitle:@"细"];
            }
        }];
    }
    return _beautyView;
}

- (TiPSSliderRelatedView *)bodySliderRelatedView{
    if (!_bodySliderRelatedView) {
        _bodySliderRelatedView = [[TiPSSliderRelatedView alloc] init];
        [_bodySliderRelatedView.sliderView setSliderType:TiPSSliderTypeTwo WithValue:0];
        WeakSelf;
        // 滑动滑动条调用成回调----美体
        [_bodySliderRelatedView.sliderView setRefreshValueBlock:^(CGFloat value) {
            weakSelf.bodyValue = value;
            weakSelf.viewModel.resetObject = @"重置美体";
        }];
        [_bodySliderRelatedView setHidden:YES];
    }
    return _bodySliderRelatedView;
}

- (UIView *)menuView{
    if (!_menuView) {
        _menuView = [[UIView alloc] init];
        _menuView.layer.masksToBounds = NO;
        _menuView.layer.shadowOpacity = 1;   //阴影透明度
        _menuView.layer.shadowColor = TiColors(189.0, 0.2).CGColor;
        _menuView.layer.shadowRadius = 2;  //模糊计算的半径
        _menuView.layer.shadowOffset = CGSizeMake(0, -2);   //阴影偏移量
    }
    return _menuView;
}

- (UIButton *)beautyBtn{
    if (!_beautyBtn) {
        _beautyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_beautyBtn setTitle:@"美颜" forState:UIControlStateNormal];
        [_beautyBtn setTitleColor:TiColors(102, 1.0) forState:UIControlStateNormal];
        [_beautyBtn setTitleColor:TiColor(88, 221, 221, 1.0) forState:UIControlStateSelected];
        [_beautyBtn.titleLabel setFont:TiFontRegular(14)];
        [_beautyBtn setBackgroundColor:UIColor.whiteColor];
        [_beautyBtn addTarget:self action:@selector(clickFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
        [_beautyBtn setSelected:YES];
    }
    return _beautyBtn;
}

- (UIButton *)filterBtn{
    if (!_filterBtn) {
        _filterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_filterBtn setTitle:@"滤镜" forState:UIControlStateNormal];
        [_filterBtn setTitleColor:TiColors(102, 1.0) forState:UIControlStateNormal];
        [_filterBtn setTitleColor:TiColor(88, 221, 221, 1.0) forState:UIControlStateSelected];
        [_filterBtn.titleLabel setFont:TiFontRegular(14)];
        [_filterBtn setBackgroundColor:UIColor.whiteColor];
        [_filterBtn addTarget:self action:@selector(clickFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _filterBtn;
}

- (UIButton *)bodyShapingBtn{
    if (!_bodyShapingBtn) {
        _bodyShapingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bodyShapingBtn setTitle:@"美体" forState:UIControlStateNormal];
        [_bodyShapingBtn setTitleColor:TiColors(102, 1.0) forState:UIControlStateNormal];
        [_bodyShapingBtn setTitleColor:TiColor(88, 221, 221, 1.0) forState:UIControlStateSelected];
        [_bodyShapingBtn.titleLabel setFont:TiFontRegular(14)];
        [_bodyShapingBtn setBackgroundColor:UIColor.whiteColor];
        [_bodyShapingBtn addTarget:self action:@selector(clickFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bodyShapingBtn;
}

- (UIView *)masklayersView{
    if (!_masklayersView) {
        _masklayersView = [[UIView alloc] init];
        _masklayersView.backgroundColor = TiColors(0.0, 0.4);
        [_masklayersView setHidden:true];
    }
    return _masklayersView;
}

- (UIView *)resetBgView{
    if (!_resetBgView) {
        _resetBgView = [[UIView alloc] init];
        _resetBgView.backgroundColor = TiColors(255.0, 1.0);
        _resetBgView.layer.cornerRadius = 10;
        [_resetBgView setHidden:true];
    }
    return _resetBgView;
}

- (UILabel *)resetBgLabel{
    if(!_resetBgLabel){
        _resetBgLabel = [[UILabel alloc] init];
        _resetBgLabel.textColor = TiColors(68.0, 1.0);
        _resetBgLabel.textAlignment = NSTextAlignmentCenter;
        _resetBgLabel.font = TiFontRegular(15);
        _resetBgLabel.text = NSLocalizedString(@"确定将所有参数值恢复默认吗？", nil);
    }
    return _resetBgLabel;
}

- (UIButton *)reset_MY_YesBtn{
    if (!_reset_MY_YesBtn) {
        _reset_MY_YesBtn = [UIButton buttonWithType:0];
        _reset_MY_YesBtn.backgroundColor = TiColors(255.0, 1.0);
        [_reset_MY_YesBtn setTitle:NSLocalizedString(@"确定", nil) forState:UIControlStateNormal];
        [_reset_MY_YesBtn setTitleColor: TiColors(255.0, 1.0) forState:UIControlStateNormal];
        [_reset_MY_YesBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_reset_MY_YesBtn.titleLabel setFont:TiFontRegular(16)];
        [_reset_MY_YesBtn setBackgroundImage:[UIImage imageNamed:@"bg_chongzhi_ps.png"] forState:UIControlStateNormal];
        /* === 确认重置 === */
        [_reset_MY_YesBtn addTarget:self action:@selector(resetBtnYNClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reset_MY_YesBtn;
}

- (UIButton *)reset_MY_NoBtn{
    if (!_reset_MY_NoBtn) {
        _reset_MY_NoBtn = [UIButton buttonWithType:0];
        _reset_MY_NoBtn.backgroundColor = TiColors(255.0, 1.0);
        [_reset_MY_NoBtn setTitle:NSLocalizedString(@"取消", nil) forState:UIControlStateNormal];
        [_reset_MY_NoBtn setTitleColor:TiColor(88.0, 221.0, 221.0, 1.0) forState:UIControlStateNormal];
        [_reset_MY_NoBtn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_reset_MY_NoBtn.titleLabel setFont:TiFontRegular(16)];
        _reset_MY_NoBtn.layer.borderWidth = 0.5;
        _reset_MY_NoBtn.layer.borderColor = TiColor(88.0, 221.0, 221.0, 1.0).CGColor;
        _reset_MY_NoBtn.layer.cornerRadius = 20;
        /* === 取消重置 === */
        [_reset_MY_NoBtn addTarget:self action:@selector(resetBtnYNClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reset_MY_NoBtn;
}

- (instancetype)initWithFrame:(CGRect)frame andViewMode:(TiPSMainViewModel *)viewModel
{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewModel = viewModel;
        self.bodyValue = 99;
        [self setUI];
        [TiPSSetSDKParameters initSDK];
        [self clickFunctionButton:self.beautyBtn];
        [self RACMonitor];
    }
    return self;
}

// 设置UI约束
- (void)setUI{
    
    [self addSubview:self.sliderRelatedView];
    [self.sliderRelatedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(TiPSSliderRelatedViewHeight);
    }];
    [self addSubview:self.menuView];
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self).offset(-getSafeBottomHeight);
        } else {
            // Fallback on earlier versions
        }
        make.height.mas_equalTo([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:48]);
    }];
    [self.menuView addSubview:self.beautyBtn];
    [self.beautyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self.menuView);
        make.width.mas_equalTo(TiPSScreenWidth/3);
        make.height.mas_equalTo([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:44]);
    }];
    [self.menuView addSubview:self.filterBtn];
    [self.filterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.menuView);
        make.width.height.bottom.mas_equalTo(self.beautyBtn);
    }];
    [self.menuView addSubview:self.bodyShapingBtn];
    [self.bodyShapingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.menuView);
        make.width.height.bottom.mas_equalTo(self.beautyBtn);
    }];
    [self addSubview:self.beautyView];
    [self.beautyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.sliderRelatedView.mas_bottom);
        make.bottom.equalTo(self.menuView.mas_top);
    }];
    [self.beautyView addSubview:self.bodySliderRelatedView];
    [self.bodySliderRelatedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.beautyView);
        make.left.right.equalTo(self.beautyView);
        make.height.mas_equalTo(TiPSSliderRelatedViewHeight);
    }];
    // 重置功能
    [self addSubview:self.masklayersView];
    [self addSubview:self.resetBgView];
    [self.resetBgView addSubview:self.resetBgLabel];
    [self.resetBgView addSubview:self.reset_MY_YesBtn];
    [self.resetBgView addSubview:self.reset_MY_NoBtn];
    [self.masklayersView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self).offset(TiPSViewBoxTotalHeight-TiPSScreenHeight);
    }];
    [self.resetBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.masklayersView);
        make.width.mas_equalTo([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:280]);
        make.height.mas_equalTo([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:200]);
    }];
    [self.resetBgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resetBgView).offset([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:40]);
        make.left.right.equalTo(self.resetBgView);
    }];
    [self.reset_MY_YesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resetBgView).offset([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:78]);
        make.centerX.equalTo(self.resetBgView);
        make.width.mas_equalTo([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:180]);
        make.height.mas_equalTo([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:40]);
    }];
    [self.reset_MY_NoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.reset_MY_YesBtn.mas_bottom).offset([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:12]);
        make.centerX.width.height.equalTo(self.reset_MY_YesBtn);
    }];
    
}

- (void)RACMonitor{
    
    // 监听滑动条是否可用--sliderEnabled
    [self.beautyView addObserver:self forKeyPath:@"sliderEnabled" options:NSKeyValueObservingOptionNew context:nil];
    // 监听滑动条显示样式（0～100or-50~50）
    [self.beautyView addObserver:self forKeyPath:@"sliderChange" options:NSKeyValueObservingOptionNew context:nil];
    // 监听是否开始重置
    [self.beautyView addObserver:self forKeyPath:@"startReset" options:NSKeyValueObservingOptionNew context:nil];
    // 监听重置对象--resetObject
    [self.viewModel addObserver:self forKeyPath:@"resetObject" options:NSKeyValueObservingOptionNew context:nil];
    // 监听滑动条是否显示--sliderHidden
    [self.viewModel addObserver:self forKeyPath:@"sliderHidden" options:NSKeyValueObservingOptionNew context:nil];
    // 监听是否切换
    [self.beautyView.menuView addObserver:self forKeyPath:@"selectName" options:NSKeyValueObservingOptionNew context:nil];
    
}

// 当key路径对应的属性值发生改变时，监听器就会回调自身的监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    if ([keyPath isEqual:@"sliderEnabled"]) {
        self.sliderRelatedView.userInteractionEnabled = [[change objectForKey:@"new"] boolValue];
    }else if ([keyPath  isEqual: @"sliderChange"]) {
        self.viewModel.subindex = [[change objectForKey:@"new"] integerValue];
        NSDictionary *dic = [self.viewModel getSliderTypeAndValue:NO];
        [self.sliderRelatedView.sliderView setSliderType:[dic[@"type"] integerValue] WithValue:[dic[@"key"] integerValue]];
    }else if ([keyPath isEqual:@"resetObject"]){
        // 默认关闭美颜重置功能
        [self.beautyView.resetButton setEnabled:false];
        if ([[change objectForKey:@"new"]  isEqual: @"重置美颜"]) {
            // 开启美颜重置功能
            [self.beautyView.resetButton setEnabled:true];
            // 设置重置按钮状态——美颜
            [[NSUserDefaults standardUserDefaults] setObject:@"optional" forKey:@"beautystate"];
        }else if ([[change objectForKey:@"new"]  isEqual: @"重置美体"]) {
            // 开启美体重置功能
            [self.beautyView.resetButton setEnabled:true];
            //设置重置按钮状态——美体
            [[NSUserDefaults standardUserDefaults] setObject:@"optional" forKey:@"slimbodystate"];
        }else if ([[change objectForKey:@"new"]  isEqual: @"关闭重置"]){
            //设置重置按钮状态——关闭
            [[NSUserDefaults standardUserDefaults] setObject:@"not_optional" forKey:@"beautystate"];
        }else if ([[change objectForKey:@"new"]  isEqual: @"隐藏重置"]){
            // 隐藏重置功能
            self.beautyView.resetButton.hidden = YES;
        }else if ([[change objectForKey:@"new"]  isEqual: @"显示重置"]){
            // 显示重置功能
            self.beautyView.resetButton.hidden = NO;
        }
    }else if ([keyPath isEqual:@"sliderHidden"]){
        [self.sliderRelatedView setSliderHidden:[[change objectForKey:@"new"] boolValue]];
        if ([[change objectForKey:@"new"] intValue] == 0) {
            NSDictionary *dic = [self.viewModel getSliderTypeAndValue:YES];
            [self.sliderRelatedView.sliderView setSliderType:[dic[@"type"] integerValue] WithValue:[dic[@"key"] integerValue]];
        }
    }else if ([keyPath isEqual:@"selectName"]){
        for (int i = 0; i<7; i++) {
            TiPSMode *mod = [TiPSPlistManager shareManager].mainModeArr[i];
            if ([mod.name isEqual:[change objectForKey:@"new"]]) {
                // 判断滑动条是否可以滑动
                self.beautyView.sliderEnabled = [NSNumber numberWithBool:mod.totalSwitch];
                [self didSelectParentMenuCell:[NSIndexPath indexPathForRow:i inSection:0] andMenuTag:(int)mod.menuTag];
                break;
            }
        }
    }else if ([keyPath isEqual:@"startReset"]){
        if ([[change objectForKey:@"new"] intValue] == 1) {
            // 弹出弹框
            [self.masklayersView setHidden:false];
            [self.resetBgView setHidden:false];
        }
    }
    
}


- (void)resetBtnYNClick:(UIButton *)sender{
    if (sender == self.reset_MY_YesBtn) {
        [self.masklayersView setHidden:true];
        [self.resetBgView setHidden:true];
        [[TiPSPlistManager shareManager] reset:NSLocalizedString(self.viewModel.resetObject, nil)];
        if ([self.viewModel.resetObject  isEqual: @"重置美颜"]) {
            // 设置重置按钮状态——美颜
            [[NSUserDefaults standardUserDefaults] setObject:@"not_optional" forKey:@"beautystate"];
            TiPSMode *mod;
            int i;
            for (i = 0; i<7; i++) {
                mod = [TiPSPlistManager shareManager].mainModeArr[i];
                if ([mod.name isEqual:self.beautyView.menuView.selectName]) {
                    break;
                }
            }
            [self didSelectParentMenuCell:[NSIndexPath indexPathForRow:i inSection:0] andMenuTag:(int)mod.menuTag];
        }else if ([self.viewModel.resetObject  isEqual: @"重置美体"]){
            // 设置重置按钮状态——美体
            [[NSUserDefaults standardUserDefaults] setObject:@"not_optional" forKey:@"slimbodystate"];
            [self.bodySliderRelatedView.sliderView setSliderType:TiPSSliderTypeTwo WithValue:0];
            self.bodyValue = 100;
        }
    }else if (sender == self.reset_MY_NoBtn){
        [self.masklayersView setHidden:true];
        [self.resetBgView setHidden:true];
        //重新开启重置功能
        [self.beautyView.resetButton setEnabled:true];
    }
}

- (void)didSelectParentMenuCell:(NSIndexPath *)indexPath andMenuTag:(int)menuTag{
    
    [self.viewModel setIndexByMenuTag:menuTag];
    NSIndexPath *submenuIndex = [NSIndexPath indexPathForRow:menuTag inSection:0];
    [self.beautyView.subMenuView scrollToItemAtIndexPath:submenuIndex atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    [self.beautyView.subMenuView reloadData];
}

- (void)clickFunctionButton:(UIButton *)sender{
    [self.beautyBtn setSelected:NO];
    [self.filterBtn setSelected:NO];
    [self.bodyShapingBtn setSelected:NO];
    [self.beautyView.subMenuView setHidden:NO];
    [self.bodySliderRelatedView setHidden:YES];
    if (sender == self.beautyBtn) {
        [self.beautyBtn setSelected:YES];
        self.viewModel.resetObject = @"显示重置";
        // 判断重置按钮状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *beautystate = [defaults objectForKey:@"beautystate"];
        if ([beautystate  isEqual: @"optional"]) {
            [self.beautyView.resetButton setEnabled:true];
        }else{
            // 默认不可点击
            [self.beautyView.resetButton setEnabled:false];
        }
        // 显示上方滑动条
        [self.sliderRelatedView setHidden:NO];
        [self.beautyView.menuView showBeauty:@"美颜"];
        self.showOtherView = @0;
    }else if (sender == self.filterBtn){
        [self.filterBtn setSelected:YES];
        self.viewModel.resetObject = @"隐藏重置";
        // 显示上方滑动条
        [self.sliderRelatedView setHidden:NO];
        [self.beautyView.menuView showBeauty:@"滤镜"];
        self.showOtherView = @0;
    }else if (sender == self.bodyShapingBtn){
        [self.bodyShapingBtn setSelected:YES];
        // 隐藏上方滑动条
        [self.sliderRelatedView setHidden:YES];
        self.viewModel.resetObject = @"显示重置";
        // 判断重置按钮状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *slimbodystate = [defaults objectForKey:@"slimbodystate"];
        if ([slimbodystate  isEqual: @"optional"]) {
            [self.beautyView.resetButton setEnabled:true];
        }else{
            // 默认不可点击
            [self.beautyView.resetButton setEnabled:false];
        }
        [self.beautyView.menuView showBeauty:@"美体"];
        [self.beautyView.subMenuView setHidden:YES];
        [self.bodySliderRelatedView setHidden:NO];
    }
}

// 让超出父控件的方法触发响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    if (!view) {
        // 转换坐标系
        CGPoint newPointYes = [self.reset_MY_YesBtn convertPoint:point fromView:self];
        CGPoint newPointNo = [self.reset_MY_NoBtn convertPoint:point fromView:self];
        // 判断触摸点是否在button上
        if (CGRectContainsPoint(self.reset_MY_YesBtn.bounds, newPointYes)) {
            view = self.reset_MY_YesBtn;
        }
        if (CGRectContainsPoint(self.reset_MY_NoBtn.bounds, newPointNo)) {
            view = self.reset_MY_NoBtn;
        }
    }
    return view;
}

- (void)dealloc{
    // 删除监听器
    [self.beautyView removeObserver:self forKeyPath:@"sliderEnabled"];
    [self.beautyView removeObserver:self forKeyPath:@"sliderChange"];
    [self.beautyView removeObserver:self forKeyPath:@"startReset"];
    [self.viewModel removeObserver:self forKeyPath:@"resetObject"];
    [self.viewModel removeObserver:self forKeyPath:@"sliderHidden"];
    [self.beautyView.menuView removeObserver:self forKeyPath:@"selectName"];
}

@end
