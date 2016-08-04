//
//  DYThreePictureView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/20.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYThreePictureView.h"
#import "DYNews.h"
#import <UIImageView+WebCache.h>
#import "DYImagesInNews.h"

@interface DYThreePictureView ()

@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UIView *newsImages;
@property (weak, nonatomic) IBOutlet UILabel *publishDate;
@property (weak, nonatomic) IBOutlet UILabel *commentsCount;


@end

@implementation DYThreePictureView

+ (instancetype)threePictureView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setNews:(DYNews *)news{
    _news = news;
    self.newsTitle.text = news.title;
    self.publishDate.text = news.publishDate;
    self.commentsCount.text = [NSString stringWithFormat:@"%zd", news.commentCount];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imageW = (self.newsImages.width - 5 * 2) / 3;
    CGFloat imageH = self.newsImages.height;
    for (int i = 0; i < self.news.images.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        DYImagesInNews *tmp = self.news.images[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:tmp.url1]placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
        imageView.frame = CGRectMake((imageW + 5) * i, 0, imageW, imageH);
        [self.newsImages addSubview:imageView];
    }
}
@end
