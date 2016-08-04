//
//  DYRelatedNewsView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYRelatedNewsView.h"
#import "DYRelatedNews.h"
#import <UIImageView+WebCache.h>

@interface DYRelatedNewsView ()

@property (weak, nonatomic) IBOutlet UILabel *newsCount;
@property (weak, nonatomic) IBOutlet UILabel *mainTitle;
@property (weak, nonatomic) IBOutlet UILabel *lessTitle;
@property (weak, nonatomic) IBOutlet UILabel *publishDate;
@property (weak, nonatomic) IBOutlet UIImageView *newsIcon;


@end

@implementation DYRelatedNewsView

+ (instancetype)relatedNewsView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}


- (void)setRelatedNews:(DYRelatedNews *)relatedNews{
    _relatedNews = relatedNews;
    [self.newsIcon sd_setImageWithURL:[NSURL URLWithString:relatedNews.image] placeholderImage:[UIImage imageNamed:@"actor_default_image_100x100"]];
    self.mainTitle.text = relatedNews.title;
    self.lessTitle.text = relatedNews.title2;
    self.publishDate.text = relatedNews.publishDate;
    self.newsCount.text = [NSString stringWithFormat:@"%zd", relatedNews.newCount];
}

- (IBAction)topBtnClick {
    DYLog(@"新闻上");
}

- (IBAction)bottomBtnClick {
    DYLog(@"新闻下");
}

@end
