//
//  TiPSBeautyView.m
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSBeautyView.h"
#import "TiPSWithSwitchViewCell.h"
#import "TiPSWithoutSwitchViewCell.h"

@interface TiPSBeautyView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

static NSString *const TiPSWithSwitchViewCellId = @"TiPSWithSwitchViewCellId";
static NSString *const TiPSWithoutSwitchViewCellId = @"TiPSWithoutSwitchViewCellId";

@implementation TiPSBeautyView

- (TiPSMenuView *)menuView{
    if (!_menuView) {
        _menuView = [[TiPSMenuView alloc] init];
        WeakSelf;
        [_menuView setClickShowOtherViewBlock:^(NSNumber * _Nonnull showOtherView) {
            if (weakSelf.clickShowOtherViewBlock) {
                weakSelf.clickShowOtherViewBlock(showOtherView);
            }
        }];
    }
    return _menuView;
}

- (UIButton *)resetButton{
    if (!_resetButton) {
        _resetButton = [[UIButton alloc] init];
        [_resetButton setTitle:NSLocalizedString(@"重置", nil) forState:UIControlStateNormal];
        [_resetButton setTitleColor:TiColors(102, 1.0) forState:UIControlStateNormal];
        [_resetButton setTitleColor:TiColors(102, 0.3) forState:UIControlStateDisabled];
        [_resetButton.titleLabel setFont:TiFontRegular(10)];
        [_resetButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 8, 0, -8)];
        [_resetButton setImage:[UIImage imageNamed:@"icon_reset_abled_ps.png"] forState:UIControlStateNormal];
        [_resetButton setImage:[UIImage imageNamed:@"icon_reset_disabled_ps.png"] forState:UIControlStateDisabled];
        /* === 重置功能 === */
        [_resetButton addTarget:self action:@selector(resetButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_resetButton setEnabled:false];
    }
    return _resetButton;
}

- (UICollectionView *)subMenuView{
    if (!_subMenuView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(self.frame.size.width, TiPSViewBoxTotalHeight- TiPSMenuViewHeight - TiPSSliderRelatedViewHeight);
        // 设置最小行间距
        layout.minimumLineSpacing = 0;
        _subMenuView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _subMenuView.showsHorizontalScrollIndicator = NO;
        _subMenuView.dataSource= self;
        _subMenuView.delegate = self;
        _subMenuView.scrollEnabled = NO;// 禁止滑动
        _subMenuView.backgroundColor = UIColor.whiteColor;
        // 注册多个cell 不重用，重用会导致嵌套的UICollectionView内的cell 错乱
        // FIXME: --json 数据完善后可再次尝试--
        for (TiPSMode *mod in [TiPSPlistManager shareManager].mainModeArr) {
            switch (mod.menuTag) {
                case 1:
                case 2:
                case 3:
                {
                    [_subMenuView registerClass:[TiPSWithSwitchViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",TiPSWithSwitchViewCellId,(long)mod.menuTag]];
                }
                    break;
                case 0:
                case 4:
                {
                    [_subMenuView registerClass:[TiPSWithoutSwitchViewCell class] forCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",TiPSWithoutSwitchViewCellId,(long)mod.menuTag]];
                }
                    break;
            }
        }
    }
    return _subMenuView;
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
    
    [self addSubview:self.menuView];
    [self.menuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(TiPSMenuViewHeight);
    }];
    [self.menuView addSubview:self.resetButton];
    [self.resetButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-[[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:18]);
        make.centerY.equalTo(self.menuView);
        make.width.mas_equalTo([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:48]);
        make.height.mas_equalTo([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:20]);
    }];
    [self addSubview:self.subMenuView];
    [self.subMenuView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(self.menuView.mas_bottom);
    }];
    
}

- (void)resetButtonClick:(UIButton *)sender{
    // 弹出弹框
    self.startReset = @1;
    [self.resetButton setEnabled:false];
}

#pragma mark ---UICollectionViewDataSource---
// 设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [[TiPSPlistManager shareManager] mainModeArr].count;
}

// 定义每个Cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(TiPSScreenWidth, TiPSViewBoxTotalHeight- TiPSMenuViewHeight - TiPSSliderRelatedViewHeight);
}

// 定义每个Section的四边间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return [[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:36];
}

// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return [[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:36];
}

// 返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TiPSMode *mode = [[TiPSPlistManager shareManager] mainModeArr][indexPath.row];
    switch (mode.menuTag) {
        case 1:
        case 2:
        case 3:
        {
            TiPSWithSwitchViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",TiPSWithSwitchViewCellId,(long)mode.menuTag] forIndexPath:indexPath];
            WeakSelf;
            [cell setClickOnCellBlock:^(NSInteger index) {
                weakSelf.sliderChange = @((int)index);
                if (mode.menuTag == 2) {
                    // 启动渲染
                    if (weakSelf.clickChangeRenderBlock) {
                        weakSelf.clickChangeRenderBlock(@1);
                    }
                }
            }];
            [cell setClickChangeEnabledBlock:^(bool enabled) {
                self.sliderEnabled = [NSNumber numberWithBool:enabled];
            }];
            [cell setMode:mode];
            return cell;
        }
            break;
        case 0:
        case 4:
        {
            TiPSWithoutSwitchViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:[NSString stringWithFormat:@"%@%ld",TiPSWithoutSwitchViewCellId,(long)mode.menuTag] forIndexPath:indexPath];
            WeakSelf;
            [cell setClickOnCellBlock:^(NSInteger index) {
                weakSelf.sliderChange = @((int)index);
                // 启动渲染
                if (weakSelf.clickChangeRenderBlock) {
                    weakSelf.clickChangeRenderBlock(@1);
                }
            }];
            [cell setClickChangeResetObjectBlock:^(NSString *resetObject) {
                if (weakSelf.clickChangeResetObjectBlock) {
                    weakSelf.clickChangeResetObjectBlock(resetObject);
                }
            }];
            [cell setMode:mode];
            return cell;
        }
            break;
    }
    return nil;
    
}

- (void)dealloc{
    [TiPSPlistManager releaseShareManager];
}

@end
