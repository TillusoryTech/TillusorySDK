//
//  TiUISubMenuThreeViewCell.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/6.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiUISubMenuThreeViewCell.h"
#import "TiUITool.h"

@interface TiUISubMenuThreeViewCell ()

@property(nonatomic ,strong)TiButton *cellButton;

@end

@implementation TiUISubMenuThreeViewCell


- (TiButton *)cellButton{
    if (!_cellButton) {
        _cellButton = [[TiButton alloc] initWithScaling:1.0 withMakeUp:NO];
        _cellButton.userInteractionEnabled = NO;
    }
    return _cellButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cellButton];
        [self.cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self);
        }];
        
    }
    return self;
}

//判断是否可编辑
- (BOOL)isEdit{
    if (self.cellButton.isEnabled) {
        return YES;
    }else{
        return NO;
    }
}

//编辑绿幕
- (void)setSubMod:(TIMenuMode *)subMod WithTag:(NSInteger)tag isEnabled:(BOOL)isEnabled{
    
    if (subMod.menuTag == 1 && tag == 9) {
        [self.cellButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(17, 17, 17, 17));
        }];
        [self.cellButton setImage:[UIImage imageNamed:@"icon_lvmu_bianji.png"] forState:UIControlStateNormal];
        [self.cellButton setImage:[UIImage imageNamed:@"icon_lvmu_bianji_disabled.png"] forState:UIControlStateDisabled];
        [self endAnimation];
        [self.cellButton setDownloaded:YES];
        [self.cellButton setEnabled:isEnabled];
    }
    
}

- (void)setSubMod:(TIMenuMode *)subMod WithTag:(NSInteger)tag WithIndex:(NSInteger)index{
    if (subMod) {
        _subMod = subMod;
        if (subMod.menuTag == 1 && tag == 9) {
            //默认绿幕编辑功能不可选
            [self setSubMod:subMod WithTag:tag isEnabled:NO];
        }else{
            if (subMod.menuTag) {
                [self.cellButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.left.right.equalTo(self);
                }];
                [self.cellButton setBorderWidth:0.0 BorderColor:[UIColor clearColor] forState:UIControlStateNormal];
                [self.cellButton setBorderWidth:1.0 BorderColor:TiColor(88.0,221.0,221.0,1.0) forState:UIControlStateSelected];
                WeakSelf;
                NSString *iconUrl = @"";
                NSString *folder = @"";
                //获取下载状态
                NSString *downloadStatus;
                switch (tag) {
                    case 2:
                        iconUrl = [TiSDK shareInstance].getStickerUrl;
                        folder = @"sticker_icon";
                        downloadStatus = [TiMenuPlistManager shareManager].stickerDownloadArr[index];
                        break;
                    case 3:
                        iconUrl = [TiSDK shareInstance].getGiftUrl;
                        folder = @"gift_icon";
                        downloadStatus = [TiMenuPlistManager shareManager].giftDownloadArr[index];
                        break;
                    case 7:
                        iconUrl = [TiSDK shareInstance].getWatermarkUrl;
                        folder = @"watermark";
                        downloadStatus = @"DownloadComplete";
                        break;
                    case 8:
                        iconUrl = [TiSDK shareInstance].getMaskUrl;
                        folder = @"mask_icon";
                        downloadStatus = [TiMenuPlistManager shareManager].maskDownloadArr[index];
                        break;
                    case 9:
                        iconUrl = [TiSDK shareInstance].getGreenScreenUrl;
                        folder = @"greenscreen_icon";
                        downloadStatus = @"DownloadComplete";
                        break;
                    case 11:
                        iconUrl = [TiSDK shareInstance].getInteractionUrl;
                        folder = @"interaction_icon";
                        downloadStatus = [TiMenuPlistManager shareManager].interactionDownloadArr[index];
                        break;
                    case 14:
                        iconUrl = [TiSDK shareInstance].getPortraitUrl;
                        folder = @"portrait_icon";
                        downloadStatus = [TiMenuPlistManager shareManager].portraitDownloadArr[index];
                        break;
                    case 16:
                        iconUrl = [TiSDK shareInstance].getGestureUrl;
                        folder = @"gesture_icon";
                        downloadStatus = [TiMenuPlistManager shareManager].gestureDownloadArr[index];
                        break;
                    default:
                        break;
                }
                
                iconUrl = iconUrl?iconUrl:@"";
                [TiUITool getImageFromeURL:[NSString stringWithFormat:@"%@/%@", iconUrl, subMod.thumb] WithFolder:folder downloadComplete:^(UIImage *image) {
                    [weakSelf.cellButton setTitle:nil withImage:image withTextColor:nil forState:UIControlStateNormal];
                    [weakSelf.cellButton setTitle:nil withImage:image withTextColor:nil forState:UIControlStateSelected];
                }];
                
                if ([downloadStatus  isEqual: @"DownloadComplete"]){//下载完成
                    [self endAnimation];
                    [self.cellButton setDownloaded:YES];
                }else if([downloadStatus  isEqual: @"Downloading"]){//下载中。。。
                    [self startAnimation];
                    [self.cellButton setDownloaded:YES];
                }else if([downloadStatus  isEqual: @"NotDownloaded"]){//未下载
                    [self endAnimation];
                    [self.cellButton setDownloaded:NO];
                }
                
            }else{
                [self.cellButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(17, 17, 17, 17));
                }];
                [self.cellButton setBorderWidth:0.0 BorderColor:[UIColor clearColor] forState:UIControlStateNormal];
                [self.cellButton setBorderWidth:0.0 BorderColor:TiColor(88.0,221.0,221.0,1.0) forState:UIControlStateSelected];
                [self.cellButton setTitle:nil
                                withImage:[UIImage imageNamed:subMod.normalThumb]
                            withTextColor:nil
                                 forState:UIControlStateNormal];
                [self.cellButton setTitle:nil
                                withImage:[UIImage imageNamed:subMod.thumb]
                            withTextColor:nil
                                 forState:UIControlStateSelected];
                [self endAnimation];
                [self.cellButton setDownloaded:YES];
            }
            
            [self.cellButton setSelected:subMod.selected];
            
        }
        
    }
    
}

- (void)startAnimation{
    [self.cellButton startAnimation];
}

- (void)endAnimation{
    [self.cellButton endAnimation]; 
}

@end
