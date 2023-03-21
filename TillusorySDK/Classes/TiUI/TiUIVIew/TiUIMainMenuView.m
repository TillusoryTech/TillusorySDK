//
//  TiUIMainMenuView.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiUIMainMenuView.h"
#import "TiDownloadZipManager.h"

#import "TiUIMenuViewCell.h"
#import "TiUIMenuOneViewCell.h"
#import "TiUIMenuTwoViewCell.h"
#import "TiUIMenuThreeViewCell.h"
#import "TiUIMakeUpView.h"

#import "TiSetSDKParameters.h"

@interface TiUIMainMenuView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
// 保存上一个选中的位置
@property(nonatomic,strong) NSIndexPath *selectedIndexPath;
@end

static NSString *const TiUIMenuViewCollectionViewCellId = @"TiUIMainMenuViewCollectionViewCellId";
static NSString *const TiUISubMenuViewCollectionViewCellId = @"TiUIMainSubMenuViewCollectionViewCellId";

@implementation TiUIMainMenuView

- (TiUISliderRelatedView *)sliderRelatedView{
    if (!_sliderRelatedView) {
        _sliderRelatedView = [[TiUISliderRelatedView alloc] init];
        // 默认美白滑动条
        [_sliderRelatedView.sliderView setSliderType:TiSliderTypeOne WithValue:[TiSetSDKParameters getFloatValueForKey:TI_UIDCK_SKIN_WHITENING_SLIDER]];
        WeakSelf;
        // 滑动滑动条调用成回调
        [_sliderRelatedView.sliderView setRefreshValueBlock:^(CGFloat value) {
            [weakSelf.viewModel saveParameters:value];
        }];
    }
    return _sliderRelatedView;
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = TiColors(45.0, 0.6);
    }
    return _backgroundView;
}

- (TiUIClassifyView *)classifyView{
    if (!_classifyView) {
        _classifyView = [[TiUIClassifyView alloc] init];
        _classifyView.backgroundColor = UIColor.clearColor;
        _isClassifyShow = YES;
        WeakSelf;
        [_classifyView setExecuteShowOrHiddenBlock:^(BOOL show) {
            weakSelf.sliderRelatedView.hidden = show;
            weakSelf.isClassifyShow = show;
        }];
        [_classifyView setCutefaceBlock:^(NSString * name) {
            if ([name  isEqual: NSLocalizedString(@"萌颜", nil)]) {
                [weakSelf.downBackBtn setHidden:true];
                [weakSelf.rightBackView setHidden:false];
            }else{
                [weakSelf.downBackBtn setHidden:false];
                [weakSelf.rightBackView setHidden:true];
            }
        }];
    }
    return _classifyView;
}

