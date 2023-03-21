//
//  TiUIAdapter.m
//  TiFancy
//
//  Created by Itachi Uchiha on 2021/8/11.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiUIAdapter.h"
#import "TiUIConfig.h"

@interface TiUIAdapter()

@property (nonatomic, assign) CGFloat autoSizeScaleX;
@property (nonatomic, assign) CGFloat autoSizeScaleY;

@end

@implementation TiUIAdapter

static TiUIAdapter *shareInstance = NULL;

+ (TiUIAdapter *)shareInstance {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        shareInstance = [[TiUIAdapter alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init {
    _autoSizeScaleX = 1.0;
    _autoSizeScaleY = 1.0;
    
    return [super init];
}

- (void)setAdapterEnabled:(BOOL)enabled {
    if (TiUIScreenHeight == 480 || TiUIScreenHeight == 568 || TiUIScreenHeight == 667 || TiUIScreenHeight == 736) {
        _autoSizeScaleX = TiUIScreenWidth / 375;
        _autoSizeScaleY = TiUIScreenHeight / 778;
    } else if (TiUIScreenHeight == 812 || TiUIScreenHeight == 896) {
        _autoSizeScaleX = TiUIScreenWidth / 375;
        _autoSizeScaleY = (TiUIScreenHeight - 34) / 778;
    } else {
        _autoSizeScaleX = 1.0;
        _autoSizeScaleY = 1.0;
    }
}

- (CGFloat)leftAfterAdaptionByRawLeft:(CGFloat)left {
    return left * self.autoSizeScaleX;
}

- (CGFloat)topAfterAdaptionByRawTop:(CGFloat)top {
    return top * self.autoSizeScaleY;
}

- (CGFloat)widthAfterAdaptionByRawWidth:(CGFloat)width {
    return width * self.autoSizeScaleX;
}

- (CGFloat)heightAfterAdaptionByRawHeight:(CGFloat)height {
    return height * self.autoSizeScaleY;
}

- (CGRect)rectAfterAdaptionWithLeft:(CGFloat)left Top:(CGFloat)top Width:(CGFloat)width Height:(CGFloat)height {
    CGRect rect = CGRectMake(left * self.autoSizeScaleX, top * self.autoSizeScaleY, width * self.autoSizeScaleX, height * self.autoSizeScaleY);
    return rect;
}

- (CGFloat)statusBarHeightAfterAdaption {
    CGFloat height = 0;
    if (TiUIScreenHeight == 568 || TiUIScreenHeight == 667 || TiUIScreenHeight == 736) {
        height = 20;
    } else if (TiUIScreenHeight == 812) {
        height = 44;
    } else if (TiUIScreenHeight == 896) {
        height = 44;
    }
    return height;
}

- (CGFloat)navigationBarHeightAfterAdaption {
    CGFloat height = 0;
    if (TiUIScreenHeight == 568 || TiUIScreenHeight == 667 || TiUIScreenHeight == 736) {
        height = 44;
    } else if (TiUIScreenHeight == 812) {
        height = 44;
    } else if (TiUIScreenHeight == 896) {
        height = 44;
    }
    
    return height;
}

- (CGFloat)tabBarHeightAfterAdaption {
    CGFloat height = 0;
    if (TiUIScreenHeight == 568 || TiUIScreenHeight == 667 || TiUIScreenHeight == 736) {
        height = 49;
    } else if (TiUIScreenHeight == 812) {
        height = 49;
    } else if (TiUIScreenHeight == 896) {
        height = 73.5;
    }
    return height;
}

@end
