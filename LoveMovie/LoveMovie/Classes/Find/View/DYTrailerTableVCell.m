//
//  DYTrailerTableVCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTrailerTableVCell.h"
#import <UIImageView+WebCache.h>
#import "DYTrailer.h"

@interface DYTrailerTableVCell ()

@property (weak, nonatomic) IBOutlet UIImageView *trailerIconView;
@property (weak, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentLAbel;


@end


@implementation DYTrailerTableVCell

- (void)setTrailer:(DYTrailer *)trailer{
    _trailer = trailer;
    [self.trailerIconView sd_setImageWithURL:[NSURL URLWithString:trailer.coverImg] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
    self.movieNameLabel.text = trailer.movieName;
    self.commentLAbel.text = trailer.summary;
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
