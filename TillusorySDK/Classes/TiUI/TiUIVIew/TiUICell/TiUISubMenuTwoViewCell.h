//
//  TiUISubMenuTwoViewCell.h
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/5.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TiUIConfig.h"

typedef NS_ENUM(NSInteger, TiUISubMenuTwoViewCellType) {
    TI_UI_TWOSUBCELL_TYPE_ONE,
    TI_UI_TWOSUBCELL_TYPE_TWO
};

@interface TiUISubMenuTwoViewCell : UICollectionViewCell

@property(nonatomic,assign) TiUISubMenuTwoViewCellType cellType;

@property(nonatomic,strong)TIMenuMode *subMod;

@end
