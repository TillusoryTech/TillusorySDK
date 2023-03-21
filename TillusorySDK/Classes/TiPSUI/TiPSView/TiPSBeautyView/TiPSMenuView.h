//
//  TiPSMenuView.h
//  TiFancy
//
//  Created by N17 on 2021/9/23.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TiPSMenuView : UIView

@property(nonatomic,strong) NSString *selectName;
@property(nonatomic,copy) void(^clickShowOtherViewBlock)(NSNumber *showOtherView);

- (void)hiddenAll;
- (void)showBeauty:(NSString *)effectName;

@end

NS_ASSUME_NONNULL_END
