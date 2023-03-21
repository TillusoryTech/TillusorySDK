//
//  TiUIMakeUpView.m
//  TiFancy
//
//  Created by MBP DA1003 on 2020/8/1.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiUIMakeUpView.h"
#import "TiUIConfig.h"
#import "TiUIMakeUpViewCell.h"
#import "TiDownloadZipManager.h"
#import "TiSetSDKParameters.h"

bool Default_is_Null = true;
bool makeUpResetComplete = false;

static NSString *const TiUIMenuCollectionViewCellId = @"TiUIMeiZhuangViewCellId";
@interface TiUIMakeUpView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) NSIndexPath *selectedIndexPath;
// 非当前页面选中状态数组--暂用于贴纸功能
@property(nonatomic,strong) NSDictionary *selectedStickerIndexDic;
@property(nonatomic,strong) NSNumber *selectedID;// 非当前页面选中状态的id
// 添加退出手势的View
@property(nonatomic, strong) UIView *exitTapView;
@property(nonatomic, strong) UIWindow *window;

@end

@implementation TiUIMakeUpView

- (UIView *)exitTapView{
    if (!_exitTapView) {
        _exitTapView = [[UIView alloc]initWithFrame:CGRectMake(0 , 0, TiUIScreenWidth,TiUIScreenHeight - TiUIViewBoxTotalHeight)];
        _exitTapView.hidden = NO;
        _exitTapView.userInteractionEnabled = YES;
        [_exitTapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onExitTap1:)]];
    }
    return _exitTapView;
}

- (UIWindow *)window{
    if (!_window) {
        _window = [self lastWindow];
    }
    return _window;
}

// MARK: --退出手势相关--
- (void)onExitTap1:(UITapGestureRecognizer *)recognizer {
    isswitch_makeup = false;
    [self setHiddenAnimation:YES];
}

- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]init];
        [_backBtn setImage:[UIImage imageNamed:@"icon_back.png"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backParentMenu:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (UIButton *)defaultBtn{
    if (!_defaultBtn) {
        _defaultBtn = [[UIButton alloc]init];
        [_defaultBtn addTarget:self action:@selector(defaultselected:) forControlEvents:UIControlEventTouchUpInside];
        [_defaultBtn setImage:[UIImage imageNamed:@"meizhuang_wu_normal_white.png"] forState:UIControlStateNormal];
        [_defaultBtn setImage:[UIImage imageNamed:@"meizhuang_wu_selected.png"] forState:UIControlStateSelected];
        // 判断默认按钮状态
        if (Default_is_Null) {
            [_defaultBtn setSelected:true];
        }else{
            [_defaultBtn setSelected:false];
        }
    }
    return _defaultBtn;
}

- (UILabel *)defaultLabel{
    if (!_defaultLabel) {
        _defaultLabel = [[UILabel alloc]init];
        if (Default_is_Null) {
            [_defaultLabel setTextColor:TiColor(88.0, 221.0, 221.0, 1.0)];
        }else{
            [_defaultLabel setTextColor:UIColor.whiteColor];
        }
        _defaultLabel.textAlignment = NSTextAlignmentCenter;
        _defaultLabel.font = TiFontRegular(10);
        _defaultLabel.text = NSLocalizedString(@"无", nil);
    }
    return _defaultLabel;
}

- (void)defaultselected:(UIButton *)button{
    if (self.defaultBtn.isSelected) {
        return;
    }
    [self.defaultBtn setSelected:true];
    [self.defaultLabel setTextColor:TiColor(88.0, 221.0, 221.0, 1.0)];
    WeakSelf
    if (self.clickOnCellBlock)
    {
        //                    拼接标示符 1 腮红、2睫毛、3眉毛、4眼影、5眼线
        //                    例示 1000 -> 腮红.自然 1000 腮红柔和。2001 睫毛剑眉
        self.clickOnCellBlock(self.mode.menuTag * 1000 + 999);
    }
    
    switch (self.mode.menuTag) {
        case 1:{// 腮红
            [TiMenuPlistManager shareManager].blusherModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"makeups" Withtype:@"blusher"];
            self.selectedIndexPath = nil;
            // 设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:NSLocalizedString(@"无", nil) forKey:@"cheekRed_default"];
            [weakSelf.menuCollectionView reloadData];
        }
            break;
        case 2:{//眉毛
            [TiMenuPlistManager shareManager].eyebrowsModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"makeups" Withtype:@"eyebrow"];
            self.selectedIndexPath = nil;
            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:NSLocalizedString(@"无", nil) forKey:@"eyebrows_default"];
            [weakSelf.menuCollectionView reloadData];
            [[TiSDKManager shareManager] setEyeBrow:@"" Param:0];
            
        }
            break;
        case 3:{//眼影
            [TiMenuPlistManager shareManager].eyeshadowModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"makeups" Withtype:@"eyeshadow"];
            self.selectedIndexPath = nil;
            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:NSLocalizedString(@"无", nil) forKey:@"eyeshadow_default"];
            [weakSelf.menuCollectionView reloadData];
            [[TiSDKManager shareManager] setEyeShadow:@"" Param:0];
            
        }
            break;
        case 4:{//唇彩
            [TiMenuPlistManager shareManager].lipglossModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"makeups" Withtype:@"lipgloss"];
            self.selectedIndexPath = nil;
            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:NSLocalizedString(@"无", nil) forKey:@"lipgloss_default"];
            [weakSelf.menuCollectionView reloadData];
            [[TiSDKManager shareManager] setLipGLoss:@"" Param:0];
            
        }
            break;
        default:
            self.selectedID = 0;
            break;
    }
    [TiUIManager shareManager].tiUIViewBoxView.viewModel.sliderHidden = @1;
}

