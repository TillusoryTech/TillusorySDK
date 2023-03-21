//
//  TiUIMenuTwoViewCell.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/5.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiUIMenuTwoViewCell.h"
#import "TiUIConfig.h"
#import "TiUISubMenuTwoViewCell.h"
#import "TiSetSDKParameters.h"

@interface TiUIMenuTwoViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) NSIndexPath *selectedIndexPath;
@property(nonatomic,strong) NSIndexPath *filterIndexPath;
@property(nonatomic,strong) NSIndexPath *otherIndexPath;

@end

static NSString *const TiUIMenuCollectionViewCellId = @"TiUIMainMenuTiUIMenuTwoViewCellId";

@implementation TiUIMenuTwoViewCell

- (UICollectionView *)menuCollectionView{
    if (!_menuCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(TiUISubMenuTwoViewTiButtonWidth, TiUISubMenuTwoViewTiButtonHeight);
        // 设置最小行间距
        layout.minimumLineSpacing = 8;
        _menuCollectionView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _menuCollectionView.showsHorizontalScrollIndicator = NO;
        _menuCollectionView.backgroundColor = [UIColor clearColor];
        _menuCollectionView.dataSource= self;
        _menuCollectionView.delegate = self;
        
        [_menuCollectionView registerClass:[TiUISubMenuTwoViewCell class] forCellWithReuseIdentifier:TiUIMenuCollectionViewCellId];
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
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.menuCollectionView];
        [self.menuCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(20);
            make.right.equalTo(self.mas_right).offset(-23);
            make.height.mas_equalTo(TiUISubMenuTwoViewTiButtonHeight+5);
            make.top.equalTo(self).offset(20);
        }];
        //注册通知——通知滤镜同步一键美颜
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(synchronization:) name:@"NotificationName_TIUIMenuTwo_UpdateFilter" object:nil];
        //注册通知——通知是否重置一键美颜和滤镜
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetOneKey:) name:@"NotificationName_TIUIMenuTwo_isReset" object:nil];
        
    }
    return self;
    
}

#pragma mark ---UICollectionViewDataSource---
//设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    switch (self.mode.menuTag) {
        case 4:
            return [TiMenuPlistManager shareManager].filterModeArr.count;
            break;
        case 5:
            return [TiMenuPlistManager shareManager].rockModeArr.count;
            break;
        case 10:
            return [TiMenuPlistManager shareManager].onekeyModeArr.count;
            break;
        case 15:
            return [TiMenuPlistManager shareManager].hairdressModArr.count;
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
        case 4:
        {
            subMod = [TiMenuPlistManager shareManager].filterModeArr[indexPath.row];
        }
            break;
        case 5:
        {
            subMod = [TiMenuPlistManager shareManager].rockModeArr[indexPath.row];
        }
            break;
        case 10:
        {
            subMod = [TiMenuPlistManager shareManager].onekeyModeArr[indexPath.row];
        }
            break;
        case 15:
        {
            subMod = [TiMenuPlistManager shareManager].hairdressModArr[indexPath.row];
        }
            break;
        default:
            break;
    }
    //滤镜分类单独判断
    if (self.mode.menuTag == 4 && [subMod.thumb  isEqual: @""]) {
        return CGSizeMake(30,40);
    }else{
        return CGSizeMake(TiUISubMenuTwoViewTiButtonWidth ,TiUISubMenuTwoViewTiButtonHeight);
    }
    
}

