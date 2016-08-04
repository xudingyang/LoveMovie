//
//  DYShowingMovieTableVCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/16.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYShowingMovieTableVCell.h"
#import "DYNoHighlitedButton.h"
#import <UIImageView+WebCache.h>
#import "DYHotMovie.h"
#import "NSDate+DYExt.h"

@interface DYShowingMovieTableVCell ()

@property (weak, nonatomic) IBOutlet UIImageView *movieIcon;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *movieScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *specialCommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *beOnDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *showCinameLabel;
@property (weak, nonatomic) IBOutlet UIView *IMaxTagView;
@property (weak, nonatomic) IBOutlet DYNoHighlitedButton *butTicketButton;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tag3DWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagIMAXWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tagDIMAXWidth;
@property (weak, nonatomic) IBOutlet UIImageView *tag3D;
@property (weak, nonatomic) IBOutlet UIImageView *tagIMAX;
@property (weak, nonatomic) IBOutlet UIImageView *tagDMAX;
// 是否今日上映
@property (weak, nonatomic) IBOutlet UIImageView *isShowTodayIcon;


@end




@implementation DYShowingMovieTableVCell

- (void)setHotMovie:(DYHotMovie *)hotMovie{
    _hotMovie = hotMovie;
    // 是否今日上映
    if ([hotMovie.showDate isToday]) {
        self.isShowTodayIcon.hidden = NO;
    } else {
        self.isShowTodayIcon.hidden = YES;
    }
    
    // 电影图片
    [self.movieIcon sd_setImageWithURL:[NSURL URLWithString:hotMovie.moviewIcon] placeholderImage:[UIImage imageNamed:@"movie_default_image_170×254"]];
    // 标题
    self.movieNameLabel.text = hotMovie.movieName;
    // 评分/为-1就不显示
    if (hotMovie.movieScore > 0 && hotMovie.movieScore <= 10) {
        self.movieScoreLabel.hidden = NO;
        self.movieScoreLabel.text =  [NSString stringWithFormat:@"%.1f", hotMovie.movieScore];
    } else {
        self.movieScoreLabel.hidden = YES;
    }
    // 购票/预售/查影讯
    if (!hotMovie.isTicket) {
        [self.butTicketButton setTitle:@"查影讯" forState:UIControlStateNormal];
        [self.butTicketButton setBackgroundImage:[UIImage imageNamed:@"icon_movie_trailer"] forState:UIControlStateNormal];
        [self.butTicketButton setTitleColor:DYRGBColor(103, 156, 33) forState:UIControlStateNormal];
    } else if ([self isPresale]) {
        [self.butTicketButton setTitle:@"预售" forState:UIControlStateNormal];
        [self.butTicketButton setBackgroundImage:[UIImage imageNamed:@"icon_hot_show_see"] forState:UIControlStateNormal];
        [self.butTicketButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    } else {
        [self.butTicketButton setTitle:@"购票" forState:UIControlStateNormal];
        [self.butTicketButton setBackgroundImage:[UIImage imageNamed:@"icon_hot_show_buy"] forState:UIControlStateNormal];
        [self.butTicketButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    // 特别评论/多少人想看-类型
    if (hotMovie.specialComment.length == 0) {
        self.specialCommentLabel.text = [NSString stringWithFormat:@"%zd人想看 - %@", hotMovie.wantedCount, hotMovie.movieType];
        self.specialCommentLabel.textColor = [UIColor darkGrayColor];
    } else {
        self.specialCommentLabel.text = [NSString stringWithFormat:@"“%@”", hotMovie.specialComment];
        self.specialCommentLabel.textColor = DYRGBColor(253, 163, 74);
    }
    // 上映日期
    self.beOnDateLabel.text = hotMovie.showingDay;
    // 今日1家影院上映1场
    self.showCinameLabel.text = [NSString stringWithFormat:@"今日%zd家影院上映%zd场", hotMovie.cinemaCount, hotMovie.showCount];
    // 是否是3D IMAX 中国巨幕
    if (!hotMovie.is3D) {
        self.tag3DWidth.constant = 0;
        self.tag3D.hidden = YES;
        [self.IMaxTagView layoutIfNeeded];
    } else{
        self.tag3D.hidden = NO;
        self.tag3DWidth.constant = 24;
        [self.IMaxTagView layoutIfNeeded];
    }
    if (!hotMovie.isIMAX3D) {
        self.tagIMAXWidth.constant = 0;
        self.tagIMAX.hidden = YES;
        [self.IMaxTagView layoutIfNeeded];
    } else{
        self.tagIMAX.hidden = NO;
        self.tagIMAXWidth.constant = 34;
        [self.IMaxTagView layoutIfNeeded];
    }
    if (!hotMovie.isDMAX) {
        self.tagDIMAXWidth.constant = 0;
        self.tagDMAX.hidden = YES;
        [self.IMaxTagView layoutIfNeeded];
    } else{
        self.tagDMAX.hidden = NO;
        self.tagDIMAXWidth.constant = 48;
        [self.IMaxTagView layoutIfNeeded];
    }
    
}

- (BOOL)isPresale{
    NSDate *today = [NSDate date];
    if ([self.hotMovie.showDate compare:today] == NSOrderedDescending) {
        return YES;
    } else {
        return NO;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.movieNameLabel.text = @"ddf";
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    self.backgroundView = bgView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 按钮事件
- (IBAction)buyTicketClick {
}

@end
