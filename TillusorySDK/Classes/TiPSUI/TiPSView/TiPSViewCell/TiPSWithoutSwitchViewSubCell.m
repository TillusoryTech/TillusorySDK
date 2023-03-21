//
//  TiPSWithoutSwitchViewSubCell.m
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSWithoutSwitchViewSubCell.h"
#import "TiPSButton.h"

@interface TiPSWithoutSwitchViewSubCell ()

@property(nonatomic ,strong)TiPSButton *cellButton;

@end

@implementation TiPSWithoutSwitchViewSubCell

- (TiPSButton *)cellButton{
    if (!_cellButton) {
        _cellButton = [[TiPSButton alloc] initWithScaling:1.0 withMakeUp:NO];
        _cellButton.userInteractionEnabled = NO;
    }
    return _cellButton;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cellButton];
    }
    return self;
    
}

- (void)setSubMod:(TiPSMode *)subMod{
    
    if (subMod) {
        _subMod = subMod;
        if ([subMod.thumb  isEqual: @""]) {
            [self.cellButton setTitle:[NSString stringWithFormat:@"%@",@""] withImage:nil withTextColor:UIColor.clearColor forState:UIControlStateNormal];
            [self.cellButton setClassifyText:subMod.name withTextColor:UIColor.blackColor];
        }else{
            NSString *normalThumb = subMod.normalThumb?subMod.normalThumb:subMod.thumb;
            NSString *selectedThumb = subMod.selectedThumb?subMod.selectedThumb:subMod.thumb;
            [self.cellButton setTitle:[NSString stringWithFormat:@"%@",subMod.name] withImage:[UIImage imageNamed:normalThumb] withTextColor:TiColors(68.0, 1.0) forState:UIControlStateNormal];
            [self.cellButton setTitle:[NSString stringWithFormat:@"%@",subMod.name] withImage:[UIImage imageNamed:selectedThumb] withTextColor:UIColor.whiteColor forState:UIControlStateSelected];
            [self.cellButton setSelected:subMod.selected];
            [self.cellButton setTextFont:TiFontRegular(10)];
            [self.cellButton setSelectedText:[NSString stringWithFormat:@"%@",subMod.name]];
        }
    }
    
}

- (void)setCellType:(TiPSWithoutSwitchViewCellType)cellType{
    
    _cellType = cellType;
    switch (cellType) {
        case TiPSWithoutSwitchViewCellOne:
        {
            [self.cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.left.right.equalTo(self);
            }];
            if (![self.subMod.thumb  isEqual: @""]) {
                [self.cellButton setViewforState];
            }
        }
            break;
        case TiPSWithoutSwitchViewCellTwo:
        {
            [self.cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self);
                make.left.equalTo(self.mas_left).offset(8);
                make.right.equalTo(self.mas_right).offset(-8);
            }];
        }
            break;
        default:
            break;
    }
    
}

@end
