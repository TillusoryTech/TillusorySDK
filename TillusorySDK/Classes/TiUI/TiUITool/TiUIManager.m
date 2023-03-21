//
//  TiUIManager.m
//
//  Created by iMacA1002 on 2019/12/2.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import "TiUIManager.h"
#import "TiUIConfig.h"

bool isswitch_makeup = false;
bool isswitch_greenEdit = false;

@interface TiUIManager ()

// 添加的视图窗口
@property(nonatomic, strong) UIView *toView;
// 互动贴纸提示语
@property(nonatomic, strong) UILabel *interactionHint;

@end

static TiUIManager *shareManager = NULL;
static dispatch_once_t token;

@implementation TiUIManager

// MARK: --单例初始化方法--
+ (TiUIManager *)shareManager {
    dispatch_once(&token, ^{
        shareManager = [[TiUIManager alloc] init];
    });
    return shareManager;
}

+ (void)releaseShareManager{
    // 只有置成0,GCD才会认为它从未执行过.它默认为0.这样才能保证下次再次调用shareInstance的时候,再次创建对象.
    token = 0;
    shareManager = nil;
}

- (instancetype)init
{
    self = [super init];
    return self;
}

// MARK: --懒加载--
- (UIWindow *)superWindow{
    if (!_superWindow) {
        _superWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _superWindow.windowLevel = UIWindowLevelAlert;
        _superWindow.userInteractionEnabled = YES;
        [_superWindow makeKeyAndVisible];
        // 初始隐藏
        _superWindow.hidden = YES;
    }
    return _superWindow;
}

- (TiUIDefaultButtonView *)defaultButton{
    
    if (!_defaultButton) {
        _defaultButton = [[TiUIDefaultButtonView alloc]initWithFrame:CGRectMake(0, TiUIScreenHeight - TiUIViewBoxTotalHeight, TiUIScreenWidth, TiUIViewBoxTotalHeight)];
        WeakSelf;
        [_defaultButton setOnClickBlock:^(NSInteger tag) {
            switch (tag) {
                case 0:
                case 3:
                    // 显示美颜UI
                    [weakSelf showMainMenuView];
                    break;
                case 1:
                    // 拍照（截图）
                    [weakSelf.delegate didClickCameraCaptureButton];
                    break;
                case 2:
                    // 切换摄像头
                    [weakSelf.delegate didClickSwitchCameraButton];
                    break;
                default:
                    break;
            }
        }];
    }
    return _defaultButton;
    
}

- (UIView *)exitTapView{
    if (!_exitTapView) {
        _exitTapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, TiUIScreenWidth, TiUIScreenHeight - TiUIViewBoxTotalHeight)];
        _exitTapView.hidden = YES;
        _exitTapView.userInteractionEnabled = YES;
        [_exitTapView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onExitTap:)]];
    }
    return _exitTapView;
}

- (TiUIMainMenuView *)tiUIViewBoxView{
    if (!_tiUIViewBoxView) {
        TiUIMainMenuViewModel *viewModel = [[TiUIMainMenuViewModel alloc] initWithAspectRatio:@"full"];
        _tiUIViewBoxView = [[TiUIMainMenuView alloc] initWithFrame:CGRectMake(0,TiUIScreenHeight, TiUIScreenWidth, TiUIViewBoxTotalHeight) withViewModel:viewModel];
    }
    return _tiUIViewBoxView;
}

- (UILabel *)interactionHint{
    if (!_interactionHint) {
        _interactionHint = [[UILabel alloc]init];
        _interactionHint.textColor = [UIColor whiteColor];
        _interactionHint.font = [UIFont systemFontOfSize:14];
        _interactionHint.textAlignment =  NSTextAlignmentCenter;
        _interactionHint.contentMode = UIViewContentModeCenter;
        [_interactionHint sizeToFit];
    }
    return _interactionHint;
}

- (void)setInteractionHintL:(NSString *)hint{
    
    if ([hint isEqualToString:@""]||[hint isEqualToString:NSLocalizedString(@"空", nil)]) {
        [_interactionHint removeFromSuperview];
        _interactionHint = nil;
    }else{
        if (!_interactionHint) {
            if (self.toView) {
                [self.toView addSubview:self.interactionHint];
                [self.interactionHint mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.equalTo(self.toView);
                    make.centerY.equalTo(self.toView.mas_centerY).multipliedBy(1.3);
                }];
                
            }
        }
        _interactionHint.text = hint;
    }
    
}

