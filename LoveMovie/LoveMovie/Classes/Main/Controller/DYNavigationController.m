//
//  DYNavigationController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/10.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYNavigationController.h"
#import "DYNoHighlitedButton.h"

@interface DYNavigationController ()

@end

@implementation DYNavigationController

+ (void)initialize {
    // 设置UINavigationBar的字体为白色字体，字号为20。
    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[self class]]];
    // 此图用于设置背景色透明效果
    [bar setBackgroundImage:[UIImage imageNamed:@"icon_top_shadow"] forBarMetrics:UIBarMetricsCompact];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [bar setTitleTextAttributes:attrs];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 为了有渐变的动画效果，且上边的item不消失，需要把背景设置成imageView，而不是image
    UIImageView *navBarBgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"menu_top_bg7"]];
    // 这个self.view不是bar的view，是当前控制器的全屏view
    [self.view insertSubview:navBarBgView belowSubview:self.navigationBar];
    // 为了遮住状态栏，注意加20
    navBarBgView.frame = CGRectMake(0, 0, self.navigationBar.width, self.navigationBar.height + 20);
    self.navBarBgView = navBarBgView;
    // 下边这句，消除透明状态下的bar的横线。
    self.navigationBar.layer.masksToBounds = YES;
    // 打开手势pop功能
    self.interactivePopGestureRecognizer.delegate = nil;
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    // 还原navigationbar，不再透明
    self.navBarBgView.alpha = 1;
    
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        viewController.view.backgroundColor = DYGlobalBackgroundColor;
        
        // 左边item
        DYNoHighlitedButton *backBtn = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"path"] forState:UIControlStateNormal];
        [backBtn sizeToFit];
        backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 4, 0, -4);
        [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        // 右边items
        DYNoHighlitedButton *shareBtn = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
        [shareBtn setImage:[UIImage imageNamed:@"icon_sharing"] forState:UIControlStateNormal];
        [shareBtn sizeToFit];
        [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
        DYNoHighlitedButton *collectBtn = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
        [collectBtn setImage:[UIImage imageNamed:@"icon_bookmark"] forState:UIControlStateNormal];
        [collectBtn sizeToFit];
        [collectBtn addTarget:self action:@selector(collectClick) forControlEvents:UIControlEventTouchUpInside];
        
        // 让左边一个按钮，往左边移一点。即：让两个按钮有点间距
        [collectBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
//        collectBtn.backgroundColor = [UIColor redColor];
        
        UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
        UIBarButtonItem *collcetItem = [[UIBarButtonItem alloc] initWithCustomView:collectBtn];
        
        viewController.navigationItem.rightBarButtonItems = @[shareItem, collcetItem];
    }

    [super pushViewController:viewController animated:YES];
}

- (void)backClick{
    [self popViewControllerAnimated:YES];
    // 还原navigationbar
    self.navBarBgView.alpha = 1;
}

- (void)shareClick{
    DYLog(@"shareClick");
}

- (void)collectClick{
    DYLog(@"collectClick");
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
