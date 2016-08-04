//
//  DYHomeTrailerTableViewCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/26.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYHomeTrailerTableViewCell.h"
#import <UIImageView+WebCache.h>
#import "DYVideo.h"

@interface DYHomeTrailerTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *videoIcon;
@property (weak, nonatomic) IBOutlet UILabel *videoTitle;
@property (weak, nonatomic) IBOutlet UILabel *videoLenght;


@end

@implementation DYHomeTrailerTableViewCell

- (void)setVideo:(DYVideo *)video{
    _video = video;
    [self.videoIcon sd_setImageWithURL:[NSURL URLWithString:video.image] placeholderImage:[UIImage imageNamed:@"icon_my_movie@3x "]];
    self.videoTitle.text = video.title;
    self.videoLenght.text = video.lengthStr;
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
