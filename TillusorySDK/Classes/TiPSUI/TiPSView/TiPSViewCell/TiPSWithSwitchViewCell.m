//
//  TiPSWithSwitchViewCell.m
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSWithSwitchViewCell.h"
#import "TiPSButton.h"
#import "TiPSWithSwitchViewSubCell.h"
#import "TiPSSetSDKParameters.h"

@interface TiPSWithSwitchViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)TiPSButton *totalSwitch;
@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,strong) NSIndexPath *selectedIndexPath;
@property(nonatomic,strong) NSIndexPath *FaceshapeIndexPath;

@end

static NSString *const TiPSWithSwitchViewCellId = @"TiPSWithSwitchViewCellId";

@implementation TiPSWithSwitchViewCell

- (TiPSButton *)totalSwitch{
    if (!_totalSwitch) {
        _totalSwitch = [[TiPSButton alloc] initWithScaling:0.9 withMakeUp:NO];
        [_totalSwitch addTarget:self action:@selector(totalSwitch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _totalSwitch;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = TiColors(149.0,1.0);
    }
    return _lineView;
}

- (UICollectionView *)menuCollectionView{
    if (!_menuCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        // 设置最小行间距
        layout.minimumLineSpacing = 15;
        _menuCollectionView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _menuCollectionView.showsHorizontalScrollIndicator = NO;
        _menuCollectionView.backgroundColor = [UIColor clearColor];
        _menuCollectionView.dataSource= self;
        _menuCollectionView.delegate = self;
        [_menuCollectionView registerClass:[TiPSWithSwitchViewSubCell class] forCellWithReuseIdentifier:TiPSWithSwitchViewCellId];
    }
    return _menuCollectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.totalSwitch];
        [self addSubview:self.lineView];
        [self addSubview:self.menuCollectionView];
        
        CGFloat safeBottomHeigh = 0.0f;
        if (@available(iOS 11.0, *)) {
            safeBottomHeigh = getSafeBottomHeight/2;
        }
        
        [self.totalSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(35);
            make.width.mas_equalTo(TiPSWithSwitchViewCellWidth-12);
            make.height.mas_equalTo(TiPSWithSwitchViewCellHeight);
            make.centerY.equalTo(self);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.totalSwitch.mas_right).offset(20);
            make.width.mas_equalTo(0.5);
            make.height.centerY.equalTo(self.totalSwitch);
        }];
        [self.menuCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView.mas_right).offset(25);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.centerY.equalTo(self.totalSwitch);
        }];
        
        //注册通知——通知是否强制开启美颜美型
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(totalStatus:) name:@"NotificationName_TIUIMenuOne_isOpen" object:nil];
        //注册通知——通知是否重置脸型
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetFaceshape:) name:@"NotificationName_TIUIMenuOne_isReset" object:nil];
    }
    return self;
}

#pragma mark ---UICollectionViewDataSource---
//设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (self.mode.menuTag) {
        case 1:
            return [TiPSPlistManager shareManager].beautyModeArr.count;
            break;
        case 2:
            return [TiPSPlistManager shareManager].faceshapeModeArr.count;
            break;
        case 3:
            return [TiPSPlistManager shareManager].appearanceModeArr.count;
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
        case 1:
        {
            subMod = [TiPSPlistManager shareManager].beautyModeArr[indexPath.row];
        }
            break;
        case 2:
        {
            subMod = [TiPSPlistManager shareManager].faceshapeModeArr[indexPath.row];
        }
            break;
        case 3:
        {
            subMod = [TiPSPlistManager shareManager].appearanceModeArr[indexPath.row];
        }
            break;
        default:
            break;
    }
    // 美颜分类单独判断
    if (self.mode.menuTag == 1 && [subMod.normalThumb isEqual:@""]) {
        return CGSizeMake(45,60);
    }
    // 美型分类单独判断
    else if (self.mode.menuTag == 3 && [subMod.normalThumb  isEqual: @""]) {
        if ([subMod.name  isEqual: @"point"]) {
            return CGSizeMake(34, TiPSWithSwitchViewCellHeight);
        }
        return CGSizeMake(45,40);
    }else{
        return CGSizeMake(TiPSWithSwitchViewCellWidth,TiPSWithSwitchViewCellHeight);
    }
}