// 返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TiUISubMenuTwoViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TiUIMenuCollectionViewCellId forIndexPath:indexPath];
    TIMenuMode *subMod = nil;
    switch (self.mode.menuTag) {
        case 4:
        {
            subMod = [TiMenuPlistManager shareManager].filterModeArr[indexPath.row];
            
            if (subMod.selected)
            {
                self.filterIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            
            [cell setCellType:TI_UI_TWOSUBCELL_TYPE_ONE];
            
            cell.layer.masksToBounds = NO;
            cell.layer.shadowOpacity = 1;   //阴影透明度
            cell.layer.shadowColor = TiColors(189.0, 0.2).CGColor;
            cell.layer.shadowRadius = 2;  //模糊计算的半径
            cell.layer.shadowOffset = CGSizeMake(0, 2);   //阴影偏移量
            
        }
            break;
        case 5:
        {
            subMod = [TiMenuPlistManager shareManager].rockModeArr[indexPath.row];
            if (subMod.selected)
            {
                self.otherIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setCellType:TI_UI_TWOSUBCELL_TYPE_ONE];
            
            cell.layer.masksToBounds = NO;
            cell.layer.shadowOpacity = 1;   //阴影透明度
            cell.layer.shadowColor = TiColors(189.0, 0.2).CGColor;
            cell.layer.shadowRadius = 2;  //模糊计算的半径
            cell.layer.shadowOffset = CGSizeMake(0, 2);   //阴影偏移量
        }
            break;
        case 10:
        {
            subMod = [TiMenuPlistManager shareManager].onekeyModeArr[indexPath.row];
            if (subMod.selected)
            {
                self.selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setCellType:TI_UI_TWOSUBCELL_TYPE_ONE];
            
            cell.layer.masksToBounds = NO;
            cell.layer.shadowOpacity = 1;   //阴影透明度
            cell.layer.shadowColor = TiColors(189.0, 0.2).CGColor;
            cell.layer.shadowRadius = 2;  //模糊计算的半径
            cell.layer.shadowOffset = CGSizeMake(0, 2);   //阴影偏移量
        }
            break;
        case 15:
        {
            subMod = [TiMenuPlistManager shareManager].hairdressModArr[indexPath.row];
            if (subMod.selected)
            {
                self.otherIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
            }
            [cell setCellType:TI_UI_TWOSUBCELL_TYPE_ONE];
            
            cell.layer.masksToBounds = NO;
            cell.layer.shadowOpacity = 1;   //阴影透明度
            cell.layer.shadowColor = TiColors(189.0, 0.2).CGColor;
            cell.layer.shadowRadius = 2;  //模糊计算的半径
            cell.layer.shadowOffset = CGSizeMake(0, 2);   //阴影偏移量
        }
            break;
        default:
            break;
    }
    [cell setSubMod:subMod];
    //滤镜分类单独判断
    if (self.mode.menuTag == 4 && [subMod.thumb  isEqual: @""]) {
        cell.backgroundColor = UIColor.clearColor;
    }else{
        cell.backgroundColor = UIColor.whiteColor;
    }
    return cell;
}

//滤镜同步一键美颜
- (void)synchronization:(NSNotification *)notification{
    
    //    NSInteger index = [notification.object integerValue];
    //    NSIndexPath *IndexPath = [NSIndexPath indexPathForRow:index inSection:0];
    //    //滤镜
    //    [TiMenuPlistManager shareManager].filterModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:IndexPath.row WithPath:@"TiFilter.json"];
    //    [TiMenuPlistManager shareManager].filterModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.filterIndexPath.row WithPath:@"TiFilter.json"];
    //
    ////    [self.menuCollectionView reloadData];
    //    self.filterIndexPath = IndexPath;
    //    //储存滤镜选中位置
    //    [TiSetSDKParameters setSelectPosition:self.filterIndexPath.row forKey:TI_UIDCK_FILTER_POSITION];
    //
    //    [self.menuCollectionView performBatchUpdates:^{
    //        [self.menuCollectionView reloadData];
    //     } completion:^(BOOL finished) {
    //         //跳转指定位置
    //         [self.menuCollectionView scrollToItemAtIndexPath:self.filterIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    //     }];
    
}

- (void)resetOneKey:(NSNotification *)notification{
    NSIndexPath *IndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if (self.selectedIndexPath.row != 0) {
        if (self.clickOnCellBlock)
        {
            self.clickOnCellBlock(IndexPath.row);
        }
        //一键美颜
        [TiMenuPlistManager shareManager].onekeyModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:IndexPath.row WithPath:@"TiOneKeyBeauty"];
        [TiMenuPlistManager shareManager].onekeyModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"TiOneKeyBeauty"];
        
        //重置-储存一键美颜选中位置
        [TiSetSDKParameters setSelectPosition:IndexPath.row forKey:TI_UIDCK_ONEKEY_POSITION];
        
        if (self.selectedIndexPath) {
            [self.menuCollectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,IndexPath]];
        }else{
            [self.menuCollectionView reloadItemsAtIndexPaths:@[IndexPath]];
        }
        self.selectedIndexPath = IndexPath;
        //调整1
        [self.menuCollectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    }
    
    //获取缓存的滤镜位置
    //    self.filterIndexPath = [NSIndexPath indexPathForRow:[TiSetSDKParameters getSelectPositionForKey:TI_UIDCK_FILTER_POSITION] inSection:0];
    if (self.filterIndexPath.row != 0) {
        
        if (self.clickOnCellBlock)
        {
            self.clickOnCellBlock(IndexPath.row);
        }
        //滤镜
        [TiMenuPlistManager shareManager].filterModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:IndexPath.row WithPath:@"TiFilter"];
        [TiMenuPlistManager shareManager].filterModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.filterIndexPath.row WithPath:@"TiFilter"];
        [self.menuCollectionView reloadData];
        self.filterIndexPath = IndexPath;
        
    }else if (self.filterIndexPath.row == 0) {
        
        [TiMenuPlistManager shareManager].filterModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:self.filterIndexPath.row WithPath:@"TiFilter"];
        [self.menuCollectionView reloadData];
        
    }
    //储存滤镜选中位置
    [TiSetSDKParameters setSelectPosition:self.filterIndexPath.row forKey:TI_UIDCK_FILTER_POSITION];
    //跳转指定位置
    [self.menuCollectionView scrollToItemAtIndexPath:self.filterIndexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    //重置所有滤镜参数到默认参数
    for (int i = 0; i < 10; i ++) {
        [TiSetSDKParameters setFloatValue:FilterValue forKey:300+i];
    }
    
}

