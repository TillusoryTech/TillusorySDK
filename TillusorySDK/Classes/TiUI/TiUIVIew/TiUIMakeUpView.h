//
//  TiUIMakeUpView.h
//  TiFancy
//
//  Created by MBP DA1003 on 2020/8/1.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiMenuPlistManager.h"
#import "TiButton.h"

NS_ASSUME_NONNULL_BEGIN

// 全局变量——判断不同美妆的默认状态
extern bool Default_is_Null;
// 美妆是否重置完成
extern bool makeUpResetComplete;

@interface TiUIMakeUpView : UIView

@property(nonatomic,copy) void(^clickOnCellBlock)(NSInteger index);

@property(nonatomic,copy) void(^makeupShowDisappearBlock)(BOOL Hidden);

@property(nonatomic,copy) void(^backBlock)(BOOL is_back);

@property(nonatomic,strong) TIMenuMode *mode;

@property(nonatomic,strong) UIButton *backBtn;
@property(nonatomic,strong) UIButton *defaultBtn;
@property(nonatomic,strong) UILabel *defaultLabel;

@property(nonatomic,strong) UICollectionView *menuCollectionView;

- (void)setHiddenAnimation:(BOOL)hidden;
- (void)defaultselected:(UIButton *)button;

@end

NS_ASSUME_NONNULL_END
