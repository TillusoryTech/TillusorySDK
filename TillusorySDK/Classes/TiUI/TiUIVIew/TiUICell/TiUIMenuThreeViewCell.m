//
//  TiUIMenuThreeViewCell.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/6.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiUIMenuThreeViewCell.h"
#import "TiUIConfig.h"
#import "TiUISubMenuThreeViewCell.h"
#import "TiDownloadZipManager.h"
#import "TiUIGreenScreensView.h"
#import "TiSetSDKParameters.h"

@interface TiUIMenuThreeViewCell ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong) NSIndexPath *selectedIndexPath;
@property(nonatomic,strong) TiUIGreenScreensView *editGreenScreensView;
@property(nonatomic,strong) UIButton *backGreenBtn;//返回绿幕菜单

@end

static NSString *const TiUIMenuCollectionViewCellId = @"TiUIMainMenuTiUIMenuThreeViewCellId";

@implementation TiUIMenuThreeViewCell

- (UICollectionView *)menuCollectionView{
    if (!_menuCollectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.itemSize = CGSizeMake(TiUISubMenuThreeViewTiButtonWidth, TiUISubMenuThreeViewTiButtonHeight);
        // 设置最小行间距
        layout.minimumLineSpacing = 4;//最小行间距
        layout.minimumInteritemSpacing = 10;//同一列中间隔的cell最小间距
        _menuCollectionView =[[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _menuCollectionView.showsVerticalScrollIndicator = NO;
        _menuCollectionView.backgroundColor = [UIColor clearColor];
        _menuCollectionView.dataSource= self;
        _menuCollectionView.delegate = self;
        
        [_menuCollectionView registerClass:[TiUISubMenuThreeViewCell class] forCellWithReuseIdentifier:TiUIMenuCollectionViewCellId];
        
    }
    return _menuCollectionView;
}

- (TiUIGreenScreensView *)editGreenScreensView{
    if (!_editGreenScreensView) {
        _editGreenScreensView = [[TiUIGreenScreensView alloc] init];
        _editGreenScreensView.backgroundColor = [UIColor clearColor];
        [_editGreenScreensView setHidden:YES];
    }
    return _editGreenScreensView;
}

- (UIButton *)backGreenBtn{
    if (!_backGreenBtn) {
        _backGreenBtn = [[UIButton alloc] init];
        [_backGreenBtn setImage:[UIImage imageNamed:@"icon_back_white.png"] forState:UIControlStateNormal];
        [_backGreenBtn addTarget:self action:@selector(backGreen) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backGreenBtn;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.menuCollectionView];
        [self.menuCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(13.5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.left.equalTo(self.contentView.mas_left).offset(12.5);
            make.right.equalTo(self.contentView.mas_right).offset(-12.5);
        }];
        
        [self.contentView addSubview:self.editGreenScreensView];
        [self.editGreenScreensView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).offset(13.5);
            make.bottom.equalTo(self.mas_bottom).offset(-5);
            make.left.equalTo(self.contentView.mas_left).offset(12.5);
            make.right.equalTo(self.contentView.mas_right).offset(-12.5);
        }];
        
        [self.editGreenScreensView addSubview:self.backGreenBtn];
        [self.backGreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.editGreenScreensView).offset(19);
            make.bottom.equalTo(self.editGreenScreensView.mas_bottom).offset(-16);
            make.width.height.equalTo(@18);
        }];
        
        //注册通知——通知当前是否启用第三套手势（绿幕编辑）
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(isThirdGesture:) name:@"NotificationName_TiUIMenuThreeViewCell_isThirdGesture" object:nil];
        
    }
    return self;
}

#pragma mark ---UICollectionViewDataSource---
//设置每个section包含的item数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    switch (self.mode.menuTag) {
        case 2:
            return [TiMenuPlistManager shareManager].stickersModeArr.count;
            break;
        case 3:
            return [TiMenuPlistManager shareManager].giftModeArr.count;
            break;
        case 7:
            return [TiMenuPlistManager shareManager].watermarksModeArr.count;
            break;
        case 8:
            return [TiMenuPlistManager shareManager].masksModeArr.count;
            break;
        case 9:
            return [TiMenuPlistManager shareManager].greenscreensModeArr.count;
            break;
        case 11:
            return [TiMenuPlistManager shareManager].interactionsArr.count;
            break;
        case 14:
            return [TiMenuPlistManager shareManager].portraitsModArr.count;
            break;
        case 16:
            return [TiMenuPlistManager shareManager].gesturesModArr.count;
            break;
        default:
            return 0;
            break;
    }
    
}