// MARK: --弹出功能页UI--
- (void)showMainMenuView{
    [self hiddenAllViews:NO];
    self.tiUIViewBoxView.sliderRelatedView.hidden = YES;
    self.tiUIViewBoxView.menuView.hidden = YES;
    self.tiUIViewBoxView.subMenuView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        self.tiUIViewBoxView.frame = CGRectMake(0,TiUIScreenHeight - TiUIViewBoxTotalHeight, TiUIScreenWidth , TiUIViewBoxTotalHeight);
    }];
}

// MARK: --退出手势相关--
- (void)onExitTap:(UITapGestureRecognizer *)recognizer {
    if (isswitch_greenEdit) {
        // 发送通知——切换第三套手势（绿幕编辑）
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TiUIMenuThreeViewCell_isThirdGesture" object:@(true)];
    }else if (isswitch_makeup) {
        // 发送通知——切换第二套手势（美妆）
        [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationName_TIUIMakeUp_isTwoGesture" object:@(true)];
    }else{
        // 判断是否出现重置功能遮罩层
        if (self.tiUIViewBoxView.viewModel.isResetting == false) {
            
            self.tiUIViewBoxView.viewModel.switchByName = @"";
            [self.tiUIViewBoxView.rightBackView setHidden:true];
            if (!self.tiUIViewBoxView.rightBackView.hidden) {
                [self.tiUIViewBoxView.rightBackView setHidden:true];
            }
            if (!self.tiUIViewBoxView.resetBtn.hidden) {
                self.tiUIViewBoxView.resetBtn.hidden = YES;
            }
            if (self.tiUIViewBoxView.isClassifyShow) {
                if ([self.delegate respondsToSelector:@selector(didClickOnExitTap)]) {
                    [self.delegate didClickOnExitTap];
                }
                [self popAllViews];
            }else{
                [self.tiUIViewBoxView showClassifyView];
            }
            
        }
        
    }
    
}

- (void)popAllViews {
    [UIView animateWithDuration:0.3 animations:^{
        self.tiUIViewBoxView.frame = CGRectMake(0,TiUIScreenHeight, TiUIScreenWidth, TiUIViewBoxTotalHeight);
    } completion:^(BOOL finished) {
        [self hiddenAllViews:YES];
    }];
}

- (void)hiddenAllViews:(BOOL)YESNO{
    
    self.tiUIViewBoxView.hidden = YESNO;
    self.exitTapView.hidden = YESNO;
    if (_defaultButton) {
        _defaultButton.hidden = !YESNO;
    }
    if (_superWindow) {
        _superWindow.hidden = YESNO;
    }
}

// MARK: --loadToWindow 相关代码--
- (void)loadToWindowDelegate:(id<TiUIManagerDelegate>)delegate{
    
    self.delegate = delegate;
    self.toView = self.superWindow;
    [self.superWindow addSubview:self.exitTapView];
    [self.superWindow addSubview:self.tiUIViewBoxView];
    
}

- (void)loadToView:(UIView* )view forDelegate:(id<TiUIManagerDelegate>)delegate{
    
    self.delegate = delegate;
    self.toView = view;
    [view addSubview:self.exitTapView];
    [view addSubview:self.tiUIViewBoxView];
    
}

- (UIView*)returnLoadToViewDelegate:(id<TiUIManagerDelegate>)delegate{
    
    self.delegate = delegate;
    UIView *view = [UIView new];
    view.frame = [UIScreen mainScreen].bounds;
    [view addSubview:self.exitTapView];
    [view addSubview:self.tiUIViewBoxView];
    return view;
    
}

// MARK: --destroy释放 相关代码--
- (void)destroy{
    
    _interactionHint.text = @"";
    [_interactionHint removeFromSuperview];
    _interactionHint = nil;
    
    [_defaultButton removeFromSuperview];
    _defaultButton = nil;
    
    [_exitTapView removeFromSuperview];
    _exitTapView = nil;
    
    [_tiUIViewBoxView removeFromSuperview];
    _tiUIViewBoxView = nil;
    
    [_superWindow removeFromSuperview];
    _superWindow = nil;
    
    [TiUIManager releaseShareManager];
    
}

@end
