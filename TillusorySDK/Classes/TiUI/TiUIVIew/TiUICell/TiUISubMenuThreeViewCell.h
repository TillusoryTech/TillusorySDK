//
//  TiUISubMenuThreeViewCell.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/6.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiUIConfig.h"
#import "TiButton.h"

@interface TiUISubMenuThreeViewCell : UICollectionViewCell

@property(nonatomic,strong)TIMenuMode *subMod;

- (void)setSubMod:(TIMenuMode *)subMod WithTag:(NSInteger)tag WithIndex:(NSInteger)index;
- (void)setSubMod:(TIMenuMode *)subMod WithTag:(NSInteger)tag isEnabled:(BOOL)isEnabled;

- (BOOL)isEdit;

- (void)startAnimation;
- (void)endAnimation;

@end
