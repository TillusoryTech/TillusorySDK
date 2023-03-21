//
//  TiUISubMenuOneViewCell.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/5.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiUIMenuOneViewCell.h"
#import "TiButton.h"
#import "TiUISubMenuOneViewCell.h"
#import "TiUIMakeUpView.h"
#import "TiSetSDKParameters.h"

@interface TiUIMenuOneViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)TiButton *totalSwitch;
@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,strong) NSIndexPath *selectedIndexPath;
@property(nonatomic,strong) NSIndexPath *FaceshapeIndexPath;

@property(nonatomic,strong)TiUIMakeUpView *meizhuangView;

@end

static NSString *const TiUIMenuCollectionViewCellId = @"TiUIMainMenuCollectionViewnOneCellId";

@implementation TiUIMenuOneViewCell

- (TiButton *)totalSwitch{
    if (!_totalSwitch) {
        _totalSwitch = [[TiButton alloc] initWithScaling:0.9 withMakeUp:NO];
        [_totalSwitch addTarget:self action:@selector(totalSwitch:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _totalSwitch;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = TiColors(149.0,1.0);
    }
    return _lineView;
}

- (UICollectionView *)menuCollectionView{
    if (!_menuCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置最小行间距
        layout.minimumLineSpacing = 15;
        _menuCollectionView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _menuCollectionView.showsHorizontalScrollIndicator = NO;
        _menuCollectionView.backgroundColor = [UIColor clearColor];
        _menuCollectionView.dataSource= self;
        _menuCollectionView.delegate = self;
        
        [_menuCollectionView registerClass:[TiUISubMenuOneViewCell class] forCellWithReuseIdentifier:TiUIMenuCollectionViewCellId];
    }
    return _menuCollectionView;
}

- (TiUIMakeUpView *)meizhuangView{
    if (!_meizhuangView) {
        _meizhuangView =[[TiUIMakeUpView alloc] init];
        _meizhuangView.backgroundColor = UIColor.clearColor;
        WeakSelf;
        [_meizhuangView setClickOnCellBlock:^(NSInteger index) {
            if (weakSelf.clickOnCellBlock)
            {
                weakSelf.clickOnCellBlock(index);
            }
        }];
        [_meizhuangView setMakeupShowDisappearBlock:^(BOOL Hidden) {
            if (weakSelf.makeupShowDisappearBlock)
            {
                weakSelf.makeupShowDisappearBlock(Hidden);
            }
        }];
        
        [_meizhuangView setBackBlock:^(BOOL is_back) {
            if(is_back){
                [[TiUIManager shareManager].tiUIViewBoxView.menuView setBackgroundColor:TiColors(45.0, 0.6)];
                [[TiUIManager shareManager].tiUIViewBoxView.subMenuView setBackgroundColor:TiColors(45.0, 0.6)];
                [weakSelf.meizhuangView setHidden:true];
                [weakSelf.menuCollectionView setHidden:false];
                [weakSelf.menuCollectionView reloadData];
                [weakSelf.totalSwitch setHidden:false];
                [weakSelf.lineView setHidden:false];
                [[TiUIManager shareManager].tiUIViewBoxView.menuView setHidden:false];
                [[TiUIManager shareManager].tiUIViewBoxView.downBackBtn setHidden:false];
                //显示重置
                [TiUIManager shareManager].tiUIViewBoxView.resetBtn.hidden = NO;
                [[TiUIManager shareManager].tiUIViewBoxView setOtherTitleHidden:true withName:@"" withCute:false];
            }else{
                [weakSelf.menuCollectionView setHidden:true];
                [weakSelf.totalSwitch setHidden:true];
                [[TiUIManager shareManager].tiUIViewBoxView.menuView setHidden:true];
                //                [[TiUIManager shareManager].tiUIViewBoxView.subMenuView setBackgroundColor:UIColor.clearColor];
                [[TiUIManager shareManager].tiUIViewBoxView.downBackBtn setHidden:true];
                [[TiUIManager shareManager].tiUIViewBoxView.otherTopLabel setTextColor:[UIColor whiteColor]];
                [weakSelf.meizhuangView.defaultBtn setImage:[UIImage imageNamed:@"meizhuang_wu_normal_white.png"] forState:UIControlStateNormal];
                if (Default_is_Null) {
                    [weakSelf.meizhuangView.defaultLabel setTextColor:TiColor(88.0, 221.0, 221.0, 1.0)];
                }else{
                    [weakSelf.meizhuangView.defaultLabel setTextColor:UIColor.whiteColor];
                }
                [weakSelf.meizhuangView setHidden:false];
                //隐藏重置
                [TiUIManager shareManager].tiUIViewBoxView.resetBtn.hidden = YES;
            }
        }];
        
    }
    return _meizhuangView;
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
            make.width.mas_equalTo(TiUISubMenuOneViewTiButtonWidth-12);
            make.height.mas_equalTo(TiUISubMenuOneViewTiButtonHeight);
            make.top.equalTo(self).offset(30);
        }];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.totalSwitch.mas_right).offset(20);
            make.width.mas_equalTo(0.25);
            make.height.mas_equalTo(TiUISubMenuOneViewTiButtonHeight);
            make.top.equalTo(self).offset(30);
        }];
        [self.menuCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.lineView.mas_right).offset(25);
            make.right.equalTo(self.mas_right).offset(-20);
            make.height.mas_equalTo(TiUISubMenuOneViewTiButtonHeight);
            make.top.equalTo(self).offset(30);
        }];
        [self addSubview:self.meizhuangView];
        [self.meizhuangView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
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
        case 0:
            return [TiMenuPlistManager shareManager].beautyModeArr.count;
            break;
        case 1:
            return [TiMenuPlistManager shareManager].appearanceModeArr.count;
            break;
        case 6:
            return [TiMenuPlistManager shareManager].distortionModeArr.count;
            break;
        case 12:
            return [TiMenuPlistManager shareManager].makeupModArr.count;
            break;
        case 13:
            return [TiMenuPlistManager shareManager].faceshapeModeArr.count;
            break;
        default:
            return 0;
            break;
    }
}