- (UIButton *)downBackBtn{
    if (!_downBackBtn) {
        _downBackBtn = [[UIButton alloc] init];
        [_downBackBtn setBackgroundImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
        /* === 返回上一级 === */
        [_downBackBtn addTarget:self action:@selector(clickFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downBackBtn;
}

- (UIView *)rightBackView{
    if (!_rightBackView) {
        _rightBackView = [[UIView alloc] init];
        _rightBackView.backgroundColor = UIColor.clearColor;
        [_rightBackView setHidden:true];
    }
    return _rightBackView;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = TiColors(238.0, 0.6);
    }
    return _lineView;
}

- (UIButton *)rightBackBtn{
    if (!_rightBackBtn) {
        _rightBackBtn = [[UIButton alloc] init];
        [_rightBackBtn setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
        /* === 返回上一级 === */
        [_rightBackBtn addTarget:self action:@selector(clickFunctionButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBackBtn;
}

- (UIButton *)resetBtn{
    if (!_resetBtn) {
        _resetBtn = [[UIButton alloc] init];
        [_resetBtn setTitle:NSLocalizedString(@"重置", nil) forState:UIControlStateNormal];
        [_resetBtn setTitleColor:TiColors(254.0, 1.0) forState:UIControlStateNormal];
        [_resetBtn setTitleColor:TiColors(254.0, 0.4) forState:UIControlStateDisabled];
        [_resetBtn.titleLabel setFont:TiFontRegular(10)];
        [_resetBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, -8)];
        [_resetBtn setImage:[UIImage imageNamed:@"icon_chongzhi_def.png"] forState:UIControlStateNormal];
        [_resetBtn setImage:[UIImage imageNamed:@"icon_chongzhi_disabled.png"] forState:UIControlStateDisabled];
        /* === 重置功能 === */
        [_resetBtn addTarget:self action:@selector(resetBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_resetBtn setEnabled:false];
        [_resetBtn setHidden:true];
    }
    return _resetBtn;
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
        [_reset_MY_YesBtn setBackgroundImage:[UIImage imageNamed:@"bg_chongzhi_yes.png"] forState:UIControlStateNormal];
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

- (UIView *)otherTopView{
    if (!_otherTopView) {
        _otherTopView = [[UIView alloc] init];
        [_otherTopView setBackgroundColor:UIColor.clearColor];
        [_otherTopView setHidden:true];
    }
    return _otherTopView;
}

- (UILabel *)otherTopLabel{
    if (!_otherTopLabel) {
        _otherTopLabel = [[UILabel alloc] init];
        _otherTopLabel.font = TiFontRegular(13);
        _otherTopLabel.textAlignment = NSTextAlignmentLeft;
        _otherTopLabel.textColor = UIColor.whiteColor;
        [_otherTopLabel setHidden:true];
    }
    return _otherTopLabel;
}

- (void)setOtherTitleHidden:(BOOL)is_hidden withName:(NSString *)name withCute:(BOOL)isCute{
    [self.otherTopView setHidden:is_hidden];
    [self.otherTopLabel setHidden:is_hidden];
    [self.otherTopLabel setText:NSLocalizedString(name,nil)];
    [self.menuView setHidden:!is_hidden];
    if (isCute) {
        [self.rightBackView setHidden:!is_hidden];
    }
}

- (UICollectionView *)menuView{
    if (!_menuView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 设置最小行间距
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _menuView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_menuView setTag:10];
        _menuView.showsHorizontalScrollIndicator = NO;
        _menuView.backgroundColor = UIColor.clearColor;
        _menuView.dataSource= self;
        _menuView.delegate = self;
        [_menuView registerClass:[TiUIMenuViewCell class] forCellWithReuseIdentifier:TiUIMenuViewCollectionViewCellId];
    }
    return _menuView;
}

- (UICollectionView *)subMenuView{
    if (!_subMenuView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(self.frame.size.width, TiUIViewBoxTotalHeight- TiUIMenuViewHeight - TiUISliderRelatedViewHeight);
        // 设置最小行间距
        layout.minimumLineSpacing = 0;
        _subMenuView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_subMenuView setTag:20];
        _subMenuView.showsHorizontalScrollIndicator = NO;
        _subMenuView.backgroundColor = UIColor.clearColor;
        _subMenuView.dataSource= self;
        _subMenuView.scrollEnabled = NO;// 禁止滑动
        // 注册多个cell 不重用，重用会导致嵌套的UICollectionView内的cell 错乱
        // FIXME: --json 数据完善后可再次尝试--
        for (TIMenuMode *mod in [TiMenuPlistManager shareManager].mainModeArr) {
            switch (mod.menuTag) {
                case 0:
                case 1:
                case 6:
                case 12:
                case 13:
                {
                    [_subMenuView registerClass:[TiUIMenuOneViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",TiUISubMenuViewCollectionViewCellId,(long)mod.menuTag]];
                }
                    break;
                case 4:
                case 5:
                case 10:
                case 15:
                {
                    [_subMenuView registerClass:[TiUIMenuTwoViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",TiUISubMenuViewCollectionViewCellId,(long)mod.menuTag]];
                }
                    break;
                case 2:
                case 3:
                case 7:
                case 8:
                case 9:
                case 11:
                case 14:
                case 16:
                {
                    [_subMenuView registerClass:[TiUIMenuThreeViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",TiUISubMenuViewCollectionViewCellId,(long)mod.menuTag]];
                    
                }
                    break;
                default:
                {
                    [_subMenuView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",TiUISubMenuViewCollectionViewCellId,(long)mod.menuTag]];
                }
                    break;
            }
        }
    }
    return _subMenuView;
}

- (instancetype)initWithFrame:(CGRect)frame withViewModel:(TiUIMainMenuViewModel *)viewModel
{
    self = [super initWithFrame:frame];
    if (self) {
        self.viewModel = viewModel;
        [self setUI];
        [self RACMonitor];
    }
    return self;
}

// 设置UI约束
- (void)setUI{
    
    [self addSubview:self.sliderRelatedView];
    [self.sliderRelatedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_offset(TiUISliderRelatedViewHeight);
    }];
    [self addSubview:self.backgroundView];
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.sliderRelatedView.mas_bottom);
    }];
    self.menuView.frame = CGRectMake(0, 0, TiUIScreenWidth-TiUIBackViewWidth, TiUIMenuViewHeight);
    [self.backgroundView addSubview:self.menuView];
    
    [self.backgroundView addSubview:self.subMenuView];
    [self.subMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.backgroundView);
        make.top.equalTo(self.menuView.mas_bottom);
    }];
    [self.backgroundView addSubview:self.classifyView];
    [self.classifyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backgroundView);
    }];
    [self.backgroundView addSubview:self.downBackBtn];
    [self.downBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backgroundView).offset([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:30]);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.backgroundView.mas_bottom).offset(-[[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:10]-getSafeBottomHeight);
        } else {
            // Fallback on earlier versions
        }
        make.width.height.mas_equalTo([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:20]);
    }];
    [self.backgroundView addSubview:self.rightBackView];
    [self.rightBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.menuView.mas_right);
        make.top.bottom.equalTo(self.menuView);
        make.width.mas_equalTo(TiUIBackViewWidth);
    }];
    [self.rightBackView addSubview:self.lineView];
    [self.rightBackView addSubview:self.rightBackBtn];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rightBackView);
        make.width.mas_equalTo(0.5);
        make.height.mas_equalTo([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:18]);
        make.centerY.equalTo(self.rightBackView);
    }];
    [self.rightBackBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.rightBackView);
        make.width.height.mas_equalTo(self.downBackBtn);
    }];
    [self.backgroundView addSubview:self.resetBtn];
    [self.resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backgroundView.mas_right).offset(-[[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:30]);
        make.centerY.equalTo(self.downBackBtn);
        make.width.mas_equalTo([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:48]);
        make.height.mas_equalTo([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:20]);
    }];
    [self.backgroundView addSubview:self.otherTopView];
    [self.otherTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.left.equalTo(self.backgroundView);
        make.height.mas_offset(TiUIMenuViewHeight);
    }];
    [self.otherTopView addSubview:self.otherTopLabel];
    [self.otherTopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.otherTopView).offset([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:30]);
        make.centerY.equalTo(self.otherTopView);
    }];
    // 重置功能
    [self addSubview:self.masklayersView];
    [self addSubview:self.resetBgView];
    [self.resetBgView addSubview:self.resetBgLabel];
    [self.resetBgView addSubview:self.reset_MY_YesBtn];
    [self.resetBgView addSubview:self.reset_MY_NoBtn];
    [self.masklayersView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self).offset(self.frame.size.height-TiUIScreenHeight);
    }];
    [self.resetBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.masklayersView);
        make.width.mas_equalTo([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:280]);
        make.height.mas_equalTo([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:200]);
    }];
    [self.resetBgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resetBgView).offset([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:40]);
        make.left.right.equalTo(self.resetBgView);
    }];
    [self.reset_MY_YesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resetBgView).offset([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:78]);
        make.centerX.equalTo(self.resetBgView);
        make.width.mas_equalTo([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:180]);
        make.height.mas_equalTo([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:40]);
    }];
    [self.reset_MY_NoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.reset_MY_YesBtn.mas_bottom).offset([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:12]);
        make.centerX.width.height.equalTo(self.reset_MY_YesBtn);
    }];
    
}