// 返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TiPSWithSwitchViewSubCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TiPSWithSwitchViewCellId forIndexPath:indexPath];
    switch (self.mode.menuTag) {
        case 1:
        {
            TiPSMode * subMod = [[TiPSPlistManager shareManager].beautyModeArr objectAtIndex:indexPath.row];
            if (subMod.selected)
            {
                self.selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setSubMod:subMod];
        }
            break;
        case 2:
        {
            // 脸型时更新约束
            [self.totalSwitch setHidden:true];
            [self.menuCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(40);
                make.right.equalTo(self).offset(-43);
            }];
            TiPSMode * subMod = [[TiPSPlistManager shareManager].faceshapeModeArr objectAtIndex:indexPath.row];
            if (subMod.selected)
            {
                self.FaceshapeIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setSubMod:subMod];
        }
            break;
        case 3:
        {
            TiPSMode * subMod = [[TiPSPlistManager shareManager].appearanceModeArr objectAtIndex:indexPath.row];
            if (subMod.selected)
            {
                self.selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setSubMod:subMod];
        }
            break;
        default:
            break;
    }
    
    return cell;
    
}

- (void)resetFaceshape:(NSNotification *)notification{
    
    NSIndexPath *IndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if (self.FaceshapeIndexPath.row != 0) {
        [TiPSPlistManager shareManager].faceshapeModeArr   =  [[TiPSPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:IndexPath.row WithPath:@"TiPSFaceShape"];
        [TiPSPlistManager shareManager].faceshapeModeArr   =  [[TiPSPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.FaceshapeIndexPath.row WithPath:@"TiPSFaceShape"];
        
        if (self.FaceshapeIndexPath) {
            [self.menuCollectionView reloadItemsAtIndexPaths:@[self.FaceshapeIndexPath,IndexPath]];
        }else{
            [self.menuCollectionView reloadItemsAtIndexPaths:@[IndexPath]];
        }
        self.FaceshapeIndexPath = IndexPath;
    }
    if (self.clickOnCellBlock)
    {
        self.clickOnCellBlock(IndexPath.row);
    }
    
}

#pragma mark ---UICollectionViewDelegate---
// 选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    // 美颜美型分类单独判断
    if (self.mode.menuTag == 3 && (indexPath.row == 2 || indexPath.row == 9 || indexPath.row == 14 || indexPath.row == 17 || indexPath.row == 22)) {
        return;
    }else if (self.mode.menuTag == 1 && indexPath.row == 5){
        return;
    }else{
        if (self.clickOnCellBlock)
        {
            if (self.mode.menuTag == 1){
                TiPSMode *modX = [TiPSPlistManager shareManager].beautyModeArr[indexPath.row];
                self.clickOnCellBlock(modX.menuTag);
            }else if(self.mode.menuTag == 3){
                TiPSMode *modY = [TiPSPlistManager shareManager].appearanceModeArr[indexPath.row];
                self.clickOnCellBlock(modY.menuTag);
            }
        }
        if (self.mode.menuTag == 2) {
            if (indexPath.row == self.FaceshapeIndexPath.row)
            {
                return;
            }else{
                [TiPSPlistManager shareManager].faceshapeModeArr = [[TiPSPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiPSFaceShape"];
                if (self.FaceshapeIndexPath) {
                    [TiPSPlistManager shareManager].faceshapeModeArr = [[TiPSPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.FaceshapeIndexPath.row WithPath:@"TiPSFaceShape"];
                    [collectionView reloadItemsAtIndexPaths:@[self.FaceshapeIndexPath,indexPath]];
                }else{
                    for (int i = 0; i < [TiPSPlistManager shareManager].faceshapeModeArr.count; i++) {
                        if (i == indexPath.row) {
                            continue;
                        }else{
                            [TiPSPlistManager shareManager].faceshapeModeArr = [[TiPSPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:i WithPath:@"TiPSFaceShape"];
                        }
                    }
                    [collectionView reloadData];
                }
                self.FaceshapeIndexPath = indexPath;
                [TiPSSetSDKParameters setPSBeautySlider:[TiPSSetSDKParameters getPSFloatValueForKey:TI_UIDCK_FACESHAPE_SLIDER] forKey:TI_UIDCK_FACESHAPE_SLIDER withIndex:indexPath.row];
                if (self.clickOnCellBlock) {
                    self.clickOnCellBlock(indexPath.row);
                }
            }
            return;
        }else{
            if(indexPath.row == self.selectedIndexPath.row)
            {
                return;
            }
            switch (self.mode.menuTag) {
                case 1:
                {
                    [TiPSPlistManager shareManager].beautyModeArr = [[TiPSPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiPSBeauty"];
                    if (self.selectedIndexPath) {
                        [TiPSPlistManager shareManager].beautyModeArr = [[TiPSPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"TiPSBeauty"];
                        [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                    }else{
                        for (int i = 0; i < [TiPSPlistManager shareManager].beautyModeArr.count; i++) {
                            if (i == indexPath.row) {
                                continue;
                            }else{
                                [TiPSPlistManager shareManager].beautyModeArr = [[TiPSPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:i WithPath:@"TiPSBeauty"];
                            }
                        }
                        [collectionView reloadData];
                    }
                    self.selectedIndexPath = indexPath;
                }
                    break;
                case 3:
                {
                    [TiPSPlistManager shareManager].appearanceModeArr = [[TiPSPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiPSAppearance"];
                    if (self.selectedIndexPath) {
                        [TiPSPlistManager shareManager].appearanceModeArr = [[TiPSPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"TiPSAppearance"];
                        [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                    }else{
                        for (int i = 0; i < [TiPSPlistManager shareManager].appearanceModeArr.count; i++) {
                            if (i == indexPath.row) {
                                continue;
                            }else{
                                [TiPSPlistManager shareManager].appearanceModeArr = [[TiPSPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:i WithPath:@"TiPSAppearance"];
                            }
                        }
                        [collectionView reloadData];
                    }
                    self.selectedIndexPath = indexPath;
                }
                    break;
                default:
                    break;
            }
            
        }
        
    }
    
}

- (void)totalStatus:(NSNotification *)notification{
    
    NSNumber *successN = notification.object;
    BOOL success =  [successN boolValue];
    if (self.mode.menuTag == 1 || self.mode.menuTag == 3) {
        [TiPSPlistManager shareManager].mainModeArr  = [[TiPSPlistManager shareManager] modifyObject:@(success) forKey:@"totalSwitch" In:self.mode.menuTag WithPath:@"TiPSMenu"];
        TiPSMode *newMod = [TiPSPlistManager shareManager].mainModeArr[self.mode.menuTag];
        _mode = newMod;
        [self.totalSwitch setSelected:newMod.totalSwitch];
        [[TiSDKManager shareManager] setBeautyEnable:success];
        [[TiSDKManager shareManager] setFaceTrimEnable:success];
        if (self.clickChangeEnabledBlock) {
            self.clickChangeEnabledBlock(success);
        }
    }
    
}

- (void)dealloc{
    // 移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)totalSwitch:(TiPSButton *)sender{
    
    [TiPSPlistManager shareManager].mainModeArr  = [[TiPSPlistManager shareManager] modifyObject:@(!self.mode.totalSwitch) forKey:@"totalSwitch" In:self.mode.menuTag WithPath:@"TiPSMenu"];
    TiPSMode *newMod = [TiPSPlistManager shareManager].mainModeArr[self.mode.menuTag];
    _mode = newMod;
    [self.totalSwitch setSelected:newMod.totalSwitch];
    
    if (newMod.menuTag == 1)
    {
        [[TiSDKManager shareManager] setBeautyEnable:newMod.totalSwitch];
        if (self.clickChangeEnabledBlock) {
            self.clickChangeEnabledBlock(newMod.totalSwitch);
        }
    }
    else if(newMod.menuTag == 3)
    {
        [[TiSDKManager shareManager] setFaceTrimEnable:newMod.totalSwitch];
        if (self.clickChangeEnabledBlock) {
            self.clickChangeEnabledBlock(newMod.totalSwitch);
        }
    }
    
}

- (void)setMode:(TiPSMode *)mode{
    if (mode) {
        _mode = mode;
        [self.totalSwitch setTitle:[NSString stringWithFormat:NSLocalizedString(@"%@:关", nil),NSLocalizedString(mode.name,nil)] withImage:[UIImage imageNamed:@"btn_close_ps"] withTextColor:TiColors(149.0,1.0) forState:UIControlStateNormal];
        [self.totalSwitch setTitle:[NSString stringWithFormat:NSLocalizedString(@"%@:开", nil),NSLocalizedString(mode.name,nil)] withImage:[UIImage imageNamed:@"btn_open_ps"] withTextColor:TiColor(88.0,221.0,221.0,1.0) forState:UIControlStateSelected];
        [self.totalSwitch setSelected:mode.totalSwitch];
        
        [self.menuCollectionView reloadData];
    }
    
}

@end
