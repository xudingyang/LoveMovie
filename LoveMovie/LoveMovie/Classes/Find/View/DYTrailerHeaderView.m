//
//  DYTrailerHeaderView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTrailerHeaderView.h"
#import <UIImageView+WebCache.h>
#import "DYTrailer.h"
#import "DYVideoPlayViewController.h"

@interface DYTrailerHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *bigIconView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation DYTrailerHeaderView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.bigIconView.userInteractionEnabled = YES;
}

- (void)tapGest {
    DYTrailer *trailer = self.trailer;
    DYVideoPlayViewController *playVc = [[DYVideoPlayViewController alloc] init];
    playVc.vedioName = trailer.title;
    playVc.hightUrl = trailer.hightUrl;
    
    UIViewController *vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    [vc presentViewController:playVc animated:YES completion:nil];
}

+ (instancetype)trailerHeaderView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setTrailer:(DYTrailer *)trailer{
    _trailer = trailer;
    self.titleLabel.text = trailer.title;
    [self.bigIconView sd_setImageWithURL:[NSURL URLWithString:trailer.imageUrl] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
    
    UIGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGest)];
    [self.bigIconView addGestureRecognizer:gest];
}

@end