// 定义每个Cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    TIMenuMode *subMod = nil;
    switch (self.mode.menuTag) {
        case 0:
        {
            subMod = [TiMenuPlistManager shareManager].beautyModeArr[indexPath.row];
        }
            break;
        case 1:
        {
            subMod = [TiMenuPlistManager shareManager].appearanceModeArr[indexPath.row];
        }
            break;
        case 6:
        {
            subMod = [TiMenuPlistManager shareManager].distortionModeArr[indexPath.row];
        }
            break;
        case 12:
        {
            subMod = [TiMenuPlistManager shareManager].makeupModArr[indexPath.row];
        }
            break;
        case 13:
        {
            subMod = [TiMenuPlistManager shareManager].faceshapeModeArr[indexPath.row];
        }
            break;
        default:
            break;
    }
    //美颜分类单独判断
    if (self.mode.menuTag == 0 && [subMod.normalThumb isEqual:@""]) {
        return CGSizeMake(45,60);
    }
    //美型分类单独判断
    else if (self.mode.menuTag == 1 && [subMod.normalThumb  isEqual: @""]) {
        if ([subMod.name  isEqual: @"point"]) {
            return CGSizeMake(34, TiUISubMenuOneViewTiButtonHeight);
        }
        return CGSizeMake(45,40);
    }else{
        return CGSizeMake(TiUISubMenuOneViewTiButtonWidth ,TiUISubMenuOneViewTiButtonHeight);
    }
    
}

//返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TiUISubMenuOneViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TiUIMenuCollectionViewCellId forIndexPath:indexPath];
    switch (self.mode.menuTag) {
        case 0:
        {
            TIMenuMode * subMod = [[TiMenuPlistManager shareManager].beautyModeArr objectAtIndex:indexPath.row];
            if (subMod.selected)
            {
                self.selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setSubMod:subMod];
        }
            break;
        case 1:
        {
            TIMenuMode * subMod = [[TiMenuPlistManager shareManager].appearanceModeArr objectAtIndex:indexPath.row];
            if (subMod.selected)
            {
                self.selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setSubMod:subMod];
        }
            break;
        case 6:
        {
            //哈哈更新约束
            [self.totalSwitch setHidden:true];
            [self.menuCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(40);
                make.right.equalTo(self).offset(-43);
            }];
            TIMenuMode * subMod = [[TiMenuPlistManager shareManager].distortionModeArr objectAtIndex:indexPath.row];
            if (subMod.selected)
            {
                self.selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            subMod = [TiMenuPlistManager shareManager].distortionModeArr[indexPath.row];
            [cell setSubMod:subMod];
        }
            break;
        case 12:
        {
            [TiUIManager shareManager].tiUIViewBoxView.viewModel.sliderHidden = @1;
            TIMenuMode * subMod = [[TiMenuPlistManager shareManager].makeupModArr objectAtIndex:indexPath.row];
            if (subMod.selected)
            {
                self.selectedIndexPath = nil;
            }
            [cell setSubMod:subMod];
        }
            break;
        case 13:
        {
            //脸型时更新约束
            [self.totalSwitch setHidden:true];
            [self.menuCollectionView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(40);
                make.right.equalTo(self).offset(-43);
            }];
            TIMenuMode * subMod = [[TiMenuPlistManager shareManager].faceshapeModeArr objectAtIndex:indexPath.row];
            if (subMod.selected)
            {
                self.FaceshapeIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setSubMod:subMod];
        }
            break;
            
        default:
            break;
    }
    
    return cell;
    
}

