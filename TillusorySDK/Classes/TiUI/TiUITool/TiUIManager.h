//
//  TiUIManager.h
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

/*
 *     ⣠⣇
 *     ⡙⣿⣤⣾⣿⣿⣿⣶⣄
 *     ⣨⣿⣿⣿⣿⣿⣿⣿⣿⣿⣄⣠⡶⠋
 *     ⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡶⠶⠒
 *     ⢻⣿⡟⣾⡙⠧⣊⢚⣪⡊⣸⢻⣟⠶⣄
 *     ⣀⣙⣷⠙⠀⠀⠀⢇⢽⣞⡏⣸⠋
 *     ⠙⢛⣻⠟⠒⠀⠀⠀⠀⠀⣩⠋
 *     ⣿⡏⠀⠀⠀⡗⢄⠀⡠⠛
 *     ⠋⠀⠀⠀⠉⠙⢄⠉
 *     ⢎⠑⣇⣸⠶⣧⣸⠶⡎⠑⣇
 *        新一保佑
 *       代码无BUG
 *     真相通常只有一个
 *
 */

#import "TiUIMainMenuView.h"
#import <UIKit/UIKit.h>
#import "TiUIDefaultButtonView.h"

// 是否已切换为美妆or绿幕--用于退出手势的判断
extern bool isswitch_makeup;
extern bool isswitch_greenEdit;

@protocol TiUIManagerDelegate <NSObject>

/**
 * 点击退出手势
 */
- (void)didClickOnExitTap;
/**
 * 切换摄像头
 */
- (void)didClickSwitchCameraButton;
/**
 * 拍照 -- 准确说是截取当前画面
 */
- (void)didClickCameraCaptureButton;

@end

@interface TiUIManager : NSObject

/**
 * 初始化单例
 */
+ (TiUIManager *)shareManager;
// 主窗口
@property(nonatomic, strong) UIWindow *superWindow;
// 添加退出手势的View
@property(nonatomic, strong) UIView *exitTapView;
@property(nonatomic, strong) TiUIDefaultButtonView *defaultButton;
// 美颜模块主要功能UI
@property(nonatomic,strong) TiUIMainMenuView *tiUIViewBoxView;
@property(nonatomic, weak) id <TiUIManagerDelegate> delegate;

- (void)popAllViews;
- (void)hiddenAllViews:(BOOL)YESNO;
/**
 * 设置特效提示语
 */
- (void)setInteractionHintL:(NSString *)hint;
/**
 * 弹出功能页UI
 */
- (void)showMainMenuView;
/**
 *  加载UI 通过Window默认初始化在当前页面最上层
 */
- (void)loadToWindowDelegate:(id<TiUIManagerDelegate>)delegate;
/**
 * 加载UI 通过传入View
 */
- (void)loadToView:(UIView* )view forDelegate:(id<TiUIManagerDelegate>)delegate;
/**
 * 加载UI 返回一个View视图
 */
- (UIView*)returnLoadToViewDelegate:(id<TiUIManagerDelegate>)delegate;
/**
 * 释放UI资源
 */
- (void)destroy;

@end
