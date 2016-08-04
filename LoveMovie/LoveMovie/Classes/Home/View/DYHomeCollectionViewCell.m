//
//  DYHomeCollectionViewCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/3.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYHomeCollectionViewCell.h"
#import "DYHomeMovie.h"
#import <UIImageView+WebCache.h>

@interface DYHomeCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *movieIcon;
@property (weak, nonatomic) IBOutlet UILabel *movieName;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *isIMAX3D;


@end

@implementation DYHomeCollectionViewCell

- (void)setMoview:(DYHomeMovie *)moview {
    _moview = moview;
    [self.movieIcon sd_setImageWithURL:[NSURL URLWithString:moview.img] placeholderImage:[UIImage imageNamed:@"bg_route_option_highlighted"]];
    self.movieName.text = moview.titleCn;
    self.rating.text = [NSString stringWithFormat:@"%.1f", moview.ratingFinal];
    if (YES == moview.isIMAX3D) {
        self.isIMAX3D.text = @" IMAX 3D ";
    } else if (YES == moview.is3D && NO == moview.isIMAX3D) {
        self.isIMAX3D.text = @" 3D ";
    } else {
        self.isIMAX3D.text = nil;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
