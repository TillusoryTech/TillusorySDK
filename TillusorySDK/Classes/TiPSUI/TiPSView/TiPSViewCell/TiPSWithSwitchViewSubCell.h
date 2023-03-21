//
//  TiPSWithSwitchViewSubCell.h
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiPSConfig.h"

@interface TiPSWithSwitchViewSubCell : UICollectionViewCell

@property(nonatomic,strong)TiPSMode *subMod;
- (void)setCellTypeBorderIsShow:(BOOL)show;

@end