- (void)RACMonitor{
    // 监听重置对象--resetObject
    [self.viewModel addObserver:self forKeyPath:@"resetObject" options:NSKeyValueObservingOptionNew context:nil];
    // 监听滑动条是否显示--sliderHidden
    [self.viewModel addObserver:self forKeyPath:@"sliderHidden" options:NSKeyValueObservingOptionNew context:nil];
    // 监听是否强制跳转--classifyArr
    [self.classifyView addObserver:self forKeyPath:@"classifyArr" options:NSKeyValueObservingOptionNew context:nil];
    [self.backgroundView setBackgroundColor:TiColors(45.0, 0.6)];
    [self.sliderRelatedView setTheme:@"full" withSpecial:false];
}

// 监听方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual:@"resetObject"]) {
        if ([[change objectForKey:@"new"]  isEqual: @"重置美颜"]) {
            // 开启美颜重置功能
            self.resetBtn.hidden = NO;
            [self.resetBtn setEnabled:true];
            // 设置重置按钮状态——美颜
            [[NSUserDefaults standardUserDefaults] setObject:@"optional" forKey:@"beautystate"];
        }else if ([[change objectForKey:@"new"]  isEqual: @"重置美妆"]) {
            // 开启美妆重置功能
            [self.resetBtn setEnabled:true];
            makeUpResetComplete = false;
            //设置重置按钮状态——美妆
            [[NSUserDefaults standardUserDefaults] setObject:@"optional" forKey:@"makeupstate"];
        }else if ([[change objectForKey:@"new"]  isEqual: @"关闭重置"]){
            // 关闭美颜重置功能
            self.resetBtn.hidden = NO;
            [self.resetBtn setEnabled:false];
            //设置重置按钮状态——关闭
            [[NSUserDefaults standardUserDefaults] setObject:@"not_optional" forKey:@"beautystate"];
        }else{
            // 隐藏美颜重置功能
            self.resetBtn.hidden = YES;
            [self.resetBtn setEnabled:false];
        }
    }else if ([keyPath isEqual:@"sliderHidden"]){
        [self.sliderRelatedView setSliderHidden:[[change objectForKey:@"new"] boolValue]];
        if ([[change objectForKey:@"new"] intValue] == 0) {
            NSDictionary *dic = [self.viewModel getSliderTypeAndValue:YES];
            [self.sliderRelatedView.sliderView setSliderType:[dic[@"type"] integerValue] WithValue:[dic[@"key"] integerValue]];
        }
    }else if ([keyPath isEqual:@"classifyArr"]){
        [self.menuView reloadData];
        [self.subMenuView reloadData];
        self.classifyArr = [change objectForKey:@"new"];
        for (int i = 0; i<self.classifyArr.count; i++){
            NSNumber *menuTag = self.classifyArr[i];
            TIMenuMode *mode =  [[TiMenuPlistManager shareManager] mainModeArr][[menuTag intValue]];
            if (mode.selected)
            {
                NSIndexPath * menuIndex = [NSIndexPath indexPathForRow:i inSection:0];
                self.selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [self.menuView scrollToItemAtIndexPath:menuIndex atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
            }
        }
        if ([self.classifyArr[0] intValue] == 10 && [self.classifyArr.lastObject intValue] == 1) {
            // 美颜
            self.viewModel.beautyPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self didSelectParentMenuCell:self.viewModel.beautyPath];
        }else if ([self.classifyArr[0] intValue] == 4 && [self.classifyArr.lastObject intValue] == 6){
            // 滤镜
            self.viewModel.filterPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self didSelectParentMenuCell:self.viewModel.filterPath];
        }else if ([self.classifyArr[0] intValue] == 2 && [self.classifyArr.lastObject intValue] == 17){
            // 贴纸
            self.viewModel.stickerPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.menuView scrollToItemAtIndexPath:self.viewModel.stickerPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
            [self didSelectParentMenuCell:self.viewModel.stickerPath];
        }else if ([self.classifyArr[0] intValue] == 12 && [self.classifyArr.lastObject intValue] == 15){
            // 美妆
            self.viewModel.makeUpPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self didSelectParentMenuCell:self.viewModel.makeUpPath];
        }
        if ([self.viewModel.switchByName isEqual: NSLocalizedString(@"脸型微调", nil)]) {
            self.viewModel.beautyPath = [NSIndexPath indexPathForRow:2 inSection:0];
            [self didSelectParentMenuCell:self.viewModel.beautyPath];
        }
        else if ([self.viewModel.switchByName isEqual: NSLocalizedString(@"一键美颜", nil)]){
            self.viewModel.beautyPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self didSelectParentMenuCell:self.viewModel.beautyPath];
        }
        else if ([self.viewModel.switchByName isEqual: NSLocalizedString(@"推荐滤镜", nil)]){
            self.viewModel.filterPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self didSelectParentMenuCell:self.viewModel.filterPath];
        }
        else if ([self.viewModel.switchByName isEqual: NSLocalizedString(@"热门贴纸", nil)]){
            self.viewModel.stickerPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.menuView scrollToItemAtIndexPath:self.viewModel.stickerPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
            [self didSelectParentMenuCell:self.viewModel.stickerPath];
        }
        else if ([self.viewModel.switchByName isEqual: NSLocalizedString(@"人像抠图", nil)]){
            self.viewModel.stickerPath = [NSIndexPath indexPathForRow:6 inSection:0];
            NSIndexPath *illusoryIndexPath = [NSIndexPath indexPathForRow:7 inSection:0];
            [self.menuView scrollToItemAtIndexPath:illusoryIndexPath atScrollPosition:UICollectionViewScrollPositionRight animated:NO];
            [self didSelectParentMenuCell:self.viewModel.stickerPath];
        }
        else if ([self.viewModel.switchByName isEqual: NSLocalizedString(@"精致美妆", nil)]){
            self.viewModel.makeUpPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self didSelectParentMenuCell:self.viewModel.makeUpPath];
        }
    }
}

