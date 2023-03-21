//
//  TiSetSDKParameters.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/10.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TiUIConfig.h"

// 用于判断是否同步滤镜
extern bool is_updateFilterValue;

@interface TiSetSDKParameters : NSObject

// 保存key float值
+ (void)setFloatValue:(float)value forKey:(TiUIDataCategoryKey)key;
// 获取key float值
+ (float)getFloatValueForKey:(TiUIDataCategoryKey)key;

// 保存一键美颜&滤镜&脸型等的选中位置
+ (void)setSelectPosition:(NSInteger)position forKey:(TiUIDataCategoryKey)key;
// 获取一键美颜&滤镜&脸型等的选中位置
+ (NSInteger)getSelectPositionForKey:(TiUIDataCategoryKey)key;

//判断缓存的值是否为空
+ (NSString *)judgeCacheValueIsNullForKey:(TiUIDataCategoryKey)key;

 // 保存选中美妆的坐标
+ (void)setBeautyMakeupIndex:(int)index forKey:(TiUIDataCategoryKey)key;
 // 获取选中美妆的坐标
+ (int)getBeautyMakeupIndexForKey:(TiUIDataCategoryKey)key;

+ (void)initSDK;

//+ (void)setTotalEnable:(BOOL)enable toIndex:(NSInteger)index;

+ (void)setBeautySlider:(float)v forKey:(TiUIDataCategoryKey)key withIndex:(NSInteger)index;

+ (TiHairEnum)getTiHairEnumForIndex:(NSInteger)index;

+ (TiRockEnum)setRockEnumByIndex:(NSInteger)index;

+ (TiDistortionEnum)setDistortionEnumByIndex:(NSInteger)index;


+ (void)setOneKeyBeautySlider:(float)v Index:(NSInteger)index;
+ (void)setFaceShapeBeautySlider:(float)v Index:(NSInteger)index;

+ (NSString *)setMakeupByIndex:(NSInteger)index;

@end