- (UICollectionView *)menuCollectionView{
    if (!_menuCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(TiUISubMenuMakeUpViewTiButtonWidth, TiUISubMenuMakeUpViewTiButtonHeight);
        // 设置最小行间距
        layout.minimumLineSpacing = 0;
        _menuCollectionView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _menuCollectionView.showsHorizontalScrollIndicator = NO;
        _menuCollectionView.dataSource= self;
        _menuCollectionView.delegate = self;
        [_menuCollectionView registerClass:[TiUIMakeUpViewCell class] forCellWithReuseIdentifier:TiUIMenuCollectionViewCellId];
        _menuCollectionView.backgroundColor = [UIColor clearColor];
        
    }
    return _menuCollectionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TiColors(45.0, 0.6);
        self.alpha = 0;
        [self addSubview:self.backBtn];
        [self addSubview:self.menuCollectionView];
        [self addSubview:self.defaultBtn];
        [self addSubview:self.defaultLabel];
        CGFloat safeBottomHeigh = 0.0f;
        if (@available(iOS 11.0, *)) {
            safeBottomHeigh = getSafeBottomHeight/2;
        }
        [self.menuCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:78]);
            make.height.mas_equalTo(TiUISubMenuMakeUpViewTiButtonHeight);
            make.right.equalTo(self);
            make.top.equalTo(self).offset(60-TiUIMenuViewHeight);
        }];
        [self.defaultBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.menuCollectionView).offset([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:13]);
            make.left.equalTo(self.mas_left).offset([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:30]);
            make.width.height.mas_equalTo([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:24]);
        }];
        [self.defaultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.defaultBtn);
            make.top.equalTo(self.menuCollectionView).offset([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:60]);
            make.width.equalTo(@24);
            make.height.equalTo(@12);
        }];
        [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.defaultBtn);
            if (@available(iOS 11.0, *)) {
                make.bottom.equalTo(self.mas_bottom).offset(-[[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:10]-getSafeBottomHeight);
            } else {
                // Fallback on earlier versions
            }
            make.width.height.mas_equalTo([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:20]);
        }];
        
        //注册通知——通知当前是否启用第二套手势（美妆）
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isTwoGesture:) name:@"NotificationName_TIUIMakeUp_isTwoGesture" object:nil];
        
    }
    
    return self;
}

- (void)isTwoGesture:(NSNotification *)notification{
    
    NSNumber *isTwoN = notification.object;
    BOOL isTwo =  [isTwoN boolValue];
    if (isTwo) {
        [self setHiddenAnimation:YES];
    }
    
}

//获取到当前所在的视图
- (UIViewController *)presentingVC{
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal){
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows){
            if (tmpWin.windowLevel == UIWindowLevelNormal){
                window = tmpWin;
                break;
            }
        }
    }
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [(UITabBarController *)result selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

- (UIWindow *)lastWindow
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    return [UIApplication sharedApplication].keyWindow;
}