- (void)clickFunctionButton:(UIButton *)sender{
    if (sender == self.downBackBtn) {
        if (!self.resetBtn.hidden) {
            self.resetBtn.hidden = YES;
        }
        self.viewModel.switchByName = @"";
        if (self.isClassifyShow) {
            [[TiUIManager shareManager] popAllViews];
        }else{
            [self showClassifyView];
        }
    }else if (sender == self.rightBackBtn){
        [self.rightBackView setHidden:true];
        self.viewModel.switchByName = @"";
        if (self.isClassifyShow) {
            [[TiUIManager shareManager] popAllViews];
        }else{
            [self showClassifyView];
        }
    }
}

- (void)resetBtnClick:(UIButton *)sender{
    // 弹出弹框
    [self.masklayersView setHidden:false];
    [self.resetBgView setHidden:false];
    self.viewModel.isResetting = YES;
}

- (void)resetBtnYNClick:(UIButton *)sender{
    if (sender == self.reset_MY_YesBtn) {
        [self.masklayersView setHidden:true];
        [self.resetBgView setHidden:true];
        [[TiMenuPlistManager shareManager] reset:NSLocalizedString(self.viewModel.resetObject, nil)];
        if ([self.viewModel.resetObject  isEqual: @"重置美颜"]) {
            // 设置重置按钮状态——美颜
            [[NSUserDefaults standardUserDefaults] setObject:@"not_optional" forKey:@"beautystate"];
        }else if([self.viewModel.resetObject  isEqual: @"重置美妆"]){
            // 设置重置按钮状态——美妆
            [[NSUserDefaults standardUserDefaults] setObject:@"not_optional" forKey:@"makeupstate"];
        }
        [self didSelectParentMenuCell:self.selectedIndexPath];
        // 关闭重置功能
        [self.resetBtn setEnabled:false];
        self.viewModel.isResetting = NO;
    }else if (sender == self.reset_MY_NoBtn){
        [self.masklayersView setHidden:true];
        [self.resetBgView setHidden:true];
        self.viewModel.isResetting = NO;
    }
}

