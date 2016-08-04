//
//  DYVideoView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/20.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYVideoView.h"
#import "DYNews.h"
#import <UIImageView+WebCache.h>

@interface DYVideoView ()

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UILabel *newsContent;
@property (weak, nonatomic) IBOutlet UILabel *publishDate;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;


@end

@implementation DYVideoView

+ (instancetype)videoView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setNews:(DYNews *)news{
    _news = news;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:news.image] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
    self.newsTitle.text = news.title;
    self.newsContent.text = news.title2;
    self.publishDate.text = news.publishDate;
    self.commentCount.text = [NSString stringWithFormat:@"%zd", news.commentCount];
}
@end