#pragma mark ---UICollectionViewDataSource---
//设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    switch (self.mode.menuTag) {
        case 1:
            return [TiMenuPlistManager shareManager].blusherModArr.count;
            break;
        case 2:
            return [TiMenuPlistManager shareManager].eyebrowsModArr.count;
            break;
        case 3:
            return [TiMenuPlistManager shareManager].eyeshadowModArr.count;
            break;
        case 4:
            return [TiMenuPlistManager shareManager].lipglossModArr.count;
            break;
        default:
            return 0;
            break;
    }
    
}

//返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TiUIMakeUpViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TiUIMenuCollectionViewCellId forIndexPath:indexPath];
    
    [cell setCellTypeBorderIsShow:indexPath.row!=0];
    TIMenuMode * subMod = nil;
    switch (self.mode.menuTag) {
        case 1:{
            subMod = [TiMenuPlistManager shareManager].blusherModArr[indexPath.row];
            [cell setSubMod:subMod WithTag:12 WithIndex:indexPath.row];
        }
            break;
        case 2:{
            subMod = [TiMenuPlistManager shareManager].eyebrowsModArr[indexPath.row];
            [cell setSubMod:subMod WithTag:12 WithIndex:indexPath.row];
        }
            break;
        case 3:{
            subMod = [TiMenuPlistManager shareManager].eyeshadowModArr[indexPath.row];
            [cell setSubMod:subMod WithTag:12 WithIndex:indexPath.row];
        }
            break;
        case 4:{
            subMod = [TiMenuPlistManager shareManager].lipglossModArr[indexPath.row];
            [cell setSubMod:subMod WithTag:12 WithIndex:indexPath.row];
        }
            break;
        default:
            break;
    }
    
    if (subMod.selected)
    {
        self.selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
        if (self.clickOnCellBlock)
        {
            //        拼接标示符 1 腮红  2睫毛。3眉毛
            //       例示 1001 -> 腮红.自然 1002 腮红柔和。2002 睫毛剑眉
            NSUInteger tag = self.mode.menuTag * 1000 + self.selectedIndexPath.row;
            self.clickOnCellBlock(tag);
        }
    }
    
    return cell;
    
}

