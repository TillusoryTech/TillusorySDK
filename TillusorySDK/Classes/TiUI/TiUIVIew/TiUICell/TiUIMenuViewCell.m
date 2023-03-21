//
//  TiUIMenuViewCell.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiUIMenuViewCell.h"

@interface TiUIMenuViewCell ()

@property(nonatomic,strong)UILabel *textLabel;
@property(nonatomic,strong)UIView *view;

@end

@implementation TiUIMenuViewCell

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc]init];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.userInteractionEnabled = YES;
        _textLabel.font = TiFontRegular(13);
        _textLabel.textColor = TiColors(149.0,1.0);
        //取消响应、避免冲突
        _textLabel.userInteractionEnabled = NO;
        [_textLabel sizeToFit];
    }
    return _textLabel;
}

- (UIView *)view{
    if (!_view) {
        _view = [[UIView alloc]init];
        _view.backgroundColor = TiColor(88.0,221.0,221.0,1.0);
        _view.layer.cornerRadius = 1;
    }
    return _view;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self);
        }];
        [self addSubview:self.view];
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self);
            make.centerX.equalTo(self.textLabel);
            make.width.equalTo(@20);
            make.height.equalTo(@2);
        }];
    }
    return self;
}

- (void)setMenuMode:(TIMenuMode *)menuMode{
    
    if (menuMode) {
        _menuMode = menuMode;
        //更新约束
        self.textLabel.text = NSLocalizedString(menuMode.name,nil);
        BOOL highlighted = menuMode.selected;
        if (highlighted)
        {
            self.textLabel.textColor = TiColor(88.0,221.0,221.0,1.0);
            [self.view setHidden:false];
        }
        else
        {
            [self.textLabel setTextColor:UIColor.whiteColor];
            [self.view setHidden:true];
        }
    }
    
}

@end
