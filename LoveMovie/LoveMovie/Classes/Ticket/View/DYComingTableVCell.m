//
//  DYComingTableVCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/17.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYComingTableVCell.h"
#import "DYComingMovie.h"
#import <UIImageView+WebCache.h>

@interface DYComingTableVCell ()

@property (weak, nonatomic) IBOutlet UILabel *showDayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movieIcon;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *wantCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *directorLabel;
@property (weak, nonatomic) IBOutlet UIButton *presaleBtn;
@property (weak, nonatomic) IBOutlet UIButton *reviewBtn;

@end


@implementation DYComingTableVCell

- (void)setMovie:(DYComingMovie *)movie{
    self.showDayLabel.text = [NSString stringWithFormat:@"%02zd日", movie.rDay];
    [self.movieIcon sd_setImageWithURL:[NSURL URLWithString:movie.image] placeholderImage:[UIImage imageNamed:@"movie_default_image_170×254"]];
    self.movieNameLabel.text = movie.movieName;
    self.wantCountLabel.text = [NSString stringWithFormat:@"%zd", movie.wantedCount];
    self.typeLabel.text = [NSString stringWithFormat:@"人想看 - %@", movie.type];
    self.directorLabel.text = movie.director;
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
