//
//  DYJianXunView.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/4.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYJianXunView.h"
#import <UIImageView+WebCache.h>
#import "DYZiXun.h"

@interface DYJianXunView ()

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *publishDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountlabel;
@property (weak, nonatomic) IBOutlet UIImageView *icon;


@end

@implementation DYJianXunView

+ (instancetype)jianXunView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setZixun:(DYZiXun *)zixun {
    _zixun = zixun;
    self.tagLabel.text = zixun.tag;
    self.titleLabel.text = zixun.title;
    self.contentLabel.text = zixun.content;
    self.publishDateLabel.text = zixun.publishDate;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:zixun.img1] placeholderImage:[UIImage imageNamed:@"actor_default_image_100x100"]];
    self.commentCountlabel.text = [NSString stringWithFormat:@"%zd", zixun.commentCount];
}

@end
