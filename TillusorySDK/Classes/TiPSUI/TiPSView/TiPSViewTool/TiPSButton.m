//
//  TiPSButton.m
//  TiFancy
//
//  Created by N17 on 2021/9/22.
//  Copyright © 2021 Tillusory Tech. All rights reserved.
//

#import "TiPSButton.h"
#import "TiPSConfig.h"

@interface TiPSButton ()

@property(nonatomic,strong)UIView *selectView;
@property(nonatomic,strong)UIImageView *topView;
@property(nonatomic,strong)UILabel *bottomLabel;
@property(nonatomic,strong)UILabel *selectedLabel;//一键美颜文字被选中

@property(nonatomic ,strong)UIView *cellmaskView;

@property(nonatomic,strong)NSString *normalTitle;
@property(nonatomic,strong)NSString *selectedTitle;

@property(nonatomic,strong)UIImage *normalImage;
@property(nonatomic,strong)UIImage *selectedImage;

@property(nonatomic,strong)UIColor *normalColor;
@property(nonatomic,strong)UIColor *selectedColor;

@property(nonatomic,strong)UIColor *normalBorderColor;
@property(nonatomic,strong)UIColor *selectedBorderColor;
@property(nonatomic,assign)CGFloat normalBorderW;
@property(nonatomic,assign)CGFloat selectedBorderW;

@property(nonatomic ,strong)UILabel *classTextLabel;//分类文字
@property(nonatomic ,strong)UIView *classMaskView;//分类遮罩层
@property(nonatomic ,strong)UIView *classPointView;//分类圆点

@property(nonatomic,assign)BOOL is_white;

@end

@implementation TiPSButton

- (UIView *)selectView{
    if (!_selectView) {
        _selectView = [[UIView alloc]init];
        _selectView.userInteractionEnabled = NO;
    }
    return _selectView;
}

- (UIImageView *)topView{
    if (!_topView) {
        _topView = [[UIImageView alloc]init];
        _topView.contentMode = UIViewContentModeScaleAspectFit;
        _topView.userInteractionEnabled = NO;
    }
    return  _topView;
}

- (UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel = [[UILabel alloc]init];
        [_bottomLabel setFont:TiFontRegular(10)];
        _bottomLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _bottomLabel;
}

- (instancetype)initWithScaling:(CGFloat)scaling withMakeUp:(BOOL)isMakeUp{
    
    self = [super init];
    if (self) {
        [self addSubview:self.selectView];
        [self.selectView addSubview:self.topView];
        [self addSubview:self.bottomLabel];
        self.is_white = false;
        
        [self.selectView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.mas_equalTo(self.mas_width);
        }];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.selectView.mas_centerX);
            make.centerY.equalTo(self.selectView.mas_centerY);
            make.width.mas_equalTo(self.selectView.mas_width).multipliedBy(scaling);
            make.height.mas_equalTo(self.selectView.mas_width).multipliedBy(scaling);
        }];
        if (isMakeUp) {
            // 设置矩形四个圆角半径
            [self.selectView.layer setMasksToBounds:YES];
            [self.selectView.layer setCornerRadius:6];
            [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(self.topView.mas_bottom).offset([[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:8]);
            }];
        }else{
            [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.bottom.equalTo(self.mas_bottom).offset(-[[TiPSAdapter shareInstance] widthAfterAdaptionByRawWidth:2]);
            }];
        }
        
    }
    return self;
}

- (void)setScaling:(CGFloat)scaling{
    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.selectView.mas_width).multipliedBy(scaling);
        make.height.mas_equalTo(self.selectView.mas_width).multipliedBy(scaling);
    }];
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        [self.topView setImage:self.selectedImage];
        [self.bottomLabel setText:NSLocalizedString(self.selectedTitle,nil)];
        [self.bottomLabel setTextColor:self.selectedColor];
        if (self.selectedBorderColor) {
            self.selectView.layer.borderWidth = self.selectedBorderW;
            self.selectView.layer.borderColor = self.selectedBorderColor.CGColor;
            // 设置矩形四个圆角半径
            [self.selectView.layer setMasksToBounds:YES];
            [self.selectView.layer setCornerRadius:6];
        }
        if (self.cellmaskView) {
            [self.cellmaskView setHidden:NO];
        }
    }else{
        [self.topView setImage:self.normalImage];
        [self.bottomLabel setText:NSLocalizedString(self.normalTitle,nil)];
        [self.bottomLabel setTextColor:self.normalColor];
        if (self.is_white == true) {
            [self.bottomLabel setTextColor:UIColor.whiteColor];
        }else{
            [self.bottomLabel setTextColor:self.normalColor];
        }
        if (self.normalBorderColor) {
            self.selectView.layer.borderWidth = self.normalBorderW;
            self.selectView.layer.borderColor = self.normalBorderColor.CGColor;
        }
        if (self.cellmaskView) {
            [self.cellmaskView setHidden:YES];
        }
    }
}

- (void)setRoundSelected:(BOOL)selected width:(CGFloat)width{
    
    if (selected) {
        [self.topView setImage:self.selectedImage];
        [self.bottomLabel setText:NSLocalizedString(self.selectedTitle,nil)];
        [self.bottomLabel setTextColor:self.selectedColor];
        if (self.selectedBorderColor) {
            self.selectView.layer.borderWidth = self.selectedBorderW;
            self.selectView.layer.borderColor = self.selectedBorderColor.CGColor;
            // 设置矩形四个圆角半径
            [self.selectView.layer setMasksToBounds:YES];
            [self.selectView.layer setCornerRadius:width/2];
        }
    }else{
        [self.topView setImage:self.normalImage];
        [self.bottomLabel setText:NSLocalizedString(self.normalTitle,nil)];
        [self.bottomLabel setTextColor:self.normalColor];
        if (self.normalBorderColor) {
            self.selectView.layer.borderWidth = self.normalBorderW;
            self.selectView.layer.borderColor = self.normalBorderColor.CGColor;
        }
    }
    
}