#pragma mark ---UICollectionViewDataSource---
// 设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView.tag==10) {
        return self.classifyArr.count;
    }else{
        return [[TiMenuPlistManager shareManager] mainModeArr].count;
    }
}

// 定义每个Cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView.tag ==10) {
        int menuTag = [self.classifyArr[indexPath.row] intValue];
        TIMenuMode *mode =  [[TiMenuPlistManager shareManager] mainModeArr][menuTag];
        CGSize size = [self sizeWithString:NSLocalizedString(mode.name,nil) font:TiFontHelveticaMedium];
        return CGSizeMake(size.width, TiUIMenuViewHeight);
    }else{
        return CGSizeMake(TiUIScreenWidth, TiUIViewBoxTotalHeight- TiUIMenuViewHeight - TiUISliderRelatedViewHeight);
    }
}

// 自适应大小
- (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font
{
    CGSize maxSize = CGSizeMake(1000,2000);// 设置最大容量
    NSDictionary *dict = @{NSFontAttributeName:font};
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;// 计算实际高度和宽度
    return size;
}

// 定义每个Section的四边间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (section == 0) {
        return UIEdgeInsetsMake(0, [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:30], 0, 0);
    }else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:36];
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:36];
}

// 返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (collectionView.tag == 10) {
        
        int menuTag = [self.classifyArr[indexPath.row] intValue];
        TIMenuMode *mode =  [[TiMenuPlistManager shareManager] mainModeArr][menuTag];
        TiUIMenuViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TiUIMenuViewCollectionViewCellId forIndexPath:indexPath];
        if (mode.selected)
        {
            self.selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            [self didSelectParentMenuCell:self.selectedIndexPath];
        }
        [cell setMenuMode:mode];
        return cell;
        
    }else if (collectionView.tag==20){
        
        TIMenuMode *mode = [[TiMenuPlistManager shareManager] mainModeArr][indexPath.row];
        switch (mode.menuTag) {
            case 0:
            case 1:
            case 6:
            case 12:
            case 13:
            {
                TiUIMenuOneViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",TiUISubMenuViewCollectionViewCellId,(long)mode.menuTag] forIndexPath:indexPath];
                WeakSelf;
                [cell setClickOnCellBlock:^(NSInteger index) {
                    weakSelf.viewModel.subindex = index;
                    NSDictionary *dic = [weakSelf.viewModel getSliderTypeAndValue:NO];
                    [weakSelf.sliderRelatedView.sliderView setSliderType:[dic[@"type"] integerValue] WithValue:[dic[@"key"] integerValue]];
                    if (mode.menuTag == 12) {
                        int thousand = (int)index/1000 *1000;//千
                        // 设置美颜参数
                        [TiSetSDKParameters setBeautySlider:[TiSetSDKParameters getFloatValueForKey:thousand] forKey:thousand withIndex:index];
                        // 保存选中的美妆
                        [TiSetSDKParameters setBeautyMakeupIndex:(int)index forKey:thousand];
                    }
                }];
                [cell setMakeupShowDisappearBlock:^(BOOL Hidden) {
                    if (Hidden) {
                        weakSelf.viewModel.sliderHidden = @1;
                    }
                }];
                [cell setMode:mode];
                return cell;
            }
                break;
            case 4:
            case 5:
            case 10:
            case 15:
            {
                TiUIMenuTwoViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",TiUISubMenuViewCollectionViewCellId,(long)mode.menuTag] forIndexPath:indexPath];
                WeakSelf;
                [cell setClickOnCellBlock:^(NSInteger index) {
                    weakSelf.viewModel.subindex = index;
                    NSDictionary *dic = [weakSelf.viewModel getSliderTypeAndValue:NO];
                    [weakSelf.sliderRelatedView.sliderView setSliderType:[dic[@"type"] integerValue] WithValue:[dic[@"key"] integerValue]];
                }];
                [cell setMode:mode];
                return cell;
            }
                break;
            case 2:
            case 3:
            case 7:
            case 8:
            case 9:
            case 11:
            case 14:
            case 16:
            {
                TiUIMenuThreeViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",TiUISubMenuViewCollectionViewCellId,(long)mode.menuTag] forIndexPath:indexPath];
                [cell setMode:mode];
                return cell;
            }
                break;
            default:
            {
                UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",TiUISubMenuViewCollectionViewCellId,(long)mode.menuTag] forIndexPath:indexPath];
                cell.backgroundColor = [UIColor orangeColor];
                return cell;
            }
                break;
        }
        
    }
    return nil;
    
}