//返回对应indexPath的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    TiUISubMenuThreeViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:TiUIMenuCollectionViewCellId forIndexPath:indexPath];
    TIMenuMode *subMod = nil;
    switch (self.mode.menuTag) {
        case 2:
        {
            subMod = [TiMenuPlistManager shareManager].stickersModeArr[indexPath.row];
            [cell setSubMod:subMod WithTag:2 WithIndex:indexPath.row];
        }
            break;
        case 3:
        {
            subMod = [TiMenuPlistManager shareManager].giftModeArr[indexPath.row];
            [cell setSubMod:subMod WithTag:3 WithIndex:indexPath.row];
        }
            break;
        case 7:
        {
            subMod = [TiMenuPlistManager shareManager].watermarksModeArr[indexPath.row];
            [cell setSubMod:subMod WithTag:7 WithIndex:indexPath.row];
        }
            break;
        case 8:
        {
            subMod = [TiMenuPlistManager shareManager].masksModeArr[indexPath.row];
            [cell setSubMod:subMod WithTag:8 WithIndex:indexPath.row];
        }
            break;
        case 9:
        {
            subMod = [TiMenuPlistManager shareManager].greenscreensModeArr[indexPath.row];
            [cell setSubMod:subMod WithTag:9 WithIndex:indexPath.row];
        }
            break;
        case 11:
        {
            subMod = [TiMenuPlistManager shareManager].interactionsArr[indexPath.row];
            [cell setSubMod:subMod WithTag:11 WithIndex:indexPath.row];
        }
            break;
        case 14:
        {
            subMod = [TiMenuPlistManager shareManager].portraitsModArr[indexPath.row];
            [cell setSubMod:subMod WithTag:14 WithIndex:indexPath.row];
        }
            break;
        case 16:
        {
            subMod = [TiMenuPlistManager shareManager].gesturesModArr[indexPath.row];
            [cell setSubMod:subMod WithTag:16 WithIndex:indexPath.row];
        }
            break;
        default:
            break;
    }
    if (subMod.selected)
    {
        self.selectedIndexPath = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    }
    return cell;
    
}

