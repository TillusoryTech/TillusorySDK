//
//  TiPSWithoutSwitchViewSubCell.h
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiPSConfig.h"

typedef NS_ENUM(NSInteger, TiPSWithoutSwitchViewCellType) {
    TiPSWithoutSwitchViewCellOne,
    TiPSWithoutSwitchViewCellTwo
};

@interface TiPSWithoutSwitchViewSubCell : UICollectionViewCell

@property(nonatomic,assign) TiPSWithoutSwitchViewCellType cellType;
@property(nonatomic,strong) TiPSMode *subMod;

@end
