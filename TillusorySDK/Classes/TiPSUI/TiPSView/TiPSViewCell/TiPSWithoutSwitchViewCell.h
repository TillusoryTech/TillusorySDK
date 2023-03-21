//
//  TiPSWithoutSwitchViewCell.h
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiPSConfig.h"

@interface TiPSWithoutSwitchViewCell : UICollectionViewCell

@property(nonatomic,strong) TiPSMode *mode;
// 点击cell触发的回调
@property(nonatomic,copy) void(^clickOnCellBlock)(NSInteger index);
// 改变重置对象触发的回调
@property(nonatomic,copy) void(^clickChangeResetObjectBlock)(NSString *resetObject);
@property(nonatomic,strong) UICollectionView *menuCollectionView;

@end