- (void)setTitle:(nullable NSString *)title withImage:(nullable UIImage *)image withTextColor:(nullable UIColor *)color forState:(UIControlState)state
{
    [self setHiddenView:NO];
    [self.classTextLabel setHidden:YES];
    [self.classMaskView setHidden:YES];
    [self.classPointView setHidden:YES];
    
    if (title == nil && color == nil) {
        self.topView.layer.masksToBounds = YES;
        self.topView.layer.cornerRadius = 4;
    }
    switch (state) {
        case UIControlStateNormal:
            self.normalTitle = title;
            self.normalImage = image;
            self.normalColor = color;
            break;
        case UIControlStateSelected:
            self.selectedTitle = title;
            self.selectedImage = image;
            self.selectedColor = color;
            break;
        default:
            self.normalTitle = title;
            self.normalImage = image;
            self.normalColor = color;
            break;
    }
    [self setSelected:NO];
}

- (void)setTextFont:(UIFont *)font{
    [self.bottomLabel setFont:font];
}

- (void)setSelectedText:(NSString *)text{
    [self.selectedLabel setText:NSLocalizedString(text,nil)];
}

- (void)setBorderWidth:(CGFloat)W BorderColor:(UIColor *)color forState:(UIControlState)state{
    switch (state) {
        case UIControlStateNormal:
            self.normalBorderW = W;
            if (color) {
                self.normalBorderColor =color;
            }else{
                self.normalBorderColor = self.topView.backgroundColor;
            }
            break;
        case UIControlStateSelected:
            self.selectedBorderW = W;
            if (color) {
                self.selectedBorderColor = color;
            }else{
                self.selectedBorderColor = self.selectedColor;
            }
            break;
        default:
            break;
    }
}

// 遮罩层
- (void)setViewforState{
    if (!self.cellmaskView) {
        self.cellmaskView = [[UIView alloc]init];
        [self.cellmaskView setBackgroundColor:TiColor(88.0, 221.0, 221.0, 0.6)];
        [self addSubview:self.cellmaskView];
        [self.cellmaskView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.topView);
            make.height.mas_equalTo(TiPSWithoutSwitchViewCellHeight);
        }];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_select_ps.png"]];
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self.cellmaskView addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self.topView);
        }];
        self.selectedLabel = [[UILabel alloc] init];
        [self.cellmaskView addSubview:self.selectedLabel];
        self.selectedLabel.textColor = UIColor.whiteColor;
        self.selectedLabel.font = TiFontRegular(10);
        [self.selectedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.equalTo(self.bottomLabel);
        }];
    }
}

- (void)setClassifyText:(nullable NSString *)title withTextColor:(nullable UIColor *)color{
    
    [self setHiddenView:YES];
    if ([title  isEqual: @"point"]) {
        [self.classTextLabel setHidden:YES];
        [self.classMaskView setHidden:YES];
        [self.classPointView setHidden:NO];
        if (!self.classPointView) {
            self.classPointView = [[UIView alloc] init];
            self.classPointView.backgroundColor = color;
            self.classPointView.layer.masksToBounds = YES;
            self.classPointView.layer.cornerRadius = 2;
            [self addSubview:self.classPointView];
            [self.classPointView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(4);
                make.centerX.centerY.equalTo(self);
            }];
        }else{
            self.classPointView.backgroundColor = color;
        }
    }else{
        [self.classTextLabel setHidden:NO];
        [self.classMaskView setHidden:NO];
        [self.classPointView setHidden:YES];
        if (!self.classTextLabel) {
            self.classTextLabel = [[UILabel alloc] init];
            self.classTextLabel.numberOfLines = 0;
            // 竖向显示文字
            [self.classTextLabel sizeToFit];
            self.classTextLabel.textAlignment = NSTextAlignmentLeft;
            [self.classTextLabel setTextColor:color];
            [self.classTextLabel setFont:TiFontRegular(10)];
            [self addSubview:self.classTextLabel];
            [self.classTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@12);
                make.centerX.centerY.equalTo(self);
            }];
        }
        self.classTextLabel.text = NSLocalizedString(title,nil);
        
        if (!self.classMaskView) {
            self.classMaskView = [[UIView alloc]init];
            [self.classMaskView setBackgroundColor:TiColor(88.0, 221.0, 221.0, 0.4)];
            [self addSubview:self.classMaskView];
            // 调整层级关系
            [self bringSubviewToFront:self.classTextLabel];
            [self sendSubviewToBack:self.classMaskView];
            [self.classMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(@5);
                make.top.equalTo(self.classTextLabel).offset(6);
                make.bottom.equalTo(self.classTextLabel.mas_bottom).offset(-6);
                make.centerY.equalTo(self);
                make.left.equalTo(self.classTextLabel).offset(5);
            }];
        }
    }
    
}

- (void)setHiddenView:(BOOL)YESNO{
    [self.selectView setHidden:YESNO];
    [self.topView setHidden:YESNO];
    [self.bottomLabel setHidden:YESNO];
    [self.selectedLabel setHidden:YESNO];
    [self.cellmaskView setHidden:YESNO];
}

@end
