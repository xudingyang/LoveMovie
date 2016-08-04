//
//  DYTabBarController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/10.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTabBarController.h"
#import "DYTabBar.h"
#import "DYHomeViewController.h"
#import "DYNavigationController.h"
#import "DYMeTableViewController.h"
#import "DYTicketVController.h"
#import "DYFindViewController.h"
#import "DYMallTableViewController.h"

@interface DYTabBarController ()

@end

@implementation DYTabBarController

+ (void)initialize{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    attrs[NSForegroundColorAttributeName] = DYRGBColor(134, 129, 134);
    
    NSMutableDictionary *selectAttrs = [NSMutableDictionary dictionary];
    selectAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectAttrs[NSForegroundColorAttributeName] = DYRGBColor(0, 117, 196);
    
    // 拿到item的外表appearance，统一设置
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectAttrs forState:UIControlStateSelected];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    DYHomeViewController *homeVc = [[DYHomeViewController alloc] init];
    [self setChildViewController:homeVc image:@"home" selectedImage:@"home_on" title:@"首页"];
    
    DYTicketVController *ticketVc = [[DYTicketVController alloc] init];
    [self setChildViewController:ticketVc image:@"payticket" selectedImage:@"payticket_on" title:@"购票"];
    
    DYMallTableViewController *mallVc = [[DYMallTableViewController alloc] init];
    [self setChildViewController:mallVc image:@"store" selectedImage:@"store_on" title:@"商城"];
    
    DYFindViewController *findVc = [[DYFindViewController alloc] init];
    [self setChildViewController:findVc image:@"discover" selectedImage:@"discover_on" title:@"发现"];
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Me" bundle:nil];
    DYMeTableViewController *meVc = [story instantiateInitialViewController];
    meVc.tabBarItem.title = @"我的";
    meVc.tabBarItem.image = [UIImage imageNamed:@"myinfo"];
    meVc.tabBarItem.selectedImage = [UIImage imageNamed:@"myinfo_on"];
    [self addChildViewController:meVc];
    
    DYTabBar *tabBar = [[DYTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
    
}

- (void)setChildViewController:(UIViewController *)viewController image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title{
    
    viewController.tabBarItem.title = title;
    viewController.tabBarItem.image = [UIImage imageNamed:image];
    viewController.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    
    DYNavigationController *nav = [[DYNavigationController alloc] initWithRootViewController:viewController];
    [self addChildViewController:nav];
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

@end
