//
//  DYAttentionColletionVCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/17.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYAttentionColletionVCell.h"
#import "DYComingMovie.h"
#import <UIImageView+WebCache.h>

@interface DYAttentionColletionVCell ()

@property (weak, nonatomic) IBOutlet UILabel *showDayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movieIcon;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wantCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *actorNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *presaleBtn;
@property (weak, nonatomic) IBOutlet UIButton *reviewBtn;


@end


@implementation DYAttentionColletionVCell

- (void)setMovie:(DYComingMovie *)movie{
    _movie = movie;
    self.showDayLabel.text = [NSString stringWithFormat:@"%zd月%zd日", movie.rMonth, movie.rDay];
    [self.movieIcon sd_setImageWithURL:[NSURL URLWithString:movie.image] placeholderImage:[UIImage imageNamed:@"movie_default_image_170×254"]];
    self.movieNameLabel.text = movie.movieName;
    self.wantCountLabel.text = [NSString stringWithFormat:@"%zd", movie.wantedCount];
    self.typeLabel.text = [NSString stringWithFormat:@"人想看 - %@", movie.type];
    self.directorNameLabel.text = [NSString stringWithFormat:@"导演: %@", movie.director];
    self.actorNameLabel.text = [NSString stringWithFormat:@"演员: %@, %@", movie.actor1, movie.actor2];
    if (movie.isTicket) {
        [self.presaleBtn setTitle:@"超前预售" forState:UIControlStateNormal];
        [self.presaleBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.presaleBtn setBackgroundImage:[UIImage imageNamed:@"icon_hot_show_see"] forState:UIControlStateNormal];
    } else {
        [self.presaleBtn setTitle:@"上映提醒" forState:UIControlStateNormal];
        [self.presaleBtn setTitleColor:DYRGBColor(103, 156, 33) forState:UIControlStateNormal];
        [self.presaleBtn setBackgroundImage:[UIImage imageNamed:@"icon_movie_trailer"] forState:UIControlStateNormal];
    }
    if (movie.isVideo) {
        self.reviewBtn.hidden = NO;
        [self.reviewBtn setTitle:@"预告片" forState:UIControlStateNormal];
        [self.reviewBtn setTitleColor:DYRGBColor(103, 156, 33) forState:UIControlStateNormal];
        [self.reviewBtn setBackgroundImage:[UIImage imageNamed:@"icon_movie_trailer"] forState:UIControlStateNormal];
    } else {
        self.reviewBtn.hidden = YES;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
