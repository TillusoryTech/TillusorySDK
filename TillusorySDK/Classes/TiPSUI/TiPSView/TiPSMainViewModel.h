//
//  TiPSMainViewModel.h
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TiPSSetSDKParameters.h"
#import "TiPSTopSliderRelatedView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiPSMainViewModel : NSObject
// 当前重置对象
@property(nonatomic,assign) NSString *resetObject;
// 隐藏滑动条
@property(nonatomic,assign) NSNumber *sliderHidden;
@property(nonatomic,assign) NSInteger mainindex;
@property(nonatomic,assign) NSInteger subindex;

@property(nonatomic,strong) NSIndexPath *beautyPath;
@property(nonatomic,strong) NSIndexPath *filterPath;

- (instancetype)initWithAspectRatio:(NSString *)aspectRatio;

// 获取滑动条类型&参数
- (NSDictionary *)getSliderTypeAndValue:(BOOL)isMonitor;
// 通过Tag调整数据
- (void)setIndexByMenuTag:(int)menuTag;
// 存储滑动条&美颜参数
- (void)saveParameters:(int)value;

@end

NS_ASSUME_NONNULL_END
