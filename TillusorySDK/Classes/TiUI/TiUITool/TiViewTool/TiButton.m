//
//  TiUIButton.m
//  TiSDKDemo
//
//  Created by iMacA1002 on 2019/12/4.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiButton.h"
#import "TiUIConfig.h"

@interface TiIndicatorAnimationView ()

@property(nonatomic,assign)CGFloat angle;
@property(nonatomic,strong)UIImageView *loadingView;

@end

@implementation TiIndicatorAnimationView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.hidden = YES;
        self.angle = 0;
        self.loadingView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_loading"]];
        [self addSubview:self.loadingView];
        [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.bottom.equalTo(self).offset(-10);
        }];
    }
    return self;
}

- (void)startAnimation
{
    self.hidden = NO;
    [self setAnimation];
}

- (void)endAnimation
{
    self.hidden = YES;
    [self.layer removeAllAnimations];
}

- (void)setAnimation{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(self.angle * (M_PI / 180.0f));
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.transform = endAngle;
    } completion:^(BOOL finished) {
        if (finished) {
            self.angle += 30;
            [self startAnimation];
        }
    }];
}
//1.画线条（实线，虚线）
//- (void)drawRect:(CGRect)rect
//{
//
//     CGContextRef contextRef = UIGraphicsGetCurrentContext(); //获取绘制上下文对象实例
//
//    //    [UIColor colorWithRed:88/255.0 green:221/255.0 blue:221/255.0 alpha:1.0]
//        CGContextSetRGBStrokeColor(contextRef, 0.345f, 0.866f, 0.866f, 1.0); //设置笔画颜色
//        CGContextSetLineWidth(contextRef, 3); //设置线条粗细大小
//
//    //voidCGContextAddArc(CGContextRef c,CGFloat x,CGFloat y,CGFloat radius,CGFloat startAngle,CGFloat endAngle,int clockwise)
//    //1弧度＝180°/π（≈57.3°）度
//    //360°＝360 * π/180＝2π弧度
//    //x,y为圆点坐标，radius半径，startAngle为开始的弧度，endAngle为结束的弧度，clockwise0为顺时针，1为逆时针。
//           CGContextAddArc(contextRef, rect.size.width/2, rect.size.height/2, rect.size.width/2 - 5, 1.5*M_PI, 0, 1);
//
//    //添加一个圆；M_PI为180度
//       CGContextDrawPath(contextRef, kCGPathStroke); //绘制路径
//}
//
@end

@interface TiButton ()

@property(nonatomic,strong)UIView *selectView;
@property(nonatomic,strong)UIImageView *topView;
@property(nonatomic,strong)UILabel *bottomLabel;
// 一键美颜文字被选中
@property(nonatomic,strong)UILabel *selectedLabel;

@property(nonatomic,strong)UIImageView *downloadView;
@property(nonatomic,strong)TiIndicatorAnimationView *indicatorView;
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

// 分类文字
@property(nonatomic ,strong)UILabel *classTextLabel;
// 分类遮罩层
@property(nonatomic ,strong)UIView *classMaskView;
// 分类圆点
@property(nonatomic ,strong)UIView *classPointView;

@property(nonatomic,assign)BOOL is_white;

@end

@implementation TiButton

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

- (UIImageView *)downloadView{
    if (!_downloadView) {
        _downloadView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ic_download.png"]];
        _downloadView.contentMode = UIViewContentModeScaleAspectFit;
        _downloadView.hidden = YES;
        _downloadView.userInteractionEnabled = NO;
    }
    return _downloadView;
}

- (TiIndicatorAnimationView *)indicatorView{
    if (!_indicatorView) {
        _indicatorView = [[TiIndicatorAnimationView alloc]init];
    }
    return _indicatorView;
}

- (instancetype)initWithScaling:(CGFloat)scaling withMakeUp:(BOOL)isMakeUp{
    
    self = [super init];
    if (self) {
        [self addSubview:self.selectView];
        [self.selectView addSubview:self.topView];
        [self addSubview:self.bottomLabel];
        [self addSubview:self.downloadView];
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
                make.top.equalTo(self.topView.mas_bottom).offset([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:8]);
            }];
        }else{
            [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.bottom.equalTo(self.mas_bottom).offset(-[[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:2]);
            }];
        }
        [self.downloadView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).offset(-1);
            make.bottom.equalTo(self.mas_bottom).offset(-1);
            make.width.height.mas_offset(15);
        }];
        
        [self.selectView addSubview:self.indicatorView];
        [self.indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(self.selectView).offset([[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:5]);
            make.right.bottom.equalTo(self.selectView).offset(-[[TiUIAdapter shareInstance] widthAfterAdaptionByRawWidth:5]);
        }];
        
    }
    // 注册通知——改变文本颜色
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setClassifyColor:) name:@"UpdateTiButtonTextColor" object:nil];
    
    return self;
}

- (void)setScaling:(CGFloat)scaling{
    [self.topView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(self.selectView.mas_width).multipliedBy(scaling);
        make.height.mas_equalTo(self.selectView.mas_width).multipliedBy(scaling);
    }];
}

- (void)setDownloadViewFrame:(TiUIDownloadViewFrame)type{
    switch (type) {
        case downloadViewFrame_equalToSelf:{
            [self.downloadView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.mas_right).offset(-1);
                make.bottom.equalTo(self.mas_bottom).offset(-1);
            }];
        }
            break;
        case downloadViewFrame_equalToImage:{
            [self.downloadView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.selectView.mas_right).offset(0);
                make.bottom.equalTo(self.selectView.mas_bottom).offset(0);
                make.width.height.mas_offset(12);
            }];
        }
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        [self.topView setImage:self.selectedImage];
        [self.bottomLabel setText:NSLocalizedString(self.selectedTitle,nil)];
        [self.bottomLabel setTextColor:self.selectedColor];
        if (self.selectedBorderColor) {
            self.selectView.layer.borderWidth = self.selectedBorderW;
            self.selectView.layer.borderColor = self.selectedBorderColor.CGColor;
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
            make.height.mas_equalTo(TiUISubMenuTwoViewTiButtonHeight);
        }];
        UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_yijian_gouxuan"]];
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

- (void)setClassifyColor:(NSNotification *)notification{
    NSString *color = notification.object;
    if ([color  isEqual: @"black"]) {
        [self.classTextLabel setTextColor:UIColor.blackColor];
    }else if ([color  isEqual: @"white"]){
        [self.classTextLabel setTextColor:UIColor.whiteColor];
    }
}

- (void)setHiddenView:(BOOL)YESNO{
    [self.selectView setHidden:YESNO];
    [self.topView setHidden:YESNO];
    [self.bottomLabel setHidden:YESNO];
    [self.selectedLabel setHidden:YESNO];
    [self.cellmaskView setHidden:YESNO];
}

- (void)setDownloaded:(BOOL)downloaded{
    self.downloadView.hidden = downloaded;
}

- (void)startAnimation{
    self.downloadView.hidden = YES;
    [self.indicatorView startAnimation];
}

- (void)endAnimation{;
    [self.indicatorView endAnimation];
}

- (void)dealloc{
    // 移除通知
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
