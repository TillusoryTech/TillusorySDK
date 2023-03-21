//
//  TiUIMainMenuView.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiUIClassifyView.h"
#import "TiUIMainMenuViewModel.h"
#import "TiUISliderRelatedView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiUIMainMenuView : UIView

@property(nonatomic,strong) TiUIMainMenuViewModel *viewModel;

@property(nonatomic,assign) BOOL isClassifyShow;
// 滑动条相关View
@property(nonatomic,strong) TiUISliderRelatedView *sliderRelatedView;
// 滑动条下方背景
@property(nonatomic,strong) UIView *backgroundView;
// 美颜菜单列表
@property(nonatomic,strong) UICollectionView *menuView;
// 对应的具体美颜效果列表
@property(nonatomic,strong) UICollectionView *subMenuView;
// 下方的返回按钮
@property(nonatomic,strong) UIButton *downBackBtn;
// 右边的返回模块
@property(nonatomic,strong) UIButton *rightBackBtn;
@property(nonatomic,strong) UIView *rightBackView;
@property(nonatomic,strong) UIView *lineView;
// 重置部分
@property(nonatomic,strong) UIButton *resetBtn;
@property(nonatomic,strong) UIView *_Nullable masklayersView;
@property(nonatomic,strong) UIView *_Nullable resetBgView;
@property(nonatomic,strong) UILabel *_Nullable resetBgLabel;
@property(nonatomic,strong) UIButton *_Nullable reset_MY_YesBtn;
@property(nonatomic,strong) UIButton *_Nullable reset_MY_NoBtn;
// 新增UI美颜分类功能
@property(nonatomic,strong) TiUIClassifyView *classifyView;
// 美颜分组菜单信息
@property(nonatomic,strong) NSArray *classifyArr;
// 美妆、绿幕编辑等其他title。。
@property(nonatomic,strong) UIView *otherTopView;
@property(nonatomic,strong) UILabel *otherTopLabel;

- (void)showClassifyView;
- (void)hiddenClassifyView;
- (void)didSelectParentMenuCell:(NSIndexPath *)indexPath;
- (void)setOtherTitleHidden:(BOOL)is_hidden withName:(NSString *)name withCute:(BOOL)isCute;

- (instancetype)initWithFrame:(CGRect)frame withViewModel:(TiUIMainMenuViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
