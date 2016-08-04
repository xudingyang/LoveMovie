//
//  DYTouTiao.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/4.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTouTiao.h"
#import <UIImageView+WebCache.h>
#import "DYZiXun.h"

@interface DYTouTiao ()
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *publishDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;

@end

@implementation DYTouTiao

+ (instancetype)touTiaoView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setZixun:(DYZiXun *)zixun {
    _zixun = zixun;
    self.tagLabel.text = zixun.tag;
    self.titleLabel.text = zixun.title;
    self.contentLabel.text = zixun.content;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:zixun.img1] placeholderImage:[UIImage imageNamed:@"actor_default_image_100x100"]];
    self.publishDateLabel.text = zixun.publishDate;
    self.commentCount.text = [NSString stringWithFormat:@"%zd", zixun.commentCount];
}

@end
