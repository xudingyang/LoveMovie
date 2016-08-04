//
//  DYNewsHeaderView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/20.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYNewsHeaderView.h"
#import "DYNews.h"
#import <UIImageView+WebCache.h>
#import "DYGlobalTicketListVC.h"
#import "DYNavigationController.h"
#import "DYTabBarController.h"

@interface DYNewsHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitleLabel;


@end

@implementation DYNewsHeaderView

+ (instancetype)newsHeaderView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setNews:(DYNews *)news{
    _news = news;
    [self.bigImageView sd_setImageWithURL:[NSURL URLWithString:news.imageUrl] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
    self.newsTitleLabel.text = news.title;
}

// 跳到全球票房榜之北美票房榜
- (IBAction)globalTicketList {
    DYGlobalTicketListVC *vc = [[DYGlobalTicketListVC alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;

    [currentNav pushViewController:vc animated:YES];
    vc.chooseAreaNumber = DYAmerica;
}

// 跳到全球票房榜之大陆票房榜
- (IBAction)mainLandTicketList {
    DYGlobalTicketListVC *vc = [[DYGlobalTicketListVC alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    
    [currentNav pushViewController:vc animated:YES];
    vc.chooseAreaNumber = DYMainLand;
}

@end