#pragma mark ---UICollectionViewDelegate---
//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.selectedIndexPath.row==indexPath.row) {
        return;//选中同一个cell不做处理
    }
    switch (self.mode.menuTag) {
        case 2:
        {
            TIMenuMode *mode = [TiMenuPlistManager shareManager].stickersModeArr[indexPath.row];
            //获取贴纸下载状态
            NSString *downloadStatus = [TiMenuPlistManager shareManager].stickerDownloadArr[indexPath.row];
            if ([downloadStatus  isEqual: @"DownloadComplete"]){
                
                [TiMenuPlistManager shareManager].stickersModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"stickers"];
                [TiMenuPlistManager shareManager].stickersModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"stickers"];
                if (self.selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.selectedIndexPath = indexPath;
                [[TiSDKManager shareManager] setStickerName:mode.name];
                
            }else if([downloadStatus  isEqual: @"NotDownloaded"]){
                // 开始下载
                [[TiMenuPlistManager shareManager].stickerDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"Downloading"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[TiDownloadZipManager shareManager] downloadSuccessedType:TI_DOWNLOAD_TYPE_Sticker MenuMode:mode completeBlock:^(BOOL successful) {
                    if (successful) {
                        // 开始下载
                        [[TiMenuPlistManager shareManager].stickerDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"DownloadComplete"];
                        [TiMenuPlistManager shareManager].stickersModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(true) forKey:@"downloaded" In:indexPath.row WithPath:@"stickers"];
                        [TiMenuPlistManager shareManager].stickersModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(indexPath.row) forKey:@"menuTag" In:indexPath.row WithPath:@"stickers"];
                    }else{
                        [TiMenuPlistManager shareManager].stickersModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(false) forKey:@"downloaded" In:indexPath.row WithPath:@"stickers"];
                    }
                    [weakSelf.menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
        }
            break;
        case 3:
        {
            TIMenuMode *mode = [TiMenuPlistManager shareManager].giftModeArr[indexPath.row];
            //获取礼物下载状态
            NSString *downloadStatus = [TiMenuPlistManager shareManager].giftDownloadArr[indexPath.row];
            if ([downloadStatus  isEqual: @"DownloadComplete"]){
                
                [TiMenuPlistManager shareManager].giftModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"gifts"];
                [TiMenuPlistManager shareManager].giftModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"gifts"];
                if (self.selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.selectedIndexPath = indexPath;
                [[TiSDKManager shareManager] setGift:mode.name];
                
            }else if([downloadStatus  isEqual: @"NotDownloaded"]){
                // 开始下载
                [[TiMenuPlistManager shareManager].giftDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"Downloading"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[TiDownloadZipManager shareManager] downloadSuccessedType:TI_DOWNLOAD_STATE_Gift MenuMode:mode completeBlock:^(BOOL successful) {
                    if (successful) {
                        // 开始下载
                        [[TiMenuPlistManager shareManager].giftDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"DownloadComplete"];
                        [TiMenuPlistManager shareManager].giftModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(true) forKey:@"downloaded" In:indexPath.row WithPath:@"gifts"];
                        [TiMenuPlistManager shareManager].giftModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(indexPath.row) forKey:@"menuTag" In:indexPath.row WithPath:@"gifts"];
                    }else{
                        [TiMenuPlistManager shareManager].giftModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(false) forKey:@"downloaded" In:indexPath.row WithPath:@"gifts"];
                    }
                    [weakSelf.menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
        }
            break;
        case 7:
        {
            [TiMenuPlistManager shareManager].watermarksModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(indexPath.row) forKey:@"menuTag" In:indexPath.row WithPath:@"watermarks"];
            
            TIMenuMode *mode = [TiMenuPlistManager shareManager].watermarksModeArr[indexPath.row];
            [TiMenuPlistManager shareManager].watermarksModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"watermarks"];
            [TiMenuPlistManager shareManager].watermarksModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"watermarks"];
            if (self.selectedIndexPath) {
                [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
            }else{
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }
            self.selectedIndexPath = indexPath;
            if (indexPath.row)
            {
                [[TiSDKManager shareManager] setWatermark:YES Left:(int)mode.x Top:(int)mode.y Ratio:(int)mode.ratio FileName:mode.name];
            }else{
                [[TiSDKManager shareManager] setWatermark:NO Left:0 Top:0 Ratio:0 FileName:@"watermark.png"];
            }
            
        }
            break;
        case 8:
        {
            TIMenuMode *mode = [TiMenuPlistManager shareManager].masksModeArr[indexPath.row];
            //获取面具下载状态
            NSString *downloadStatus = [TiMenuPlistManager shareManager].maskDownloadArr[indexPath.row];
            if ([downloadStatus  isEqual: @"DownloadComplete"]){
                
                [TiMenuPlistManager shareManager].masksModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"masks"];
                [TiMenuPlistManager shareManager].masksModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"masks"];
                if (self.selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.selectedIndexPath = indexPath;
                [[TiSDKManager shareManager] setMask:mode.name];
                
            }else if([downloadStatus  isEqual: @"NotDownloaded"]){
                
                // 开始下载
                [[TiMenuPlistManager shareManager].maskDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"Downloading"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[TiDownloadZipManager shareManager] downloadSuccessedType:TI_DOWNLOAD_STATE_Mask MenuMode:mode completeBlock:^(BOOL successful) {
                    if (successful) {
                        // 开始下载
                        [[TiMenuPlistManager shareManager].maskDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"DownloadComplete"];
                        [TiMenuPlistManager shareManager].masksModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(true) forKey:@"downloaded" In:indexPath.row WithPath:@"masks"];
                        [TiMenuPlistManager shareManager].masksModeArr = [[TiMenuPlistManager shareManager] modifyObject:@(indexPath.row) forKey:@"menuTag" In:indexPath.row WithPath:@"masks"];
                    }else{
                        [TiMenuPlistManager shareManager].masksModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(false) forKey:@"downloaded" In:indexPath.row WithPath:@"masks"];
                    }
                    [weakSelf.menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
        }
            break;
        case 9:
        {
            [TiMenuPlistManager shareManager].greenscreensModeArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(indexPath.row) forKey:@"menuTag" In:indexPath.row WithPath:@"greenscreens"];
            
            TIMenuMode *editMode = [TiMenuPlistManager shareManager].greenscreensModeArr[1];
            NSIndexPath *editPath = [NSIndexPath indexPathForRow:1 inSection:0];
            TiUISubMenuThreeViewCell *cell = (TiUISubMenuThreeViewCell *)[collectionView cellForItemAtIndexPath:editPath];
            if (indexPath.row == 1) {
                if ([cell isEdit]) {
                    [self.menuCollectionView setHidden:YES];
                    [[TiUIManager shareManager].tiUIViewBoxView setOtherTitleHidden:false withName:self.mode.name withCute:true];
                    [self.editGreenScreensView setHidden:NO];
                    [TiUIManager shareManager].tiUIViewBoxView.viewModel.sliderHidden = @0;
                    isswitch_greenEdit = true;
                }
                return;
            }
            if (indexPath.row == 0) {
                [cell setSubMod:editMode WithTag:9 isEnabled:NO];
            }else{
                [cell setSubMod:editMode WithTag:9 isEnabled:YES];
            }
            
            TIMenuMode *mode = [TiMenuPlistManager shareManager].greenscreensModeArr[indexPath.row];
            [TiMenuPlistManager shareManager].greenscreensModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"greenscreens"];
            [TiMenuPlistManager shareManager].greenscreensModeArr   =  [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"greenscreens"];
            if (self.selectedIndexPath) {
                [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
            }else{
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
            }
            self.selectedIndexPath = indexPath;
            NSString *name = mode.name;
            if ([mode.name containsString:@".png"]||[mode.name containsString:@".jpg"]) {
                //分割字符串
                NSArray *array = [name componentsSeparatedByString:@"."];
                name = array[0];
            }
            [[TiSDKManager shareManager] setGreenScreen:name Similarity:[TiSetSDKParameters getFloatValueForKey:TI_UIDCK_SIMILARITY_SLIDER] Smoothness:[TiSetSDKParameters getFloatValueForKey:TI_UIDCK_SMOOTH_SLIDER] Alpha:[TiSetSDKParameters getFloatValueForKey:TI_UIDCK_HYALINE_SLIDER]];
            
        }
            break;
        case 11:
        {
            TIMenuMode *mode = [TiMenuPlistManager shareManager].interactionsArr[indexPath.row];
            //获取互动贴纸下载状态
            NSString *downloadStatus = [TiMenuPlistManager shareManager].interactionDownloadArr[indexPath.row];
            if ([downloadStatus  isEqual: @"DownloadComplete"]){
                
                [TiMenuPlistManager shareManager].interactionsArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"interactions"];
                [TiMenuPlistManager shareManager].interactionsArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"interactions"];
                if (self.selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.selectedIndexPath = indexPath;
                [[TiSDKManager shareManager] setInteraction:mode.name];
                [[TiUIManager shareManager] setInteractionHintL:mode.hint];
                
            }else if([downloadStatus  isEqual: @"NotDownloaded"]){
                
                // 开始下载
                [[TiMenuPlistManager shareManager].interactionDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"Downloading"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[TiDownloadZipManager shareManager] downloadSuccessedType:TI_DOWNLOAD_STATE_Interactions MenuMode:mode completeBlock:^(BOOL successful) {
                    if (successful) {
                        // 开始下载
                        [[TiMenuPlistManager shareManager].interactionDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"DownloadComplete"];
                        [TiMenuPlistManager shareManager].interactionsArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(true) forKey:@"downloaded" In:indexPath.row WithPath:@"interactions"];
                        [TiMenuPlistManager shareManager].interactionsArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(indexPath.row) forKey:@"menuTag" In:indexPath.row WithPath:@"interactions"];
                    }else{
                        [TiMenuPlistManager shareManager].interactionsArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(false) forKey:@"downloaded" In:indexPath.row WithPath:@"interactions"];
                    }
                    [weakSelf.menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
            
        }
            break;
        case 14:
        {
            TIMenuMode *mode = [TiMenuPlistManager shareManager].portraitsModArr[indexPath.row];
            //获取人像抠图下载状态
            NSString *downloadStatus = [TiMenuPlistManager shareManager].portraitDownloadArr[indexPath.row];
            if ([downloadStatus  isEqual: @"DownloadComplete"]){
                
                [TiMenuPlistManager shareManager].portraitsModArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"portraits"];
                [TiMenuPlistManager shareManager].portraitsModArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"portraits"];
                if (self.selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.selectedIndexPath = indexPath;
                [[TiSDKManager shareManager] setPortrait:mode.name];
                
            }else if([downloadStatus  isEqual: @"NotDownloaded"]){
                
                // 开始下载
                [[TiMenuPlistManager shareManager].portraitDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"Downloading"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[TiDownloadZipManager shareManager] downloadSuccessedType:TI_DOWNLOAD_STATE_Portraits MenuMode:mode completeBlock:^(BOOL successful) {
                    if (successful) {
                        // 开始下载
                        [[TiMenuPlistManager shareManager].portraitDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"DownloadComplete"];
                        [TiMenuPlistManager shareManager].portraitsModArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(true) forKey:@"downloaded" In:indexPath.row WithPath:@"portraits"];
                        [TiMenuPlistManager shareManager].portraitsModArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(indexPath.row) forKey:@"menuTag" In:indexPath.row WithPath:@"portraits"];
                    }else{
                        [TiMenuPlistManager shareManager].portraitsModArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(false) forKey:@"downloaded" In:indexPath.row WithPath:@"portraits"];
                    }
                    [weakSelf.menuCollectionView reloadItemsAtIndexPaths:@[indexPath]];
                }];
                
            }
        }
            break;
        case 16:
        {
            TIMenuMode *mode = [TiMenuPlistManager shareManager].gesturesModArr[indexPath.row];
            //获取手势抠图下载状态
            NSString *downloadStatus = [TiMenuPlistManager shareManager].gestureDownloadArr[indexPath.row];
            if ([downloadStatus  isEqual: @"DownloadComplete"]){
                
                [TiMenuPlistManager shareManager].gesturesModArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(YES) forKey:@"selected" In:indexPath.row WithPath:@"gestures"];
                [TiMenuPlistManager shareManager].gesturesModArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(NO) forKey:@"selected" In:self.selectedIndexPath.row WithPath:@"gestures"];
                if (self.selectedIndexPath) {
                    [collectionView reloadItemsAtIndexPaths:@[self.selectedIndexPath,indexPath]];
                }else{
                    [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                }
                self.selectedIndexPath = indexPath;
                [[TiSDKManager shareManager] setGesture:mode.name];
                [[TiUIManager shareManager] setInteractionHintL:mode.hint];
                
            }else if([downloadStatus  isEqual: @"NotDownloaded"]){
                
                // 开始下载
                [[TiMenuPlistManager shareManager].gestureDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"Downloading"];
                [collectionView reloadItemsAtIndexPaths:@[indexPath]];
                WeakSelf;
                [[TiDownloadZipManager shareManager] downloadSuccessedType:TI_DOWNLOAD_STATE_Gestures MenuMode:mode completeBlock:^(BOOL successful) {
                    if (successful) {
                        // 开始下载
                        [[TiMenuPlistManager shareManager].gestureDownloadArr replaceObjectAtIndex:indexPath.row withObject:@"DownloadComplete"];
                        [TiMenuPlistManager shareManager].gesturesModArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(true) forKey:@"downloaded" In:indexPath.row WithPath:@"gestures"];
                        [TiMenuPlistManager shareManager].gesturesModArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(indexPath.row) forKey:@"menuTag" In:indexPath.row WithPath:@"gestures"];
                    }else{
                        [TiMenuPlistManager shareManager].gesturesModArr  =  [[TiMenuPlistManager shareManager] modifyObject:@(false) forKey:@"downloaded" In:indexPath.row WithPath:@"gestures"];
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

- (void)isThirdGesture:(NSNotification *)notification{
    
    NSNumber *isThirdN = notification.object;
    BOOL isThird =  [isThirdN boolValue];
    if (isThird) {
        [self backGreen];
    }
    
}

- (void)backGreen{
    [self.menuCollectionView setHidden:NO];
    [[TiUIManager shareManager].tiUIViewBoxView setOtherTitleHidden:true withName:@"" withCute:true];
    [self.editGreenScreensView setHidden:YES];
    [TiUIManager shareManager].tiUIViewBoxView.viewModel.sliderHidden = @1;
    isswitch_greenEdit = false;
}

- (void)setMode:(TIMenuMode *)mode{
    if (mode) {
        _mode = mode;
    }
}

- (void)dealloc{
    // 移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
