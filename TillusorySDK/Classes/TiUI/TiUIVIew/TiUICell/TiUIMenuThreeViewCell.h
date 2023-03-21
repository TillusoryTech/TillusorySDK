//
//  TiUIMenuThreeViewCell.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/6.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiUIConfig.h"

@interface TiUIMenuThreeViewCell : UICollectionViewCell

@property(nonatomic,strong) TIMenuMode *mode;
@property(nonatomic,strong) UICollectionView *menuCollectionView;

@end
