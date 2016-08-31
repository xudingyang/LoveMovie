//
//  DYDetailReviewHeader.m
//  LoveMovie
//
//  Created by xudingyang on 16/8/15.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYDetailReviewHeader.h"
#import <UIImageView+WebCache.h>
#import "UIImage+DYExt.h"
#import "DYDetailReview.h"

@interface DYDetailReviewHeader ()

@property (weak, nonatomic) IBOutlet UILabel *commentTitle;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *commentTime;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *commentNote;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UIImageView *movieIcon;

@end

@implementation DYDetailReviewHeader

- (void)setDetailReview:(DYDetailReview *)detailReview {
    _detailReview = detailReview;
    // 时间
    self.commentTitle.text = detailReview.time;
    // 头像
    UIImage *placeHolder = [[UIImage imageNamed:@"icon_avatar_default_image_55x55"] circleImage];
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:detailReview.userImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.userIcon.image = image ? [image circleImage] : placeHolder;
    }];
    // 昵称
    self.userName.text = detailReview.nickname;
    // 评分
    self.rating.text = [NSString stringWithFormat:@"%.1f", detailReview.rating];
    // 电影图片
    [self.movieIcon sd_setImageWithURL:[NSURL URLWithString:detailReview.topImgUrl] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
    // 影评标题
    self.commentTitle.text = detailReview.title;
}

- (void)setMovieName:(NSString *)movieName {
    _movieName = movieName;
    // 电影名称
    self.commentNote.text = [NSString stringWithFormat:@"评《%@》", movieName];
}

+ (instancetype)detailReviewHeader {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
