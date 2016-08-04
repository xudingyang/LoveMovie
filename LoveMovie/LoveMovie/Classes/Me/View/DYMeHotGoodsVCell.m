//
//  DYMeHotGoodsVCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/13.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYMeHotGoodsVCell.h"
#import "DYMeHotGoods.h"
#import <UIImageView+WebCache.h>
#import "DYMeWebViewController.h"
#import "DYTabBarController.h"
#import "DYNavigationController.h"

@interface DYMeHotGoodsVCell ()
@property (weak, nonatomic) IBOutlet UILabel *goodsTagLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsIconView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;

@end

@implementation DYMeHotGoodsVCell

- (void)setHotGoods:(DYMeHotGoods *)hotGoods{
    _hotGoods = hotGoods;
    if (hotGoods.iconText.length == 0) {
        self.goodsTagLabel.hidden = YES;
    } else {
        self.goodsTagLabel.text = hotGoods.iconText;
    }
    self.goodsNameLabel.text = hotGoods.name;
    CGFloat price = hotGoods.marketPrice / 100.0;
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"¥%.1f", price];
    [self.goodsIconView sd_setImageWithURL:[NSURL URLWithString:hotGoods.image] placeholderImage:[UIImage imageNamed:@"actor_default_image_100x100"]];
}


+ (instancetype)meHotGoodsCell{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


- (IBAction)clickCell:(UITapGestureRecognizer *)sender {
    DYMeWebViewController *vc = [[DYMeWebViewController alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
//    vc.hotGoods = self.hotGoods;
    vc.url = self.hotGoods.url;
    [currentNav pushViewController:vc animated:YES];
}
@end
