//
//  DYReviewHeaderView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYReviewHeaderView.h"
#import "DYReview.h"
#import <UIImageView+WebCache.h>
#import "DYMovieInReview.h"

@interface DYReviewHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end

@implementation DYReviewHeaderView

+ (instancetype)reviewHeaderView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setReview:(DYReview *)review{
    _review = review;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:review.imageUrl] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
    self.movieNameLabel.text = review.movieName;
    self.commentLabel.text = review.title;
    [self.posterView sd_setImageWithURL:[NSURL URLWithString:review.posterUrl] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
    
    UIGestureRecognizer *ges = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickReview)];
    [self addGestureRecognizer:ges];
}

- (void)clickReview {
    
    !self.tapReview ? : self.tapReview(self.review.reviewID, self.review.movieName);
}

@end
