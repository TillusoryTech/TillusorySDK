//
//  TiUIAdapter.h
//  TiFancy
//
//  Created by Itachi Uchiha on 2021/8/11.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIkit/UIkit.h>

/**
 * UI机型适配器
 * 需要在AppDelegate中调用
 */
@interface TiUIAdapter : NSObject

/**
 * 单例
 */
+ (TiUIAdapter *)shareInstance;

/**
 * UI机型适配器开闭
 *
 * @param enabled 开关，默认为false，传值true为开启
 *
 * 建议在AppDelegate.m didFinishLaunchingWithOptions函数且进入首页面设置前调用
 * 如果不调用该函数则默认适配器关闭，UI适配无效
 *
 */
- (void)setAdapterEnabled:(BOOL)enabled;

/**
 * 适配后left
 *
 * @param left UI元素适配前left位置值
 */
- (CGFloat)leftAfterAdaptionByRawLeft:(CGFloat)left;

/**
 * 适配后top
 *
 * @param top UI元素适配前top位置值
 */
- (CGFloat)topAfterAdaptionByRawTop:(CGFloat)top;

/**
 * 适配后width
 *
 * @param width UI元素适配前width值
 */
- (CGFloat)widthAfterAdaptionByRawWidth:(CGFloat)width;

/**
 * 适配后height
 *
 * @param height UI元素适配前height值
 */
- (CGFloat)heightAfterAdaptionByRawHeight:(CGFloat)height;

/**
 * 适配后UI元素rect值
 *
 * @param left UI元素适配前left位置值
 * @param top UI元素适配前top位置值
 * @param width UI元素适配前width位置值
 * @param height UI元素适配前height位置值
 *
 * @return 返回适配后UI元素rect
 */
- (CGRect)rectAfterAdaptionWithLeft:(CGFloat)left Top:(CGFloat)top Width:(CGFloat)width Height:(CGFloat)height;

/**
 * 适配后height
 *
 * @return 返回适配后状态栏高度
 */
- (CGFloat)statusBarHeightAfterAdaption;

/**
 * 适配后height
 *
 * @return 返回适配后导航栏高度
 */
- (CGFloat)navigationBarHeightAfterAdaption;

/**
 * 适配后height
 *
 * @return 返回适配后标签栏高度
 */
- (CGFloat)tabBarHeightAfterAdaption;

@end
