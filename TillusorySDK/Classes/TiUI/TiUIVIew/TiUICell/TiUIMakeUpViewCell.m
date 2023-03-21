//
//  TiUIMakeUpViewCell.m
//  TiFancy
//
//  Created by MBP DA1003 on 2020/8/3.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiUIMakeUpViewCell.h"
#import "TiUITool.h"

@interface TiUIMakeUpViewCell ()

@end

@implementation TiUIMakeUpViewCell

- (TiButton *)cellButton{
    if (!_cellButton) {
        _cellButton = [[TiButton alloc] initWithScaling:1.0 withMakeUp:YES];
        _cellButton.userInteractionEnabled = NO;
        [_cellButton setDownloadViewFrame:downloadViewFrame_equalToImage];
    }
    return _cellButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.cellButton];
        [self.cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.mas_left).offset(6);
            make.right.equalTo(self.mas_right).offset(-6);
        }];
        
    }
    return self;
}

- (void)setSubMod:(TIMenuMode *)subMod WithTag:(NSInteger)tag WithIndex:(NSInteger)index{
    if (subMod) {
        _subMod = subMod;
        
        if (subMod.menuTag) {
            WeakSelf;
            NSString *iconUrl =[TiSDK shareInstance].getMakeupUrl;
            NSString *folder = @"makeup_icon";
            //获取下载状态
            NSString *downloadStatus;
            
            if ([subMod.type  isEqual: @"blusher"]) {
                downloadStatus = [TiMenuPlistManager shareManager].blusherDownloadArr[index];
            }
            if ([subMod.type  isEqual: @"eyebrow"]) {
                downloadStatus = [TiMenuPlistManager shareManager].eyebrowsDownloadArr[index];
            }
            if ([subMod.type  isEqual: @"eyeshadow"]) {
                downloadStatus = [TiMenuPlistManager shareManager].eyeshadowDownloadArr[index];
            }
            if ([subMod.type  isEqual: @"lipgloss"]) {
                downloadStatus = [TiMenuPlistManager shareManager].lipglossDownloadArr[index];
            }
            
            iconUrl = iconUrl?iconUrl:@"";
            [TiUITool getImageFromeURL:[NSString stringWithFormat:@"%@/%@", iconUrl, subMod.thumb] WithFolder:folder downloadComplete:^(UIImage *image) {
                [weakSelf.cellButton setTitle:subMod.dir withImage:image withTextColor:UIColor.whiteColor forState:UIControlStateNormal];
                [weakSelf.cellButton setTitle:subMod.dir withImage:image withTextColor:TiColor(88.0,221.0,221.0,1.0)
                                     forState:UIControlStateSelected];
            }];
            //设置字体大小
            [weakSelf.cellButton setTextFont:TiFontRegular(10)];
            
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
            [self.cellButton setTitle:subMod.dir withImage:[UIImage imageNamed:subMod.normalThumb] withTextColor:TiColors(149.0,1.0) forState:UIControlStateNormal];
            [self.cellButton setTitle:subMod.dir withImage:[UIImage imageNamed:subMod.selectedThumb] withTextColor:TiColor(88.0,221.0,221.0,1.0) forState:UIControlStateSelected];
            [self endAnimation];
            [self.cellButton setDownloaded:YES];
        }
        
        [self.cellButton setSelected:subMod.selected];
        
    }
    
}

- (void)startAnimation{
    [self.cellButton startAnimation];
}

- (void)endAnimation{
    [self.cellButton endAnimation];
}

- (void)setCellTypeBorderIsShow:(BOOL)show{
    [self.cellButton setBorderWidth:0.0 BorderColor:[UIColor clearColor] forState:UIControlStateNormal];
    [self.cellButton setBorderWidth:1.f BorderColor:TiColor(88.0,221.0,221.0,1.0) forState:UIControlStateSelected];
}

@end
