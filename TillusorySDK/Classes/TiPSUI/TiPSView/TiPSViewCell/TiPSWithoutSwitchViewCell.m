//
//  TiPSWithoutSwitchViewCell.m
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSWithoutSwitchViewCell.h"
#import "TiPSConfig.h"
#import "TiPSSetSDKParameters.h"
#import "TiPSWithoutSwitchViewSubCell.h"

@interface TiPSWithoutSwitchViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) NSIndexPath *selectedIndexPath;
@property(nonatomic,strong) NSIndexPath *filterIndexPath;

@end

static NSString *const TiPSWithoutSwitchViewCellId = @"TiPSWithoutSwitchViewCellId";

@implementation TiPSWithoutSwitchViewCell

- (UICollectionView *)menuCollectionView{
    if (!_menuCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(TiPSWithoutSwitchViewCellWidth, TiPSWithoutSwitchViewCellHeight);
        // 设置最小行间距
        layout.minimumLineSpacing = 8;
        _menuCollectionView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _menuCollectionView.showsHorizontalScrollIndicator = NO;
        _menuCollectionView.backgroundColor = [UIColor clearColor];
        _menuCollectionView.dataSource= self;
        _menuCollectionView.delegate = self;
        [_menuCollectionView registerClass:[TiPSWithoutSwitchViewSubCell class] forCellWithReuseIdentifier:TiPSWithoutSwitchViewCellId];
    }
    return _menuCollectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat safeBottomHeigh = 0.0f;
        if (@available(iOS 11.0, *)) {
            safeBottomHeigh = getSafeBottomHeight/2;
        }
        [self addSubview:self.menuCollectionView];
        [self.menuCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-23);
            make.height.mas_equalTo(TiPSWithoutSwitchViewCellHeight+5);
            make.centerY.equalTo(self);
        }];
        // 注册通知——通知是否重置一键美颜和滤镜
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetOneKey:) name:@"NotificationName_TIUIMenuTwo_isReset" object:nil];
    }
    return self;
    
}

#pragma mark ---UICollectionViewDataSource---
// 设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (self.mode.menuTag) {
        case 0:
            return [TiPSPlistManager shareManager].onekeyModeArr.count;
            break;
        case 4:
            return [TiPSPlistManager shareManager].filterModeArr.count;
            break;
        default:
            return 0;
            break;
    }
}

// 定义每个Cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TiPSMode *subMod = nil;
    switch (self.mode.menuTag) {
        case 0:
        {
            subMod = [TiPSPlistManager shareManager].onekeyModeArr[indexPath.row];
        }
            break;
        case 4:
        {
            subMod = [TiPSPlistManager shareManager].filterModeArr[indexPath.row];
        }
            break;
        default:
            break;
    }
    // 滤镜分类单独判断
    if (self.mode.menuTag == 4 && [subMod.thumb  isEqual: @""]) {
        return CGSizeMake(30,40);
    }else{
        return CGSizeMake(TiPSWithoutSwitchViewCellWidth ,TiPSWithoutSwitchViewCellHeight);
    }
}

// 返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TiPSWithoutSwitchViewSubCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TiPSWithoutSwitchViewCellId forIndexPath:indexPath];
    TiPSMode *subMod = nil;
    switch (self.mode.menuTag) {
        case 0:
        {
            subMod = [TiPSPlistManager shareManager].onekeyModeArr[indexPath.row];
            if (subMod.selected)
            {
                self.selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setCellType:TiPSWithoutSwitchViewCellOne];
            
            cell.layer.masksToBounds = NO;
            cell.layer.shadowOpacity = 1;// 阴影透明度
            cell.layer.shadowColor = TiColors(189.0, 0.2).CGColor;
            cell.layer.shadowRadius = 2;// 模糊计算的半径
            cell.layer.shadowOffset = CGSizeMake(0, 2);// 阴影偏移量
        }
            break;
        case 4:
        {
            subMod = [TiPSPlistManager shareManager].filterModeArr[indexPath.row];
            if (subMod.selected)
            {
                self.filterIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setCellType:TiPSWithoutSwitchViewCellOne];
            cell.layer.masksToBounds = NO;
            cell.layer.shadowOpacity = 1;// 阴影透明度
            cell.layer.shadowColor = TiColors(189.0, 0.2).CGColor;
            cell.layer.shadowRadius = 2;// 模糊计算的半径
            cell.layer.shadowOffset = CGSizeMake(0, 2);// 阴影偏移量
        }
            break;
        default:
            break;
    }
    [cell setSubMod:subMod];
    // 滤镜分类单独判断
    if (self.mode.menuTag == 4 && [subMod.thumb  isEqual: @""]) {
        cell.backgroundColor = UIColor.clearColor;
    }else{
        cell.backgroundColor = UIColor.whiteColor;
    }
    return cell;
}

