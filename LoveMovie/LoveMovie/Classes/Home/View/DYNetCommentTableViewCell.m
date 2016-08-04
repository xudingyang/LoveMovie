//
//  DYNetCommentTableViewCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/27.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYNetCommentTableViewCell.h"
#import "DYNetFriendComment.h"
#import <UIImageView+WebCache.h>
#import "UIImage+DYExt.h"
#import "NSString+DYExt.h"

@interface DYNetCommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userIcon;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *publishDate;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *reply;
@property (weak, nonatomic) IBOutlet UIImageView *commentImage;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentImageHeight;



@end

@implementation DYNetCommentTableViewCell

- (void)setComment:(DYNetFriendComment *)comment{
    _comment = comment;
    UIImage *placeHolder = [[UIImage imageNamed:@"actor_default_image_100x100"] circleImage];
    [self.userIcon sd_setImageWithURL:[NSURL URLWithString:comment.caimg] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.userIcon.image = image ? [image circleImage] : placeHolder;
    }];
    self.nickName.text = comment.name;
    self.publishDate.text = comment.publishDate;
    if (comment.rating <= 0) {
        self.rating.hidden = YES;
    } else {
        self.rating.hidden = NO;
        if (comment.rating == 10.0) {
            self.rating.text = [NSString stringWithFormat:@"%.0f", comment.rating];
        } else {
            self.rating.text = [NSString stringWithFormat:@"%.1f", comment.rating];
        }
    }
    self.content.text = [NSString trimedSpaceReturnWithString:comment.content];
    if (comment.commentCount <= 0) {
        self.reply.text = @"回复";
    } else {
        self.reply.text = [NSString stringWithFormat:@"%zd", comment.commentCount];
    }
    if (comment.ceimg.length != 0) {
        self.commentImageHeight.constant = 116;
        [self.commentImage sd_setImageWithURL:[NSURL URLWithString:comment.ceimg] placeholderImage:[UIImage imageNamed:@"actor_default_image_100x100"]];
        [self layoutIfNeeded];
    } else {
        self.commentImageHeight.constant = 0;
        [self layoutIfNeeded];
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
