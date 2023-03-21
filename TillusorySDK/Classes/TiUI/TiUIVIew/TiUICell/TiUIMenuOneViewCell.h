//
//  TiUISubMenuOneViewCell.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/5.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiMenuPlistManager.h"
#import "TiUIConfig.h"

NS_ASSUME_NONNULL_BEGIN

@interface TiUIMenuOneViewCell : UICollectionViewCell

@property(nonatomic,strong) TIMenuMode *mode;

@property(nonatomic,copy)void(^clickOnCellBlock)(NSInteger index);

@property(nonatomic,copy)void(^makeupShowDisappearBlock)(BOOL Hidden);

@property(nonatomic,assign) BOOL isMakeupShow;

@property(nonatomic,strong) UICollectionView *menuCollectionView;

@end

NS_ASSUME_NONNULL_END
