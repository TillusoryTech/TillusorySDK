//
//  TiPSPlistManager.h
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TiPSPlistManager : NSObject

- (void)reset:(NSString *)resetName;

/**
 *   初始化单例
 */
+ (TiPSPlistManager *)shareManager;

+ (void)releaseShareManager;

@property(nonatomic,strong)NSArray *mainModeArr;
@property(nonatomic,strong)NSArray *onekeyModeArr;//一键式美颜
@property(nonatomic,strong)NSArray *onekeyParameter;//一键式美颜参数
@property(nonatomic,strong)NSArray *beautyModeArr;//美颜
@property(nonatomic,strong)NSArray *faceshapeModeArr;//脸型
@property(nonatomic,strong)NSArray *faceshapeParameter;//脸型参数
@property(nonatomic,strong)NSArray *appearanceModeArr;//美型
@property(nonatomic,strong)NSArray *filterModeArr;//滤镜

- (NSArray *)modifyObject:(id)obj forKey:(NSString *)key In:(NSUInteger)index WithPath:(NSString *)path;

@end

@interface TiPSMode : NSObject

@property(nonatomic,strong) NSString *name;
@property(nonatomic,assign) NSInteger menuTag;
@property(nonatomic,assign) BOOL selected;
@property(nonatomic,assign) BOOL totalSwitch;
@property(nonatomic,strong) NSString *subMenu;
@property(nonatomic,strong) NSString *effectName;//效果名称

@property(nonatomic,strong) NSString *thumb;
@property(nonatomic,strong) NSString *normalThumb;
@property(nonatomic,strong) NSString *selectedThumb;
@property(nonatomic,assign) BOOL downloaded;

@property(nonatomic,assign) NSInteger x;
@property(nonatomic,assign) NSInteger y;
@property(nonatomic,assign) NSInteger ratio;

@property(nonatomic,strong) NSString *dir;
@property(nonatomic,strong) NSString *category;
@property(nonatomic,assign) BOOL voiced;
@property(nonatomic,strong) NSString *hint;

@property(nonatomic,strong) NSString *type;

+ (instancetype)applicationWithDic:(NSDictionary*)dic;

@end
