//
//  TiUISubMenuTwoViewCell.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/5.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiUISubMenuTwoViewCell.h"
#import "TiButton.h"

@interface TiUISubMenuTwoViewCell ()

@property(nonatomic ,strong)TiButton *cellButton;

@end

@implementation TiUISubMenuTwoViewCell

- (TiButton *)cellButton{
    if (!_cellButton) {
        _cellButton = [[TiButton alloc] initWithScaling:1.0 withMakeUp:NO];
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

- (void)setSubMod:(TIMenuMode *)subMod{
    
    if (subMod) {
        _subMod = subMod;
        if ([subMod.thumb  isEqual: @""]) {
            [self.cellButton setTitle:[NSString stringWithFormat:@"%@",@""] withImage:nil withTextColor:UIColor.clearColor forState:UIControlStateNormal];
            [self.cellButton setClassifyText:subMod.name withTextColor:UIColor.whiteColor];
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

- (void)setCellType:(TiUISubMenuTwoViewCellType)cellType{
    
    _cellType = cellType;
    switch (cellType) {
        case TI_UI_TWOSUBCELL_TYPE_ONE:
        {
            [self.cellButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.left.right.equalTo(self);
            }];
            if (![self.subMod.thumb  isEqual: @""]) {
                [self.cellButton setViewforState];
            }
        }
            break;
        case TI_UI_TWOSUBCELL_TYPE_TWO:
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
