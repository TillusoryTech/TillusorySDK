//
//  AppDelegate.m
//  TiSDKDemo
//
//  Created by Paul on 2019/8/23.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeViewController.h"
#import <TiSDK/TiSDKInterface.h>
#import "TiSDKKey.h"

NSString *isSDKInit = @"未初始化";

@interface AppDelegate ()<TiSDKDelegate>

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[HomeViewController alloc] init]];
    [self.window makeKeyAndVisible];
    
    
    //todo --- tillusory start ---
 
    NSString *sanboxTillusory = [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingString:@"/Tillusory"];
    
    [[TiSDK shareInstance] setResPath:sanboxTillusory];
    
//    #error--TI_SDK_KEY--请联系商务获取
    [[TiSDK shareInstance] initSDK:TI_SDK_KEY withDelegate:self];
    //todo --- tillusory end ---
    
    return YES;
}

- (void)failure {
    isSDKInit = @"初始化失败";
}

- (void)success {
    isSDKInit = @"初始化成功";
}

@end
