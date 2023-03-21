//
//  TiPSWithSwitchViewCell.h
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiPSPlistManager.h"
#import "TiPSConfig.h"

@interface TiPSWithSwitchViewCell : UICollectionViewCell

@property(nonatomic,strong) TiPSMode *mode;

// 点击cell触发的回调
@property(nonatomic,copy)void(^clickOnCellBlock)(NSInteger index);
// 改变Enabled属性触发的回调
@property(nonatomic,copy)void(^clickChangeEnabledBlock)(bool enabled);

@property(nonatomic,strong) UICollectionView *menuCollectionView;

@end
