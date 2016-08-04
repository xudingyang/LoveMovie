//
//  DYCommentView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/25.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYCommentView.h"
#import "DYComment.h"
#import <UIImageView+WebCache.h>
#import "UIImage+DYExt.h"
#import "NSString+DYExt.h"

@interface DYCommentView ()

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *publishDate;
@property (weak, nonatomic) IBOutlet UILabel *scroe;

@end

@implementation DYCommentView

+ (instancetype)commentView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setComment:(DYComment *)comment{
    _comment = comment;
    self.title.text = comment.title;
    self.content.text = [NSString trimedSpaceReturnWithString:comment.content];
    if (comment.rating <= 0) {
        self.scroe.hidden = YES;
    } else {
        self.scroe.hidden = NO;
        self.scroe.text=[NSString stringWithFormat:@"%.1f", comment.rating];
    }
    self.publishDate.text = comment.publishDate;
    UIImage *placeHolder = [[UIImage imageNamed:@"actor_default_image_100x100"] circleImage];
    [self.icon sd_setImageWithURL:[NSURL URLWithString:comment.headurl] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.icon.image = image ? [image circleImage] : placeHolder;
    }];
    self.nickName.text = comment.nickname;
}

- (IBAction)topBtnClick {
     
}

- (IBAction)bottomBtnClick {
    DYLog(@"影评下");
}


@end