#pragma mark ---UICollectionViewDelegate---
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //判断默认按钮状态
    if(self.selectedIndexPath.row==indexPath.row && self.selectedIndexPath!=nil && !self.defaultBtn.isSelected) {
        return;//选中同一个cell不做处理
    }
    Default_is_Null = false;
    makeUpResetComplete = false;
    switch (self.mode.menuTag) {
        case 1:
        {
            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:NSLocalizedString(@"腮红", nil) forKey:@"cheekRed_default"];
            TIMenuMode *mode = [TiMenuPlistManager shareManager].blusherModArr[indexPath.row];
            //获取贴纸下载状态
            NSString *downloadStatus = [TiMenuPlistManager shareManager].blusherDownloadArr[indexPath.row];
            if ([downloadStatus  isEqual: @"DownloadComplete"]){
                
                [self.defaultBtn setSelected:false];
                [self.defaultLabel setTextColor:[UIColor whiteColor]];
                if (self.selectedIndexPath) {
                    [TiMenuPlistManager shareManager].blusherModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"makeups" Withtype:@"blusher"];
                }
                [TiMenuPlistManager shareManager].blusherModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"makeups" Withtype:@"blusher"];
                
                if (self.selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.selectedIndexPath = indexPath;
                if (self.clickOnCellBlock)
                {
                    //                    拼接标示符 1 腮红、2睫毛、3眉毛、4眼影、5眼线
                    //                    例示 1000 -> 腮红.自然 1000 腮红柔和。2001 睫毛剑眉
                    NSUInteger tag = self.mode.menuTag * 1000 + indexPath.row;
                    self.clickOnCellBlock(tag);
                }
            }else if([downloadStatus  isEqual: @"NotDownloaded"]){
                
                // 开始下载
                [[TiMenuPlistManager shareManager].blusherDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"Downloading"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[TiDownloadZipManager shareManager] downloadSuccessedType:TI_DOWNLOAD_STATE_Makeup_blusher MenuMode:mode completeBlock:^(BOOL successful) {
                    if (successful) {
                        // 开始下载
                        [[TiMenuPlistManager shareManager].blusherDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"DownloadComplete"];
                        [TiMenuPlistManager shareManager].blusherModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(YES) forKey:@"downloaded" In:indexPath.row WithPath:@"makeups" Withtype:@"blusher"];
                        [TiMenuPlistManager shareManager].blusherModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(indexPath.row) forKey:@"menuTag" In:indexPath.row WithPath:@"makeups" Withtype:@"blusher"];
                    }else{
                        [TiMenuPlistManager shareManager].blusherModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(NO) forKey:@"downloaded" In:indexPath.row WithPath:@"makeups" Withtype:@"blusher"];
                    }
                    [weakSelf.menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
        }
            break;
        case 2:{
            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:NSLocalizedString(@"眉毛", nil) forKey:@"eyebrows_default"];
            TIMenuMode *mode = [TiMenuPlistManager shareManager].eyebrowsModArr[indexPath.row];
            //获取贴纸下载状态
            NSString *downloadStatus = [TiMenuPlistManager shareManager].eyebrowsDownloadArr[indexPath.row];
            if ([downloadStatus  isEqual: @"DownloadComplete"]){
                
                [self.defaultBtn setSelected:false];
                [self.defaultLabel setTextColor:[UIColor whiteColor]];
                if (self.selectedIndexPath) {
                    [TiMenuPlistManager shareManager].eyebrowsModArr = [[TiMenuPlistManager shareManager] modifyMakeUp:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"makeups" Withtype:@"eyebrow"];
                }
                [TiMenuPlistManager shareManager].eyebrowsModArr = [[TiMenuPlistManager shareManager] modifyMakeUp:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"makeups" Withtype:@"eyebrow"];
                
                if (self.selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                
                self.selectedIndexPath = indexPath;
                if (self.clickOnCellBlock)
                {
                    NSUInteger tag = self.mode.menuTag * 1000 + indexPath.row;
                    self.clickOnCellBlock(tag);
                }
            }else if([downloadStatus  isEqual: @"NotDownloaded"]){
                
                // 开始下载
                [[TiMenuPlistManager shareManager].eyebrowsDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"Downloading"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[TiDownloadZipManager shareManager] downloadSuccessedType:TI_DOWNLOAD_STATE_Makeup_eyebrow MenuMode:mode completeBlock:^(BOOL successful) {
                    if (successful) {
                        // 开始下载
                        [[TiMenuPlistManager shareManager].eyebrowsDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"DownloadComplete"];
                        [TiMenuPlistManager shareManager].eyebrowsModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(YES) forKey:@"downloaded" In:indexPath.row WithPath:@"makeups" Withtype:@"eyebrow"];
                        [TiMenuPlistManager shareManager].eyebrowsModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(indexPath.row) forKey:@"menuTag" In:indexPath.row WithPath:@"makeups" Withtype:@"eyebrow"];
                    }else{
                        [TiMenuPlistManager shareManager].eyebrowsModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(NO) forKey:@"downloaded" In:indexPath.row WithPath:@"makeups" Withtype:@"eyebrow"];
                    }
                    [weakSelf.menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
        }
            break;
        case 3:{
            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:NSLocalizedString(@"眼影", nil) forKey:@"eyeshadow_default"];
            TIMenuMode *mode = [TiMenuPlistManager shareManager].eyeshadowModArr[indexPath.row];
            //获取贴纸下载状态
            NSString *downloadStatus = [TiMenuPlistManager shareManager].eyeshadowDownloadArr[indexPath.row];
            if ([downloadStatus  isEqual: @"DownloadComplete"]){
                
                [self.defaultBtn setSelected:false];
                [self.defaultLabel setTextColor:[UIColor whiteColor]];
                if (self.selectedIndexPath!=nil) {
                    [TiMenuPlistManager shareManager].eyeshadowModArr = [[TiMenuPlistManager shareManager] modifyMakeUp:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"makeups" Withtype:@"eyeshadow"];
                }
                [TiMenuPlistManager shareManager].eyeshadowModArr = [[TiMenuPlistManager shareManager] modifyMakeUp:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"makeups" Withtype:@"eyeshadow"];
                
                if (self.selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.selectedIndexPath = indexPath;
                if (self.clickOnCellBlock)
                {
                    NSUInteger tag = self.mode.menuTag * 1000 + indexPath.row;
                    self.clickOnCellBlock(tag);
                }
            }else if([downloadStatus  isEqual: @"NotDownloaded"]){
                
                // 开始下载
                [[TiMenuPlistManager shareManager].eyeshadowDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"Downloading"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[TiDownloadZipManager shareManager] downloadSuccessedType:TI_DOWNLOAD_STATE_Makeup_eyeshadow MenuMode:mode completeBlock:^(BOOL successful) {
                    if (successful) {
                        // 开始下载
                        [[TiMenuPlistManager shareManager].eyeshadowDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"DownloadComplete"];
                        [TiMenuPlistManager shareManager].eyeshadowModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(YES) forKey:@"downloaded" In:indexPath.row WithPath:@"makeups" Withtype:@"eyeshadow"];
                        [TiMenuPlistManager shareManager].eyeshadowModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(indexPath.row) forKey:@"menuTag" In:indexPath.row WithPath:@"makeups" Withtype:@"eyeshadow"];
                    }else{
                        [TiMenuPlistManager shareManager].eyeshadowModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(NO) forKey:@"downloaded" In:indexPath.row WithPath:@"makeups" Withtype:@"eyeshadow"];
                    }
                    [weakSelf.menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
            }
        }
            break;
        case 4:{
            //设置默认按钮状态
            [[NSUserDefaults standardUserDefaults] setObject:NSLocalizedString(@"唇彩", nil) forKey:@"lipgloss_default"];
            TIMenuMode *mode = [TiMenuPlistManager shareManager].lipglossModArr[indexPath.row];
            //获取唇彩下载状态
            NSString *downloadStatus = [TiMenuPlistManager shareManager].lipglossDownloadArr[indexPath.row];
            if ([downloadStatus  isEqual: @"DownloadComplete"]){
                
                [self.defaultBtn setSelected:false];
                [self.defaultLabel setTextColor:[UIColor whiteColor]];
                if (self.selectedIndexPath!=nil) {
                    [TiMenuPlistManager shareManager].lipglossModArr = [[TiMenuPlistManager shareManager] modifyMakeUp:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"makeups" Withtype:@"lipgloss"];
                }
                [TiMenuPlistManager shareManager].lipglossModArr = [[TiMenuPlistManager shareManager] modifyMakeUp:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"makeups" Withtype:@"lipgloss"];
                
                if (self.selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.selectedIndexPath = indexPath;
                if (self.clickOnCellBlock)
                {
                    NSUInteger tag = self.mode.menuTag * 1000 + indexPath.row;
                    self.clickOnCellBlock(tag);
                }
            }else if([downloadStatus  isEqual: @"NotDownloaded"]){
                
                // 开始下载
                [[TiMenuPlistManager shareManager].lipglossDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"Downloading"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[TiDownloadZipManager shareManager] downloadSuccessedType:TI_DOWNLOAD_STATE_Makeup_lipgloss MenuMode:mode completeBlock:^(BOOL successful) {
                    if (successful) {
                        // 开始下载
                        [[TiMenuPlistManager shareManager].lipglossDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"DownloadComplete"];
                        [TiMenuPlistManager shareManager].lipglossModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(YES) forKey:@"downloaded" In:indexPath.row WithPath:@"makeups" Withtype:@"lipgloss"];
                        [TiMenuPlistManager shareManager].lipglossModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(indexPath.row) forKey:@"menuTag" In:indexPath.row WithPath:@"makeups" Withtype:@"lipgloss"];
                    }else{
                        [TiMenuPlistManager shareManager].lipglossModArr  =  [[TiMenuPlistManager shareManager] modifyMakeUp:@(NO) forKey:@"downloaded" In:indexPath.row WithPath:@"makeups" Withtype:@"lipgloss"];
                    }
                    [weakSelf.menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
            }
        }
            break;
            
        default:
            break;
    }
}


- (void)setMode:(TIMenuMode *)mode{
    if (mode) {
        _mode = mode;
        self.selectedIndexPath = nil;
        
        switch (mode.menuTag) {
            case 1:{
                for (int i = 0; i<[TiMenuPlistManager shareManager].blusherModArr.count; i++) {
                    TIMenuMode * subMod = [TiMenuPlistManager shareManager].blusherModArr[i];
                    if (subMod.selected) {
                        self.selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.menuCollectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                        
                        if (self.clickOnCellBlock&&i)
                        {
                            NSUInteger tag = self.mode.menuTag * 1000 + i;
                            self.clickOnCellBlock(tag);
                        }
                    }
                }
            }
                break;
                //            case 2:{
                //                for (int i = 0; i<[TiMenuPlistManager shareManager].eyelashModArr.count; i++) {
                //                    TIMenuMode * subMod = [TiMenuPlistManager shareManager].eyelashModArr[i];
                //                    if (subMod.selected) {
                //                        self.selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                //                        [self.menuCollectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                //                        if (self.clickOnCellBlock&&i)
                //                        {
                //                            NSUInteger tag = self.mode.menuTag * 1000 + i;
                //                                self.clickOnCellBlock(tag);
                //                        }
                //                    }
                //                }
                //            }
                //                break;
            case 2:{
                for (int i = 0; i<[TiMenuPlistManager shareManager].eyebrowsModArr.count; i++) {
                    TIMenuMode * subMod = [TiMenuPlistManager shareManager].eyebrowsModArr[i];
                    if (subMod.selected) {
                        self.selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.menuCollectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                        if (self.clickOnCellBlock&&i)
                        {
                            NSUInteger tag = self.mode.menuTag * 1000 + i;
                            self.clickOnCellBlock(tag);
                        }
                    }
                }
            }
                break;
            case 3:{
                for (int i = 0; i<[TiMenuPlistManager shareManager].eyeshadowModArr.count; i++) {
                    TIMenuMode * subMod = [TiMenuPlistManager shareManager].eyeshadowModArr[i];
                    if (subMod.selected) {
                        self.selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.menuCollectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                        if (self.clickOnCellBlock&&i)
                        {
                            NSUInteger tag = self.mode.menuTag * 1000 + i;
                            self.clickOnCellBlock(tag);
                        }
                    }
                }
            }
                break;
            case 4:{
                for (int i = 0; i<[TiMenuPlistManager shareManager].lipglossModArr.count; i++) {
                    TIMenuMode * subMod = [TiMenuPlistManager shareManager].lipglossModArr[i];
                    if (subMod.selected) {
                        self.selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                        [self.menuCollectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                        if (self.clickOnCellBlock&&i)
                        {
                            NSUInteger tag = self.mode.menuTag * 1000 + i;
                            self.clickOnCellBlock(tag);
                        }
                    }
                }
            }
                break;
                //            case 5:{
                //                for (int i = 0; i<[TiMenuPlistManager shareManager].eyeLineModArr.count; i++) {
                //                    TIMenuMode * subMod = [TiMenuPlistManager shareManager].eyeLineModArr[i];
                //                    if (subMod.selected) {
                //                                           self.selectedIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                //                                           [self.menuCollectionView scrollToItemAtIndexPath:self.selectedIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
                //                        if (self.clickOnCellBlock&&i)
                //                        {
                //                            NSUInteger tag = self.mode.menuTag * 1000 + i;
                //                                self.clickOnCellBlock(tag);
                //                        }
                //                    }
                //                }
                //            }
                //                break;
            default:
                break;
        }
        
    }
    
}

- (void)backParentMenu:(TiButton *)sender{
    [self setHiddenAnimation:YES];
}

- (void)setHiddenAnimation:(BOOL)hidden{
    
    [self.exitTapView setHidden:hidden];
    [self.exitTapView removeFromSuperview];
    BOOL isSubView = [self.exitTapView isDescendantOfView:self.window];
    if (!isSubView) {
        [self.window addSubview:self.exitTapView];
    }
    self.alpha = !hidden;
    if (hidden) {
        isswitch_makeup = false;
        if (self.backBlock)
        {
            self.backBlock(YES);
        }
    }
    if (hidden) {
        if (self.makeupShowDisappearBlock)
        {
            //隐藏滑动条
            self.makeupShowDisappearBlock(YES);
        }
    }
    [self.menuCollectionView reloadData];
}

- (void)dealloc{
    //移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
