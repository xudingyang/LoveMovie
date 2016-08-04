//
//  DYTop100TableViewCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTop100TableViewCell.h"
#import "DYMovieInTicketList.h"
#import <UIImageView+WebCache.h>

@interface DYTop100TableViewCell () <UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *rankNum;
@property (weak, nonatomic) IBOutlet UIImageView *movieIcon;
@property (weak, nonatomic) IBOutlet UILabel *chineseName;
@property (weak, nonatomic) IBOutlet UILabel *movieScore;
@property (weak, nonatomic) IBOutlet UILabel *englishName;
@property (weak, nonatomic) IBOutlet UILabel *showDateAndArea;
@property (weak, nonatomic) IBOutlet UILabel *actorName;
@property (weak, nonatomic) IBOutlet UILabel *directorName;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@end


@implementation DYTop100TableViewCell

- (void)awakeFromNib{
    [super awakeFromNib];
    self.remarkLabel.userInteractionEnabled = YES;
    UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(remarkClick)];
    [self.remarkLabel addGestureRecognizer:gesture];
}

- (void)setMovie:(DYMovieInTicketList *)movie{
    _movie = movie;
    self.remarkLabel.text = movie.remark;
    if (self.isBig == NO) {
        self.remarkLabel.numberOfLines = 2;
        [self.remarkLabel sizeToFit];
    } else {
        self.remarkLabel.numberOfLines = 0;
        [self.remarkLabel sizeToFit];
    }
    
    [self.movieIcon sd_setImageWithURL:[NSURL URLWithString:movie.posterUrl] placeholderImage:[UIImage imageNamed:@"movie_default_image_170×254"]];
    self.chineseName.text = movie.chineseName;
    self.englishName.text = movie.englishName;
    if (movie.rating <= 0.1) {
        self.movieScore.hidden = YES;
    } else {
        self.movieScore.hidden = NO;
    }
    self.movieScore.text = [NSString stringWithFormat:@"%.1f", movie.rating];
    self.directorName.text = movie.director;
    self.actorName.text = movie.actor;
    self.showDateAndArea.text = [NSString stringWithFormat:@"%@ %@", movie.releaseDate, movie.releaseLocation];
    self.rankNum.text = [NSString stringWithFormat:@"%zd", movie.rankNum];
    if (movie.rankNum == 1) {
        self.rankNum.backgroundColor = DYRGBColor(253, 134, 36);
    } else if (movie.rankNum == 2) {
        self.rankNum.backgroundColor = DYRGBColor(103, 156, 33);
    } else if (movie.rankNum == 3) {
        self.rankNum.backgroundColor = DYRGBColor(18, 119, 193);
    } else {
        self.rankNum.backgroundColor = DYRGBColor(189, 189, 189);
    }
}

// label手势
- (void)remarkClick{

    if ([self.delegate respondsToSelector:@selector(labelDidTapTop100Cell:)]) {
        
        self.isBig = !self.isBig;
        
        [self.delegate labelDidTapTop100Cell:self];
    }
}

@end
