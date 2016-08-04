//
//  DYXinPianView.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/4.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYXinPianView.h"
#import <UIImageView+WebCache.h>
#import "DYZiXun.h"

@interface DYXinPianView ()

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movieIcon;
@property (weak, nonatomic) IBOutlet UILabel *rating;


@end

@implementation DYXinPianView

+ (instancetype)xinPinView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setZixun:(DYZiXun *)zixun {
    _zixun = zixun;
    self.tagLabel.text = zixun.tag;
    self.titleLabel.text = zixun.titleCn;
    self.contentLabel.text = zixun.titleEn;
    self.textLabel.text = zixun.content;
    self.rating.text = [NSString stringWithFormat:@"%.1f", zixun.rating];
    [self.movieIcon sd_setImageWithURL:[NSURL URLWithString:zixun.image] placeholderImage:[UIImage imageNamed:@"actor_default_image_100x100"]];
}

@end
