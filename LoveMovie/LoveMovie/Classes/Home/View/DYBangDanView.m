//
//  DYBangDanView.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/4.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYBangDanView.h"
#import <UIImageView+WebCache.h>
#import "DYZiXun.h"
#import "DYMovieInBangDan.h"
#import "NSString+DYExt.h"

@interface DYBangDanView ()

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movie1Icon;
@property (weak, nonatomic) IBOutlet UILabel *movie1Rating;
@property (weak, nonatomic) IBOutlet UILabel *movie1Name;
@property (weak, nonatomic) IBOutlet UILabel *movie1Year;

@property (weak, nonatomic) IBOutlet UIImageView *movie2Icon;
@property (weak, nonatomic) IBOutlet UILabel *movie2Rating;
@property (weak, nonatomic) IBOutlet UILabel *movie2Name;
@property (weak, nonatomic) IBOutlet UILabel *movie2Year;

@property (weak, nonatomic) IBOutlet UIImageView *movie3Icon;
@property (weak, nonatomic) IBOutlet UILabel *movie3Rating;
@property (weak, nonatomic) IBOutlet UILabel *movie3Name;
@property (weak, nonatomic) IBOutlet UILabel *movie3Year;

@end

@implementation DYBangDanView

- (void)setZixun:(DYZiXun *)zixun {
    _zixun = zixun;
    self.tagLabel.text = zixun.tag;
    self.titleLabel.text = zixun.title;
    self.contentLabel.text = [NSString trimedSpaceReturnWithString:zixun.Memo];
    if (zixun.movies.count == 1) {
        DYMovieInBangDan *movie1 = zixun.movies[0];
        [self.movie1Icon sd_setImageWithURL:[NSURL URLWithString:movie1.posterUrl]];
        self.movie1Name.text = movie1.name;
        self.movie1Year.text = [NSString stringWithFormat:@"(%zd)", movie1.decade];
        if (movie1.rating <= 0) {
            self.movie1Rating.hidden = YES;
        } else {
            self.movie1Rating.hidden = NO;
            self.movie1Rating.text = [NSString stringWithFormat:@"%.1f", movie1.rating];
        }
    } else if (zixun.movies.count == 2) {
        DYMovieInBangDan *movie1 = zixun.movies[0];
        DYMovieInBangDan *movie2 = zixun.movies[1];
        
        [self.movie1Icon sd_setImageWithURL:[NSURL URLWithString:movie1.posterUrl]];
        self.movie1Name.text = movie1.name;
        self.movie1Year.text = [NSString stringWithFormat:@"(%zd)", movie1.decade];
        if (movie1.rating <= 0) {
            self.movie1Rating.hidden = YES;
        } else {
            self.movie1Rating.hidden = NO;
            self.movie1Rating.text = [NSString stringWithFormat:@"%.1f", movie1.rating];
        }
        
        [self.movie2Icon sd_setImageWithURL:[NSURL URLWithString:movie2.posterUrl]];
        self.movie2Name.text = movie2.name;
        self.movie2Year.text = [NSString stringWithFormat:@"(%zd)", movie2.decade];
        if (movie2.rating <= 0) {
            self.movie2Rating.hidden = YES;
        } else {
            self.movie2Rating.hidden = NO;
            self.movie2Rating.text = [NSString stringWithFormat:@"%.1f", movie2.rating];
        }
    } else if (zixun.movies.count >= 3) {
        DYMovieInBangDan *movie1 = zixun.movies[0];
        DYMovieInBangDan *movie2 = zixun.movies[1];
        DYMovieInBangDan *movie3 = zixun.movies[2];
        
        [self.movie1Icon sd_setImageWithURL:[NSURL URLWithString:movie1.posterUrl]];
        self.movie1Name.text = movie1.name;
        self.movie1Year.text = [NSString stringWithFormat:@"(%zd)", movie1.decade];
        if (movie1.rating <= 0) {
            self.movie1Rating.hidden = YES;
        } else {
            self.movie1Rating.hidden = NO;
            self.movie1Rating.text = [NSString stringWithFormat:@"%.1f", movie1.rating];
        }
        
        [self.movie2Icon sd_setImageWithURL:[NSURL URLWithString:movie2.posterUrl]];
        self.movie2Name.text = movie2.name;
        self.movie2Year.text = [NSString stringWithFormat:@"(%zd)", movie2.decade];
        if (movie2.rating <= 0) {
            self.movie2Rating.hidden = YES;
        } else {
            self.movie2Rating.hidden = NO;
            self.movie2Rating.text = [NSString stringWithFormat:@"%.1f", movie2.rating];
        }
        
        [self.movie3Icon sd_setImageWithURL:[NSURL URLWithString:movie3.posterUrl]];
        self.movie3Name.text = movie3.name;
        self.movie3Year.text = [NSString stringWithFormat:@"(%zd)", movie3.decade];
        if (movie3.rating <= 0) {
            self.movie3Rating.hidden = YES;
        } else {
            self.movie3Rating.hidden = NO;
            self.movie3Rating.text = [NSString stringWithFormat:@"%.1f", movie3.rating];
        }
    }
}

+ (instancetype)bangDanView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}

@end