- (void)resetOneKey:(NSNotification *)notification{
    NSIndexPath *IndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if (self.selectedIndexPath.row != 0) {
        // 一键美颜
        [TiPSPlistManager shareManager].onekeyModeArr   =  [[TiPSPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:IndexPath.row WithPath:@"TiPSOneKeyBeauty"];
        [TiPSPlistManager shareManager].onekeyModeArr   =  [[TiPSPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"TiPSOneKeyBeauty"];
        if (self.selectedIndexPath) {
            [self.menuCollectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,IndexPath]];
        }else{
            [self.menuCollectionView reloadItemsAtIndexPaths:@[IndexPath]];
        }
        self.selectedIndexPath = IndexPath;
        // 调整1
        [self.menuCollectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    if (self.filterIndexPath.row != 0) {
        // 滤镜
        [TiPSPlistManager shareManager].filterModeArr   =  [[TiPSPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:IndexPath.row WithPath:@"TiPSFilter"];
        [TiPSPlistManager shareManager].filterModeArr   =  [[TiPSPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.filterIndexPath.row WithPath:@"TiPSFilter"];
        [self.menuCollectionView reloadData];
        self.filterIndexPath = IndexPath;
    }else if (self.filterIndexPath.row == 0) {
        [TiPSPlistManager shareManager].filterModeArr   =  [[TiPSPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:self.filterIndexPath.row WithPath:@"TiPSFilter"];
        [self.menuCollectionView reloadData];
    }
    // 跳转指定位置
    [self.menuCollectionView scrollToItemAtIndexPath:self.filterIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    // 重置所有滤镜参数到默认参数
    for (int i = 0; i < 10; i ++) {
        [TiPSSetSDKParameters setPSFloatValue:FilterValue forKey:500+i];
    }
    if (self.clickOnCellBlock)
    {
        self.clickOnCellBlock(IndexPath.row);
    }
    
}

#pragma mark ---UICollectionViewDelegate---
// 选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.mode.menuTag == 4) {
        is_updatePSFilterValue = false;
        // 滤镜分类单独判断
        if (indexPath.row == 1 || indexPath.row == 9 || indexPath.row == 16 || indexPath.row == 26 || indexPath.row == 32 || indexPath.row == 37 || indexPath.row == 43 || indexPath.row == 48) {
            return;
        }else{
            if (self.filterIndexPath.row == indexPath.row) {
                return;
            }
            TiPSMode *modX = [TiPSPlistManager shareManager].filterModeArr[indexPath.row];
            [TiPSPlistManager shareManager].filterModeArr   =  [[TiPSPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiPSFilter"];
            if (self.filterIndexPath) {
                [TiPSPlistManager shareManager].filterModeArr   =  [[TiPSPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.filterIndexPath.row WithPath:@"TiPSFilter"];
                [collectionView reloadItemsAtIndexPaths:@[self.filterIndexPath,indexPath]];
            }else{
                for (int i = 0; i < [TiPSPlistManager shareManager].filterModeArr.count; i++) {
                    if (i == indexPath.row) {
                        continue;
                    }else{
                        [TiPSPlistManager shareManager].filterModeArr = [[TiPSPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:i WithPath:@"TiPSFilter"];
                    }
                }
                [collectionView reloadData];
            }
            self.filterIndexPath = indexPath;
            [[TiSDKManager shareManager] setBeautyFilter:modX.effectName Param:[TiPSSetSDKParameters getPSFloatValueForKey:(500+modX.menuTag)]];
            if (self.clickOnCellBlock)
            {
                self.clickOnCellBlock(modX.menuTag);
            }
        }
    }else{
        switch (self.mode.menuTag) {
            case 0:
            {
                if (self.selectedIndexPath.row == indexPath.row){
                    return;
                }
                if (indexPath.row == 0 && [TiPSSetSDKParameters getPSFloatValueForKey:TI_UIDCK_ONEKEY_SLIDER] == 100) {
                    // 关闭美颜重置功能
                    if (self.clickChangeResetObjectBlock) {
                        self.clickChangeResetObjectBlock(@"关闭重置");
                    }
                }else{
                    // 开启美颜重置功能
                    if (self.clickChangeResetObjectBlock) {
                        self.clickChangeResetObjectBlock(@"重置美颜");
                    }
                }
                [TiPSPlistManager shareManager].onekeyModeArr = [[TiPSPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiPSOneKeyBeauty"];
                if (self.selectedIndexPath) {
                    [TiPSPlistManager shareManager].onekeyModeArr = [[TiPSPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"TiPSOneKeyBeauty"];
                    [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                }else{
                    for (int i = 0; i < [TiPSPlistManager shareManager].onekeyModeArr.count; i++) {
                        if (i == indexPath.row) {
                            continue;
                        }else{
                            [TiPSPlistManager shareManager].onekeyModeArr = [[TiPSPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:i WithPath:@"TiPSOneKeyBeauty"];
                        }
                    }
                    [collectionView reloadData];
                }
                self.selectedIndexPath = indexPath;
                is_updatePSFilterValue = true;
                [TiPSSetSDKParameters setPSBeautySlider:[TiPSSetSDKParameters getPSFloatValueForKey:TI_UIDCK_ONEKEY_SLIDER] forKey:TI_UIDCK_ONEKEY_SLIDER withIndex:indexPath.row];
                if (self.clickOnCellBlock)
                {
                    self.clickOnCellBlock(indexPath.row);
                }
            }
                break;
            default:
                break;
        }
        
    }
    
}

- (void)setMode:(TiPSMode *)mode{
    if (mode) {
        _mode = mode;
    }
}

- (void)dealloc{
    // 移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end

