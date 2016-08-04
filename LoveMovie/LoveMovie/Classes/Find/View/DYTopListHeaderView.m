//
//  DYTopListHeaderView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTopListHeaderView.h"
#import "DYTopList.h"
#import <UIImageView+WebCache.h>
#import "DYGlobalTicketListVC.h"
#import "DYNavigationController.h"
#import "DYTabBarController.h"
#import "DYTop100TableVC.h"

@interface DYTopListHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *bigIconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end

@implementation DYTopListHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBigImage)];
    self.bigIconView.userInteractionEnabled = YES;
    [self.bigIconView addGestureRecognizer:gesture];
}

- (void)tapBigImage{
    DYTop100TableVC *vc = [[DYTop100TableVC alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    vc.top100VcType = DYChineseTop100;
    vc.topListId = self.topList.topListID;
    vc.top100VcType = DYBigTop100;
    [currentNav pushViewController:vc animated:YES];
}

+ (instancetype)topListHeaderView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setTopList:(DYTopList *)topList{
    _topList = topList;
    self.titleLabel.text = topList.title;
    [self.bigIconView sd_setImageWithURL:[NSURL URLWithString:topList.imageUrl] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
}

// 跳到全球票房榜
- (IBAction)globalTicketList {
    DYGlobalTicketListVC *vc = [[DYGlobalTicketListVC alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    
    [currentNav pushViewController:vc animated:YES];
    vc.chooseAreaNumber = DYAmerica;
}
- (IBAction)chineseTop100 {
    DYTop100TableVC *vc = [[DYTop100TableVC alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    vc.top100VcType = DYChineseTop100;
    vc.title = @"华语Top100";
    [currentNav pushViewController:vc animated:YES];
}
- (IBAction)timeTop100 {
    DYTop100TableVC *vc = [[DYTop100TableVC alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    vc.top100VcType = DYTimeTop100;
    vc.title = @"时光Top100";
    [currentNav pushViewController:vc animated:YES];
}

@end
