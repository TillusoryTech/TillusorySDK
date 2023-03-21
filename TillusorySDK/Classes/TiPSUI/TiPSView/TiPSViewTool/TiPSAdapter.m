//
//  TiPSAdapter.m
//  TiFancy
//
//  Created by N17 on 2021/9/18.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSAdapter.h"

@interface TiPSAdapter()

@property (nonatomic, assign) CGFloat autoSizeScaleX;
@property (nonatomic, assign) CGFloat autoSizeScaleY;

@end

@implementation TiPSAdapter

static TiPSAdapter *shareInstance = NULL;

+ (TiPSAdapter *)shareInstance {
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        shareInstance = [[TiPSAdapter alloc] init];
    });
    
    return shareInstance;
}

- (instancetype)init {
    _autoSizeScaleX = 1.0;
    _autoSizeScaleY = 1.0;
    
    return [super init];
}

- (void)setAdapterEnabled:(BOOL)enabled {
    if (TiPSScreenHeight == 480 || TiPSScreenHeight == 568 || TiPSScreenHeight == 667 || TiPSScreenHeight == 736) {
        _autoSizeScaleX = TiPSScreenWidth / 375;
        _autoSizeScaleY = TiPSScreenHeight / 778;
    } else if (TiPSScreenHeight == 812 || TiPSScreenHeight == 896) {
        _autoSizeScaleX = TiPSScreenWidth / 375;
        _autoSizeScaleY = (TiPSScreenHeight - 34) / 778;
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
    if (TiPSScreenHeight == 568 || TiPSScreenHeight == 667 || TiPSScreenHeight == 736) {
        height = 20;
    } else if (TiPSScreenHeight == 812) {
        height = 44;
    } else if (TiPSScreenHeight == 896) {
        height = 44;
    }
    return height;
}

- (CGFloat)navigationBarHeightAfterAdaption {
    CGFloat height = 0;
    if (TiPSScreenHeight == 568 || TiPSScreenHeight == 667 || TiPSScreenHeight == 736) {
        height = 44;
    } else if (TiPSScreenHeight == 812) {
        height = 44;
    } else if (TiPSScreenHeight == 896) {
        height = 44;
    }
    
    return height;
}

- (CGFloat)tabBarHeightAfterAdaption {
    CGFloat height = 0;
    if (TiPSScreenHeight == 568 || TiPSScreenHeight == 667 || TiPSScreenHeight == 736) {
        height = 49;
    } else if (TiPSScreenHeight == 812) {
        height = 49;
    } else if (TiPSScreenHeight == 896) {
        height = 73.5;
    }
    return height;
}

@end
