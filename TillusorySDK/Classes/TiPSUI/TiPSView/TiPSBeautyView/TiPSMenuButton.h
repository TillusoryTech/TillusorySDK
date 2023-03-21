//
//  TiPSMenuButton.h
//  TiFancy
//
//  Created by N17 on 2021/9/17.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiPSConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiPSMenuButton : UIButton

// 设置文本和选中状态
- (void)setTitle:(NSString *)text withStateSelected:(BOOL)isSelected;

@end

NS_ASSUME_NONNULL_END
