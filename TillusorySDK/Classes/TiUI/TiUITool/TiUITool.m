//
//  TiUITool.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/4.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiUITool.h"
#import "TiUIConfig.h"

@implementation TiUITool

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

+ (void)getImageFromeURL:(NSString *)fileURL WithFolder:(NSString *)folder downloadComplete:(void(^) (UIImage *image))completeBlock{
    
    NSString *imageName = [[fileURL componentsSeparatedByString:@"/"] lastObject];
  
    NSString *cachePaths = [[TiSDK shareInstance] getResPath];
  
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *folderPath = [cachePaths stringByAppendingFormat:@"/%@",folder];
    
    NSString *imagePath = [folderPath stringByAppendingFormat:@"/%@",imageName];
    
    if ([fileManager fileExistsAtPath:imagePath])
    {//文件存在
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
//            NSLog(NSLocalizedString(@"从本地获取图片 %@", nil),cachePaths);
         completeBlock(image);
    }else{
        if (![fileManager fileExistsAtPath:folderPath]) {
            //创建文件夹
              NSError *error = nil;
              [fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:&error];
              if (error) {
                  NSLog(NSLocalizedString(@"文件夹创建失败 err %@", nil),error);
              }else{
  //                NSLog(NSLocalizedString(@"文件夹创建成功", nil));
              }
        }
        //下载下载图片到本地
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
            if (data) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage *image = [UIImage imageWithData:data];
                    //写入本地
//                    NSLog(NSLocalizedString(@"图片写入本地地址 %@", nil),imagePath);
                    [UIImagePNGRepresentation(image) writeToFile:imagePath atomically:YES];
//                    [UIImageJPEGRepresentation(image, 0.5)writeToFile:imagePath atomically:YES];
                    completeBlock(image);
                });
            }else{
                NSLog(NSLocalizedString(@"图片地址URL-》%@ \n下载失败", nil),fileURL);
            }
        });
        
    }
   
}

@end
