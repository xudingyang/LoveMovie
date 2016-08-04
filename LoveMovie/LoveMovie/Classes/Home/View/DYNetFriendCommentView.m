//
//  DYNetFriendCommentView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/26.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYNetFriendCommentView.h"
#import "DYNetFriendComment.h"
#import <UIImageView+WebCache.h>
#import "UIImage+DYExt.h"
#import "NSString+DYExt.h"

@interface DYNetFriendCommentView ()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *rating;
@property (weak, nonatomic) IBOutlet UILabel *publishDate;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation DYNetFriendCommentView

+ (instancetype)netFriendCommentView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setNetFriendComment:(DYNetFriendComment *)netFriendComment{
    _netFriendComment = netFriendComment;
    self.content.text = [NSString trimedSpaceReturnWithString:netFriendComment.content];
    UIImage *placeHolder = [[UIImage imageNamed:@"actor_default_image_100x100"] circleImage];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:netFriendComment.caimg] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.icon.image = image ? [image circleImage] : placeHolder;
    }];
    self.name.text = netFriendComment.name;
    self.publishDate.text = netFriendComment.publishDate;
    self.rating.text = [NSString stringWithFormat:@"%.f", netFriendComment.rating];
}

- (IBAction)btnClick {
    
}

@end
