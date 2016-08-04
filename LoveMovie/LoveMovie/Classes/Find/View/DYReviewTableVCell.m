//
//  DYReviewTableVCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/20.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYReviewTableVCell.h"
#import "DYReview.h"
#import <UIImageView+WebCache.h>
#import "DYMovieInReview.h"
#import "UIImage+DYExt.h"

@interface DYReviewTableVCell ()

@property (weak, nonatomic) IBOutlet UILabel *commentTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIconView;
@property (weak, nonatomic) IBOutlet UILabel *userNickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movieIconView;


@end


@implementation DYReviewTableVCell


- (void)setReview:(DYReview *)review{
    _review = review;
    self.commentTitleLabel.text = review.title;
    self.commentLabel.lineBreakMode = NSLineBreakByCharWrapping;
    self.commentLabel.text = [review.summary stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    UIImage *placeHolder = [[UIImage imageNamed:@"icon_avatar_default_image_55x55"] circleImage];
    [self.userIconView sd_setImageWithURL:[NSURL URLWithString:review.userImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.userIconView.image = image ? [image circleImage] : placeHolder;
    }];
    
    self.userNickNameLabel.text = [NSString stringWithFormat:@"%@ - 评", review.nickname];
    self.movieNameLabel.text = [NSString stringWithFormat:@"《%@》", review.movie.title];
    [self.movieIconView sd_setImageWithURL:[NSURL URLWithString:review.movie.image] placeholderImage:[UIImage imageNamed:@"movie_default_image_170×254"]];
    if ([review.rating floatValue] <= 0.0) {
        self.commentScoreLabel.hidden = YES;
    } else {
        self.commentScoreLabel.hidden = NO;
        self.commentScoreLabel.text = review.rating;
    }
}

@end
