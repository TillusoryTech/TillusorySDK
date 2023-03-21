//
//  TiUIDefaultButtonView.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiUIDefaultButtonView.h"
#import "TiUIConfig.h"

@interface TiUIDefaultButtonView ()


@end

@implementation TiUIDefaultButtonView

// MARK: --懒加载--
- (UIButton *)mainSwitchButton{
    if (!_mainSwitchButton){
        _mainSwitchButton = [[UIButton alloc] init];
        [_mainSwitchButton setTag:0];
        [_mainSwitchButton setImage:[UIImage imageNamed:@"icon_gongneng_white.png"] forState:UIControlStateNormal];
        [_mainSwitchButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mainSwitchButton;
}

- (UIButton *)cameraCaptureButton{
    if (!_cameraCaptureButton) {
        _cameraCaptureButton = [[UIButton alloc] init];
        [_cameraCaptureButton setTag:1];
        [_cameraCaptureButton setImage:[UIImage imageNamed:@"btn_paizhao.png"] forState:UIControlStateNormal];
        [_cameraCaptureButton setImage:[UIImage imageNamed:@"btn_paizhao.png"] forState:UIControlStateSelected];
        [_cameraCaptureButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cameraCaptureButton;
}

- (UIButton *)switchCameraButton{
    if (!_switchCameraButton) {
        _switchCameraButton = [[UIButton alloc] init];
        [_switchCameraButton setTag:2];
        [_switchCameraButton setImage:[UIImage imageNamed:@"icon_fanzhuan_white.png"] forState:UIControlStateNormal];
        [_switchCameraButton addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchCameraButton;
}

- (UIButton *)TiDemoBtn{
    if (!_TiDemoBtn) {
        _TiDemoBtn = [[UIButton alloc] init];
        [_TiDemoBtn setTag:3];
        [_TiDemoBtn setImage:[UIImage imageNamed:@"btn_gongneng_rukou.png"] forState:UIControlStateNormal];
        [_TiDemoBtn addTarget:self action:@selector(onButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_TiDemoBtn setHidden:YES];
        [_TiDemoBtn setEnabled:NO];
    }
    return _TiDemoBtn;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView{
    [self addSubview:self.mainSwitchButton];
    [self addSubview:self.cameraCaptureButton];
    [self addSubview:self.switchCameraButton];
    [self addSubview:self.TiDemoBtn];
    
    [self.mainSwitchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(TiDefaultButtonWidth/2.5);
        make.top.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(TiDefaultButtonWidth-TiDefaultButtonWidth/2);
    }];
    [self.cameraCaptureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.equalTo(self.mas_centerY).with.offset(-30);
        make.width.height.mas_equalTo(TiDefaultButtonWidth);
    }];
    [self.switchCameraButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-TiDefaultButtonWidth/2.5);
        make.top.equalTo(self.mas_centerY);
        make.width.height.mas_equalTo(TiDefaultButtonWidth-TiDefaultButtonWidth/2);
    }];
    [self.TiDemoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-14);
        make.bottom.equalTo(self).offset((44-TiUIScreenHeight)/2);
        make.width.height.equalTo(@44);
    }];
    [self setDemoLayout];
}

//演示demo 调用此方法
- (void)setDemoLayout{
    [self.mainSwitchButton setHidden:YES];
    [self.cameraCaptureButton setHidden:YES];
    [self.switchCameraButton setHidden:YES];
    [self.TiDemoBtn setHidden:NO];
    [self.TiDemoBtn setEnabled:YES];
}

- (void)onButtonClick:(UIButton *)button{
    if (self.onClickBlock) {
        self.onClickBlock(button.tag);
    }
    
}

//让超出父控件的方法触发响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *view = [super hitTest:point withEvent:event];
    //避免遮挡底部UI
    if (view == self) {
        return nil;
    }
    if (!view) {
        //转换坐标系
        CGPoint newPointYes = [self.TiDemoBtn convertPoint:point fromView:self];
        //判断触摸点是否在button上
        if (CGRectContainsPoint(self.TiDemoBtn.bounds, newPointYes)) {
            //resetYesBtn就是我们想点击的控件，让这个控件作为可点击的view返回
            view = self.TiDemoBtn;
        }
    }
    return view;
}

@end
