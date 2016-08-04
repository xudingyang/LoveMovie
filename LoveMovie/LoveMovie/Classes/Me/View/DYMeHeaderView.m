//
//  DYMeHeaderView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/11.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYMeHeaderView.h"
#import "DYVerticalButton.h"
#import "DYLoginViewController.h"
#import "DYRegistViewController.h"
#import "DYNavigationController.h"
#import "DYTabBarController.h"
#import "DYGoodsCarViewController.h"

@interface DYMeHeaderView ()
@property (weak, nonatomic) IBOutlet DYVerticalButton *goodsCarBtn;

@end


@implementation DYMeHeaderView

+ (instancetype)meHeaderView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.height = self.goodsCarBtn.y + self.goodsCarBtn.height + 10;
}




#pragma mark - 按钮事件
// 登陆按钮
- (IBAction)loginClick {
    DYLoginViewController *loginVc = [[DYLoginViewController alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    [currentNav pushViewController:loginVc animated:YES];
}

// 注册按钮
- (IBAction)registerClick {
    DYRegistViewController *registVc = [[DYRegistViewController alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    [currentNav pushViewController:registVc animated:YES];
}

// 点击“我的购物车”
- (IBAction)goodsCarClick {
    DYGoodsCarViewController *vc = [[DYGoodsCarViewController alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    [currentNav pushViewController:vc animated:YES];
}

// 点击电影票订单
- (IBAction)movieTicketClick {
    DYLoginViewController *vc = [[DYLoginViewController alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    [currentNav pushViewController:vc animated:YES];
}

// 点击商品订单
- (IBAction)goodsOrderClick {
    DYLoginViewController *vc = [[DYLoginViewController alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    [currentNav pushViewController:vc animated:YES];
}

// 点击礼品卡
- (IBAction)giftCardClick {
    DYLoginViewController *vc = [[DYLoginViewController alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    [currentNav pushViewController:vc animated:YES];
}


@end