#pragma mark ---UICollectionViewDelegate---
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.mode.menuTag == 4) {
        is_updateFilterValue = false;
        //滤镜分类单独判断
        if (indexPath.row == 1 || indexPath.row == 9 || indexPath.row == 16 || indexPath.row == 26 || indexPath.row == 32 || indexPath.row == 37 || indexPath.row == 43 || indexPath.row == 48) {
            return;
        }else{
            if (self.filterIndexPath.row == indexPath.row) {
                return;
            }
            TIMenuMode *modX = [TiMenuPlistManager shareManager].filterModeArr[indexPath.row];
            if (self.clickOnCellBlock)
            {
                self.clickOnCellBlock(modX.menuTag);
            }
            [TiMenuPlistManager shareManager].filterModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiFilter"];
            if (self.filterIndexPath) {
                [TiMenuPlistManager shareManager].filterModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.filterIndexPath.row WithPath:@"TiFilter"];
                [collectionView reloadItemsAtIndexPaths:@[self.filterIndexPath,indexPath]];
            }else{
                for (int i = 0; i < [TiMenuPlistManager shareManager].filterModeArr.count; i++) {
                    if (i == indexPath.row) {
                        continue;
                    }else{
                        [TiMenuPlistManager shareManager].filterModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:i WithPath:@"TiFilter"];
                    }
                }
                [collectionView reloadData];
            }
            self.filterIndexPath = indexPath;
            //储存滤镜选中位置
            [TiSetSDKParameters setSelectPosition:self.filterIndexPath.row forKey:TI_UIDCK_FILTER_POSITION];
            //设置滤镜效果
            [[TiSDKManager shareManager] setBeautyFilter:modX.effectName Param:[TiSetSDKParameters getFloatValueForKey:(300+modX.menuTag)]];
            //储存滤镜参数
            [TiSetSDKParameters setFloatValue:[TiSetSDKParameters getFloatValueForKey:(300+modX.menuTag)] forKey:(300+modX.menuTag)];
            
            //            //汉字转拼音方法
            //            NSMutableString *pinyin = [modX.name mutableCopy];
            //            //转换拼音
            //            CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL,kCFStringTransformMandarinLatin, NO);
            //            NSString *pinyin_v = pinyin;
            //            //判断是否包含ǘ
            //            NSRange rangeV2 = [pinyin rangeOfString:@"ǘ"];
            //            if (rangeV2.location !=NSNotFound)
            //            {
            //                pinyin_v = [pinyin stringByReplacingOccurrencesOfString:@"ǘ" withString:@"v"];
            //            }
            //            //去除声调
            //            CFStringTransform((__bridge CFMutableStringRef)pinyin_v, NULL, kCFStringTransformStripCombiningMarks, NO);
            //            //去除所有空格
            //            NSString *noSpace = [pinyin_v stringByReplacingOccurrencesOfString:@" " withString:@""];
            //            [[TiSDKManager shareManager] setFilterEnum:[TiSetSDKParameters getTiFilterEnumForIndex:modX.menuTag] Param:[TiSetSDKParameters getFloatValueForKey:(300+modX.menuTag)]];
        }
    }else{
        switch (self.mode.menuTag) {
            case 5:
            {
                if (self.otherIndexPath.row==indexPath.row){
                    return;
                }
                [TiMenuPlistManager shareManager].rockModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiRock"];
                if (self.otherIndexPath) {
                    [TiMenuPlistManager shareManager].rockModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.otherIndexPath.row WithPath:@"TiRock"];
                    [collectionView reloadItemsAtIndexPaths:@[self.otherIndexPath,indexPath]];
                }else{
                    for (int i = 0; i < [TiMenuPlistManager shareManager].rockModeArr.count; i++) {
                        if (i == indexPath.row) {
                            continue;
                        }else{
                            [TiMenuPlistManager shareManager].rockModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:i WithPath:@"TiRock"];
                        }
                    }
                    [collectionView reloadData];
                }
                self.otherIndexPath = indexPath;
                [[TiSDKManager shareManager] setRockEnum:[TiSetSDKParameters setRockEnumByIndex:indexPath.row]];
            }
                break;
                
            case 10:
            {
                if (self.selectedIndexPath.row==indexPath.row){
                    return;
                }
                if (indexPath.row == 0 && [TiSetSDKParameters getFloatValueForKey:TI_UIDCK_ONEKEY_SLIDER] == 100) {
                    //关闭美颜重置功能
                    [TiUIManager shareManager].tiUIViewBoxView.viewModel.resetObject = @"关闭重置";
                }else{
                    //开启美颜重置功能
                    [TiUIManager shareManager].tiUIViewBoxView.viewModel.resetObject = @"重置美颜";
                }
                if (self.clickOnCellBlock)
                {
                    self.clickOnCellBlock(indexPath.row);
                }
                //
                //储存一键美颜选中位置
                [TiSetSDKParameters setSelectPosition:indexPath.row forKey:TI_UIDCK_ONEKEY_POSITION];
                //                TIMenuMode * mode = [[TIMenuMode alloc] init];
                //                mode = [TiMenuPlistManager shareManager].onekeyModeArr[indexPath.row];
                [TiMenuPlistManager shareManager].onekeyModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiOneKeyBeauty"];
                if (self.selectedIndexPath) {
                    [TiMenuPlistManager shareManager].onekeyModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"TiOneKeyBeauty"];
                    [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                }else{
                    for (int i = 0; i < [TiMenuPlistManager shareManager].onekeyModeArr.count; i++) {
                        if (i == indexPath.row) {
                            continue;
                        }else{
                            [TiMenuPlistManager shareManager].onekeyModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:i WithPath:@"TiOneKeyBeauty"];
                        }
                    }
                    [collectionView reloadData];
                }
                self.selectedIndexPath = indexPath;
                is_updateFilterValue = true;
                [TiSetSDKParameters setBeautySlider:[TiSetSDKParameters getFloatValueForKey:TI_UIDCK_ONEKEY_SLIDER] forKey:TI_UIDCK_ONEKEY_SLIDER withIndex:indexPath.row];
            }
                break;
                
            case 15:
            {
                if (self.otherIndexPath.row==indexPath.row){
                    return;
                }
                if (self.clickOnCellBlock)
                {
                    self.clickOnCellBlock(indexPath.row);
                }
                [TiMenuPlistManager shareManager].hairdressModArr = [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"TiHairdressDef"];
                if (self.otherIndexPath) {
                    [TiMenuPlistManager shareManager].hairdressModArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.otherIndexPath.row WithPath:@"TiHairdressDef"];
                    [collectionView reloadItemsAtIndexPaths:@[self.otherIndexPath,indexPath]];
                }else{
                    for (int i = 0; i < [TiMenuPlistManager shareManager].hairdressModArr.count; i++) {
                        if (i == indexPath.row) {
                            continue;
                        }else{
                            [TiMenuPlistManager shareManager].hairdressModArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:i WithPath:@"TiHairdressDef"];
                        }
                    }
                    [collectionView reloadData];
                }
                self.otherIndexPath = indexPath;
                TIMenuMode *hairMods = [TiMenuPlistManager shareManager].hairdressModArr[indexPath.row];
                [[TiSDKManager shareManager] setHairEnum:[TiSetSDKParameters getTiHairEnumForIndex:hairMods.menuTag] Param:[TiSetSDKParameters getFloatValueForKey:TI_UIDCK_HAIRDRESS_SLIDER]];
                
            }
                break;
                
            default:
                break;
        }
        
    }
    
}

- (void)setMode:(TIMenuMode *)mode{
    if (mode) {
        _mode = mode;
    }
}

- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
