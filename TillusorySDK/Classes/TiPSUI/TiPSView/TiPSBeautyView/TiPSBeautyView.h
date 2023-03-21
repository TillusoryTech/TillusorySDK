//
//  TiPSBeautyView.h
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiPSMenuView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiPSBeautyView : UIView
// 美颜菜单列表
@property(nonatomic,strong) TiPSMenuView *menuView;
// 对应的具体美颜效果列表
@property(nonatomic,strong) UICollectionView *subMenuView;
// 美颜重置功能
@property(nonatomic,strong) UIButton *resetButton;
// 启用美颜重置
@property(nonatomic,strong) NSNumber *startReset;
// 是否需要改变滑动条样式
@property(nonatomic,strong) NSNumber *sliderChange;

@property(nonatomic,copy) void(^clickChangeResetObjectBlock)(NSString *resetObject);
// 点击进行修图渲染
@property(nonatomic,copy) void(^clickChangeRenderBlock)(NSNumber *renderEnable);
// 是否显示额外的长腿瘦身
@property(nonatomic,copy) void(^clickShowOtherViewBlock)(NSNumber *showOtherView);
// 是否启用滑动条左右滑动
@property(nonatomic,strong) NSNumber *sliderEnabled;

@end

NS_ASSUME_NONNULL_END