#pragma mark ---UICollectionViewDelegate---
// 选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView.tag ==10)
    {
        if(indexPath.row == self.selectedIndexPath.row) return;
        [self didSelectParentMenuCell:indexPath];
    }
}

- (void)didSelectParentMenuCell:(NSIndexPath *)indexPath{
    int menuTag = [self.classifyArr[indexPath.row] intValue];
    [self.viewModel setIndexByMenuTag:menuTag];
    int selectedTag = [self.classifyArr[self.selectedIndexPath.row] intValue];
    if (selectedTag != menuTag) {
        [TiMenuPlistManager shareManager].mainModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:menuTag WithPath:@"TiMenu"];
        [TiMenuPlistManager shareManager].mainModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:selectedTag WithPath:@"TiMenu"];
        if(self.selectedIndexPath)
        {
            [self.menuView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
        }else{
            [self.menuView reloadItemsAtIndexPaths:@[indexPath]];
        }
        self.selectedIndexPath = indexPath;
    }
    NSIndexPath * submenuIndex = [NSIndexPath indexPathForRow:menuTag inSection:0];
    [self.subMenuView scrollToItemAtIndexPath:submenuIndex atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

// 返回 显示分类view
- (void)showClassifyView{
    self.downBackBtn.hidden = false;
    self.menuView.hidden = YES;
    self.subMenuView.hidden = YES;
    [self.classifyView showView];
}

- (void)hiddenClassifyView{
    [self.classifyView hiddenView];
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
            // resetYesBtn就是我们想点击的控件，让这个控件作为可点击的view返回
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
    [self.viewModel removeObserver:self forKeyPath:@"resetObject"];
    [self.viewModel removeObserver:self forKeyPath:@"sliderHidden"];
    [self.classifyView removeObserver:self forKeyPath:@"classifyArr"];
    [TiMenuPlistManager releaseShareManager];
    [TiDownloadZipManager releaseShareManager];
}

@end