//判断默认按钮状态
- (BOOL)is_selected{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (self.meizhuangView.mode.menuTag == 1) {
        NSString *cheekRed_default = [defaults objectForKey:@"cheekRed_default"];
        if (![cheekRed_default  isEqual: NSLocalizedString(@"腮红", nil)]) {
            return true;
        }else{
            return false;
        }
    }
    //    else if (self.meizhuangView.mode.menuTag == 2) {
    //        NSString *eyelash_default = [defaults objectForKey:@"eyelash_default"];
    //        if (![eyelash_default  isEqual: NSLocalizedString(@"睫毛", nil)]) {
    //            return true;
    //        }else{
    //            return false;
    //        }
    //    }
    else if (self.meizhuangView.mode.menuTag == 2) {
        NSString *eyebrows_default = [defaults objectForKey:@"eyebrows_default"];
        if (![eyebrows_default  isEqual: NSLocalizedString(@"眉毛", nil)]) {
            return true;
        }else{
            return false;
        }
    }
    else if (self.meizhuangView.mode.menuTag == 3) {
        NSString *eyeshadow_default = [defaults objectForKey:@"eyeshadow_default"];
        if (![eyeshadow_default  isEqual: NSLocalizedString(@"眼影", nil)]) {
            return true;
        }else{
            return false;
        }
    }
    else if (self.meizhuangView.mode.menuTag == 4) {
        NSString *lipgloss_default = [defaults objectForKey:@"lipgloss_default"];
        if (![lipgloss_default  isEqual: NSLocalizedString(@"唇彩", nil)]) {
            return true;
        }else{
            return false;
        }
    }
    //    else if (self.meizhuangView.mode.menuTag == 5) {
    //        NSString *eyeLine_default = [defaults objectForKey:@"eyeLine_default"];
    //        if (![eyeLine_default  isEqual: NSLocalizedString(@"眼线", nil)]) {
    //            return true;
    //        }else{
    //            return false;
    //        }
    //    }
    return true;
}

- (void)resetFaceshape:(NSNotification *)notification{
    
    NSIndexPath *IndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if (self.FaceshapeIndexPath.row != 0) {
        if (self.clickOnCellBlock)
        {
            self.clickOnCellBlock(IndexPath.row);
        }
        [TiMenuPlistManager shareManager].faceshapeModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:IndexPath.row WithPath:@"TiFaceShape"];
        [TiMenuPlistManager shareManager].faceshapeModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.FaceshapeIndexPath.row WithPath:@"TiFaceShape"];
        
        //重置-储存一脸型选中位置
        [TiSetSDKParameters setSelectPosition:IndexPath.row forKey:TI_UIDCK_FACESHAPE_POSITION];
        
        if (self.FaceshapeIndexPath) {
            [self.menuCollectionView reloadItemsAtIndexPaths:@[self.FaceshapeIndexPath,IndexPath]];
        }else{
            [self.menuCollectionView reloadItemsAtIndexPaths:@[IndexPath]];
        }
        self.FaceshapeIndexPath = IndexPath;
    }
    
}

