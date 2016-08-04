//
//  DYYingPingView.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/4.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYYingPingView.h"
#import <UIImageView+WebCache.h>
#import "DYZiXun.h"
#import "NSString+DYExt.h"
#import "UIImage+DYExt.h"
#import "DYMovieInZiXun.h"

@interface DYYingPingView ()

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UIImageView *movieIcon;

@end

@implementation DYYingPingView

- (void)setZixun:(DYZiXun *)zixun {
    _zixun = zixun;
    self.tagLabel.text = zixun.tag;
    self.titleLabel.text = zixun.title;
    self.contentLabel.text = [NSString trimedSpaceReturnWithString:zixun.summaryInfo];
    UIImage *placeHolder = [[UIImage imageNamed:@"actor_default_image_100x100"] circleImage];
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:zixun.userImage] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.userIcon.image = image ? [image circleImage] : placeHolder;
    }];
    self.userName.text = zixun.nickname;
    DYMovieInZiXun *movie = zixun.movieInZiXun;
    self.movieName.text = [NSString stringWithFormat:@"《%@》", movie.titleCn];
    if (zixun.rating <= 0) {
        self.rating.hidden = YES;
    } else {
        self.rating.hidden = NO;
        self.rating.text = [NSString stringWithFormat:@"%.1f", zixun.rating];
    }
    [self.movieIcon sd_setImageWithURL:[NSURL URLWithString:movie.image] placeholderImage:[UIImage imageNamed:@"actor_default_image_100x100"]];
}

+ (instancetype)yingPingView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
