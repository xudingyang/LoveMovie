//
//  DYCinemaTableViewCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/2.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYCinemaTableViewCell.h"
#import "DYCinema.h"
#import "DYLocationTool.h"

@interface DYCinemaTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *cinemaName;
@property (weak, nonatomic) IBOutlet UILabel *minPrice;
@property (weak, nonatomic) IBOutlet UILabel *cinemaAddress;
@property (weak, nonatomic) IBOutlet UILabel *cinemaDistance;


@end

@implementation DYCinemaTableViewCell

- (void)setCinema:(DYCinema *)cinema {
    _cinema = cinema;
    self.cinemaName.text = cinema.cinameName;
    self.minPrice.text = [NSString stringWithFormat:@"%zd", cinema.minPrice / 100];
    self.cinemaAddress.text = cinema.address;
    DYLocationTool *locationTool = [DYLocationTool sharedLoactionTool];
    CGFloat distace = [locationTool distanceFromLatitude:cinema.latitude andLongitude:cinema.longitude];
    if (distace == 0) {
        self.cinemaDistance.hidden = YES;
    } else {
        self.cinemaDistance.hidden = NO;
        self.cinemaDistance.text = [NSString stringWithFormat:@"%.1fkm", distace / 1000];
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
