//
//  DYTopWindowViewController.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/5.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTopWindowViewController.h"

@interface DYTopWindowViewController ()

@end

@implementation DYTopWindowViewController

static id instance_;

+ (instancetype)sharedTopWindowController {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[self alloc] init];
    });
    return instance_;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [super allocWithZone:zone];
    });
    return instance_;
}

- (id)copyWithZone:(NSZone *)zone{
    return instance_;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

// 状态栏是白色
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

// 点击事件，把keyWindow往上滑
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

// 递归查找UIScrollView
- (void)searchScrollViewInView:(UIView *)superView{
    for (UIScrollView *subview in superView.subviews) {
        // 如果是scrollview, 滚动最顶部
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingOnKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        // 继续查找子控件
        [self searchScrollViewInView:subview];
    }
}

@end