#pragma mark ---UICollectionViewDelegate---
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //美颜美型分类单独判断
    if (self.mode.menuTag == 1 && (indexPath.row == 2 || indexPath.row == 9 || indexPath.row == 14 || indexPath.row == 17 || indexPath.row == 22)) {
        return;
    }else if (self.mode.menuTag == 0 && indexPath.row == 5){
        return;
    }else{
        if (self.mode.menuTag == 12) {
            isswitch_makeup = true;
            [[TiUIManager shareManager].tiUIViewBoxView.rightBackView setHidden:true];
            [self.lineView setHidden:true];
            [self.meizhuangView setHiddenAnimation:NO];
            self.meizhuangView.mode = [[TiMenuPlistManager shareManager].makeupModArr objectAtIndex:indexPath.row];
            
            if (self.makeupShowDisappearBlock) {
                self.makeupShowDisappearBlock(NO);
            }
            //设置默认按钮状态
            Default_is_Null = [self is_selected];
            //判断默认按钮状态
            if (Default_is_Null) {
                [self.meizhuangView.defaultBtn setSelected:true];
                [self.meizhuangView.defaultLabel setTextColor:TiColor(88.0, 221.0, 221.0, 1.0)];
            }else{
                [self.meizhuangView.defaultBtn setSelected:false];
                [self.meizhuangView.defaultLabel setTextColor:UIColor.whiteColor];
            }
            //单独设置文字
            self.meizhuangView.backBlock(NO);
            //是否已重置
            if (makeUpResetComplete == true) {
                //            [self.meizhuangView defaultselected:self.meizhuangView.defaultBtn];
                makeUpResetComplete = false;
            }
            //是否显示滑动条
            if (Default_is_Null) {
                [TiUIManager shareManager].tiUIViewBoxView.viewModel.sliderHidden = @1;
            }else{
                [TiUIManager shareManager].tiUIViewBoxView.viewModel.subindex = (indexPath.row+1)*1000;
                [TiUIManager shareManager].tiUIViewBoxView.viewModel.sliderHidden = @0;
            }
            [[TiUIManager shareManager].tiUIViewBoxView setOtherTitleHidden:false withName:self.meizhuangView.mode.name withCute:false];
            return;
        }
        if (self.clickOnCellBlock)
        {
            if (self.mode.menuTag == 0){
                TIMenuMode *modX = [TiMenuPlistManager shareManager].beautyModeArr[indexPath.row];
                self.clickOnCellBlock(modX.menuTag);
            }else if(self.mode.menuTag == 1){
                TIMenuMode *modY = [TiMenuPlistManager shareManager].appearanceModeArr[indexPath.row];
                self.clickOnCellBlock(modY.menuTag);
            }else{
                self.clickOnCellBlock(indexPath.row);
            }
        }
        if (self.mode.menuTag == 13) {
            if (indexPath.row == self.FaceshapeIndexPath.row)
            {
                return;
            }else{
                //储存脸型选中位置
                [TiSetSDKParameters setSelectPosition:indexPath.row forKey:TI_UIDCK_FACESHAPE_POSITION];
                [TiMenuPlistManager shareManager].faceshapeModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiFaceShape"];
                if (self.FaceshapeIndexPath) {
                    [TiMenuPlistManager shareManager].faceshapeModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.FaceshapeIndexPath.row WithPath:@"TiFaceShape"];
                    [collectionView reloadItemsAtIndexPaths:@[self.FaceshapeIndexPath,indexPath]];
                }else{
                    for (int i = 0; i < [TiMenuPlistManager shareManager].faceshapeModeArr.count; i++) {
                        if (i == indexPath.row) {
                            continue;
                        }else{
                            [TiMenuPlistManager shareManager].faceshapeModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:i WithPath:@"TiFaceShape"];
                        }
                    }
                    [collectionView reloadData];
                }
                self.FaceshapeIndexPath = indexPath;
                [TiSetSDKParameters setBeautySlider:[TiSetSDKParameters getFloatValueForKey:TI_UIDCK_FACESHAPE_SLIDER] forKey:TI_UIDCK_FACESHAPE_SLIDER withIndex:indexPath.row];
            }
            return;
        }else{
            if(indexPath.row == self.selectedIndexPath.row)
            {
                return;
            }
            switch (self.mode.menuTag) {
                case 0:
                {
                    [TiMenuPlistManager shareManager].beautyModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiBeauty"];
                    if (self.selectedIndexPath) {
                        [TiMenuPlistManager shareManager].beautyModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"TiBeauty"];
                        [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                    }else{
                        for (int i = 0; i < [TiMenuPlistManager shareManager].beautyModeArr.count; i++) {
                            if (i == indexPath.row) {
                                continue;
                            }else{
                                [TiMenuPlistManager shareManager].beautyModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:i WithPath:@"TiBeauty"];
                            }
                        }
                        [collectionView reloadData];
                    }
                    self.selectedIndexPath = indexPath;
                    
                    //                    TIMenuMode *mod = [TiMenuPlistManager shareManager].beautyModeArr[indexPath.row];
                    //                    [TiSetSDKParameters setBeautySlider:[TiSetSDKParameters getFloatValueForKey:(100 + mod.menuTag)] forKey:(100 + mod.menuTag) withIndex:indexPath.row];
                }
                    break;
                case 1:
                {
                    [TiMenuPlistManager shareManager].appearanceModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiAppearance"];
                    if (self.selectedIndexPath) {
                        [TiMenuPlistManager shareManager].appearanceModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"TiAppearance"];
                        [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                    }else{
                        for (int i = 0; i < [TiMenuPlistManager shareManager].appearanceModeArr.count; i++) {
                            if (i == indexPath.row) {
                                continue;
                            }else{
                                [TiMenuPlistManager shareManager].appearanceModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:i WithPath:@"TiAppearance"];
                            }
                        }
                        [collectionView reloadData];
                    }
                    self.selectedIndexPath = indexPath;
                }
                    break;
                case 6:
                {
                    [TiMenuPlistManager shareManager].distortionModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiDistortion"];
                    if (self.selectedIndexPath) {
                        [TiMenuPlistManager shareManager].distortionModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"TiDistortion"];
                        [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                    }else{
                        for (int i = 0; i < [TiMenuPlistManager shareManager].distortionModeArr.count; i++) {
                            if (i == indexPath.row) {
                                continue;
                            }else{
                                [TiMenuPlistManager shareManager].distortionModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:i WithPath:@"TiDistortion"];
                            }
                        }
                        [collectionView reloadData];
                    }
                    self.selectedIndexPath = indexPath;
                    [[TiSDKManager shareManager] setDistortionEnum:[TiSetSDKParameters setDistortionEnumByIndex:indexPath.row]];
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
    if (success) {
        if (self.mode.menuTag == 0 || self.mode.menuTag == 1) {
            [TiMenuPlistManager shareManager].mainModeArr  = [[TiMenuPlistManager shareManager] modifyObject:@(success) forKey:@"totalSwitch" In:self.mode.menuTag WithPath:@"TiMenu"];
            TIMenuMode *newMod = [TiMenuPlistManager shareManager].mainModeArr[self.mode.menuTag];
            _mode = newMod;
            [self.totalSwitch setSelected:newMod.totalSwitch];
            [[TiSDKManager shareManager] setBeautyEnable:success];
            [[TiSDKManager shareManager] setFaceTrimEnable:success];
            [TiUIManager shareManager].tiUIViewBoxView.sliderRelatedView.userInteractionEnabled = success;
        }
    }
    
}

- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)totalSwitch:(TiButton *)sender{
    
    [TiMenuPlistManager shareManager].mainModeArr  = [[TiMenuPlistManager shareManager] modifyObject:@(!self.mode.totalSwitch) forKey:@"totalSwitch" In:self.mode.menuTag WithPath:@"TiMenu"];
    TIMenuMode *newMod = [TiMenuPlistManager shareManager].mainModeArr[self.mode.menuTag];
    _mode = newMod;
    [self.totalSwitch setSelected:newMod.totalSwitch];
    
    if (newMod.menuTag ==0)
    {
        [[TiSDKManager shareManager] setBeautyEnable:newMod.totalSwitch];
        [TiUIManager shareManager].tiUIViewBoxView.sliderRelatedView.userInteractionEnabled = newMod.totalSwitch;
    }
    else if(newMod.menuTag==1)
    {
        [[TiSDKManager shareManager] setFaceTrimEnable:newMod.totalSwitch];
        [TiUIManager shareManager].tiUIViewBoxView.sliderRelatedView.userInteractionEnabled = newMod.totalSwitch;
    }
    else if(newMod.menuTag==12)
    {
        [[TiSDKManager shareManager] setMakeupEnable:newMod.totalSwitch];
        [TiUIManager shareManager].tiUIViewBoxView.sliderRelatedView.userInteractionEnabled = newMod.totalSwitch;
    }
    
}

- (void)setMode:(TIMenuMode *)mode{
    if (mode) {
        _mode = mode;
        [self.totalSwitch setTitle:[NSString stringWithFormat:NSLocalizedString(@"%@:关", nil),NSLocalizedString(mode.name,nil)] withImage:[UIImage imageNamed:@"btn_close"] withTextColor:TiColors(149.0,1.0) forState:UIControlStateNormal];
        [self.totalSwitch setTitle:[NSString stringWithFormat:NSLocalizedString(@"%@:开", nil),NSLocalizedString(mode.name,nil)] withImage:[UIImage imageNamed:@"btn_open"] withTextColor:TiColor(88.0,221.0,221.0,1.0) forState:UIControlStateSelected];
        [self.totalSwitch setSelected:mode.totalSwitch];
        
        [self.menuCollectionView reloadData];
    }
    
}

@end
