//
//  TiPSTool.h
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TiPSTool : NSObject

//根据路径获取对应的json文件数据
+ (id)getJsonDataForPath:(NSString *)path;

//根据路径将对应的字典写入json
+ (void)setWriteJsonDic:(NSDictionary *)dic toPath:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
