//
//  TiPSTool.m
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSTool.h"
#import "TiPSConfig.h"

@implementation TiPSTool

+ (void)setWriteJsonDic:(NSDictionary *)dic toPath:(NSString *)path{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (!jsonData || error) {
        NSLog(NSLocalizedString(@"JSON解码失败", nil));
        NSLog(NSLocalizedString(@"JSON文件%@ 写入失败 error-- %@", nil),path,error);
    } else {
        [jsonString writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
        if (error) {
            NSLog(NSLocalizedString(@"JSON文件%@ 写入失败 error-- %@", nil),path,error);
        }
    }
    
}

+ (id)getJsonDataForPath:(NSString *)path{
    
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    if (!jsonData) {
        NSLog(NSLocalizedString(@"JSON文件%@ 解码失败 error--", nil),path);
        return nil;
    } else {
        id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        return jsonObj;
    }
    
}

@end
