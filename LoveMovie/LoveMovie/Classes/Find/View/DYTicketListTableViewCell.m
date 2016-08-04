//
//  DYTicketListTableViewCell.m
//  LoveMovie
//
//  Created by on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTicketListTableViewCell.h"
#import "DYMovieInTicketList.h"
#import <UIImageView+WebCache.h>

@interface DYTicketListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *rankNumber;
@property (weak, nonatomic) IBOutlet UIImageView *movieIcon;
@property (weak, nonatomic) IBOutlet UILabel *chineseName;
@property (weak, nonatomic) IBOutlet UILabel *movieScroe;
@property (weak, nonatomic) IBOutlet UILabel *englishName;
@property (weak, nonatomic) IBOutlet UILabel *weekTicket;
@property (weak, nonatomic) IBOutlet UILabel *totalTicket;


@end

@implementation DYTicketListTableViewCell

- (void)setMovie:(DYMovieInTicketList *)movie{
    _movie = movie;
    [self.movieIcon sd_setImageWithURL:[NSURL URLWithString:movie.posterUrl] placeholderImage:[UIImage imageNamed:@"movie_default_image_170×254"]];
    self.chineseName.text = movie.chineseName;
    self.englishName.text = movie.englishName;
    self.movieScroe.text = [NSString stringWithFormat:@"%.1f", movie.rating];
    if (movie.rating <= 0.1) {
        self.movieScroe.hidden = YES;
    } else {
        self.movieScroe.hidden = NO;
    }
    self.weekTicket.text = [NSString stringWithFormat:@"%zd", movie.weekBoxOfficeNum];
    self.totalTicket.text = [NSString stringWithFormat:@"%zd", movie.totalBoxOfficeNum];
    self.rankNumber.text = [NSString stringWithFormat:@"%zd", movie.rankNum];
    if (movie.rankNum == 1) {
        self.rankNumber.backgroundColor = DYRGBColor(253, 134, 36);
    } else if (movie.rankNum == 2) {
        self.rankNumber.backgroundColor = DYRGBColor(103, 156, 33);
    } else if (movie.rankNum == 3) {
        self.rankNumber.backgroundColor = DYRGBColor(18, 119, 193);
    } else {
        self.rankNumber.backgroundColor = DYRGBColor(189, 189, 189);
    }
}



- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
