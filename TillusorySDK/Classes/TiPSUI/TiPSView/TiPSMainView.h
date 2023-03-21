//
//  TiPSMainView.h
//  TiFancy
//
//  Created by N17 on 2021/9/16.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiPSSliderRelatedView.h"
#import "TiPSMainViewModel.h"
#import "TiPSBeautyView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiPSMainView : UIView

@property(nonatomic,strong) TiPSMainViewModel *viewModel;
@property(nonatomic,assign) NSNumber *renderEnable;// 是否执行渲染
@property(nonatomic,assign) NSNumber *showOtherView;// 是否显示额外的--长腿瘦身
@property(nonatomic,assign) CGFloat bodyValue;// 长腿瘦身对应的参数
// 上方的滑动选择区域
@property(nonatomic,strong) TiPSTopSliderRelatedView *sliderRelatedView;

- (instancetype)initWithFrame:(CGRect)frame andViewMode:(TiPSMainViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
