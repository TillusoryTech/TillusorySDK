//
//  TiPSWithSwitchViewSubCell.m
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSWithSwitchViewSubCell.h"
#import "TiPSButton.h"

@interface TiPSWithSwitchViewSubCell ()

@property(nonatomic ,strong)TiPSButton *cellButton;

@end

@implementation TiPSWithSwitchViewSubCell

- (TiPSButton *)cellButton{
    if (!_cellButton) {
        _cellButton = [[TiPSButton alloc] initWithScaling:0.9 withMakeUp:NO];
        _cellButton.userInteractionEnabled = NO;
    }
    return _cellButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.cellButton];
        [self.cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self);
            make.left.equalTo(self.mas_left).offset(6);
            make.right.equalTo(self.mas_right).offset(-6);
        }];
    }
    return self;
}

- (void)setSubMod:(TiPSMode *)subMod{
    
    if (subMod) {
        _subMod = subMod;
        if ([subMod.normalThumb  isEqual: @""]) {
            [self.cellButton setTitle:[NSString stringWithFormat:@"%@",@""] withImage:nil withTextColor:UIColor.clearColor forState:UIControlStateNormal];
            [self.cellButton setClassifyText:subMod.name withTextColor:UIColor.blackColor];
        }else{
            [self.cellButton setTitle:[NSString stringWithFormat:@"%@",subMod.name] withImage:[UIImage imageNamed:subMod.normalThumb] withTextColor:UIColor.blackColor forState:UIControlStateNormal];
            [self.cellButton setTitle:[NSString stringWithFormat:@"%@",subMod.name]
                            withImage:[UIImage imageNamed:subMod.selectedThumb]
                        withTextColor:TiColor(88.0,221.0,221.0,1.0)
                             forState:UIControlStateSelected];
            [self.cellButton setSelected:subMod.selected];
            [self.cellButton setTextFont:TiFontRegular(10)];
        }
    }
    
}

- (void)setCellTypeBorderIsShow:(BOOL)show{
    
    if (show) {
        [self.cellButton setBorderWidth:0.0 BorderColor:[UIColor clearColor] forState:UIControlStateNormal];
        [self.cellButton setBorderWidth:1.f BorderColor:TiColor(88.0,221.0,221.0,1.0) forState:UIControlStateSelected];
    }else{
        [self.cellButton setBorderWidth:0.0 BorderColor:[UIColor clearColor] forState:UIControlStateNormal];
        [self.cellButton setBorderWidth:0.f BorderColor:[UIColor clearColor] forState:UIControlStateSelected];
    }
    
}

@end
