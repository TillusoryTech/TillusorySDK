//
//  TiUIMainMenuViewModel.h
//  TiUIMainMenuViewModel
//
//  Created by N17 on 2021/8/24.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TiUIMainMenuViewModel : NSObject

// 是否正在重置——出现遮罩层则取消手势响应
@property(nonatomic,assign) BOOL isResetting;
// 当前重置对象
@property(nonatomic,assign) NSString *resetObject;
// 隐藏滑动条
@property(nonatomic,assign) NSNumber *sliderHidden;
// 主题色 ---> 全屏、1:1、3:4
@property(nonatomic,assign) NSString *switchAspectRatio;
// 是否需要切换到（脸型or一键美颜）\（贴纸or人像抠图）\（滤镜）\（美妆）
// 绿幕编辑
@property(nonatomic,assign) int is_greenEdit;
@property(nonatomic,assign) NSString *switchByName;

@property(nonatomic,assign) NSInteger mainindex;
@property(nonatomic,assign) NSInteger subindex;

@property(nonatomic,strong) NSIndexPath *beautyPath;
@property(nonatomic,strong) NSIndexPath *filterPath;
@property(nonatomic,strong) NSIndexPath *stickerPath;
@property(nonatomic,strong) NSIndexPath *makeUpPath;

- (instancetype)initWithAspectRatio:(NSString *)switchAspectRatio;

// 获取滑动条类型&参数
- (NSDictionary *)getSliderTypeAndValue:(BOOL)isMonitor;
// 通过Tag调整数据
- (void)setIndexByMenuTag:(int)menuTag;
// 存储滑动条&美颜参数
- (void)saveParameters:(int)value;

@end

NS_ASSUME_NONNULL_END
