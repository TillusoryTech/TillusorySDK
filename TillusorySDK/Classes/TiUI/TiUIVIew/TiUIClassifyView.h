//
//  TiUIClassifyView.h
//  TiFancy
//
//  Created by iMacA1002 on 2020/4/26.
//  Copyright © 2020 Tillusory Tech. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TiUIClassifyView : UIView

@property (copy, nonatomic)void(^executeShowOrHiddenBlock)(BOOL);
// 美颜分组菜单信息
@property(nonatomic,strong) NSArray *classifyArr;
// 萌颜Block
@property (copy, nonatomic)void(^CutefaceBlock)(NSString * name);

- (void)showView;
- (void)hiddenView;

@end

NS_ASSUME_NONNULL_END
