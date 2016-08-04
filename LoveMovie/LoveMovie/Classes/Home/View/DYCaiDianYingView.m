//
//  DYCaiDianYingView.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/4.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYCaiDianYingView.h"
#import <UIImageView+WebCache.h>
#import "DYZiXun.h"
#import "NSString+DYExt.h"

@interface DYCaiDianYingView ()

@property (weak, nonatomic) IBOutlet UILabel *tagLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIImageView *movieIcon;

@end

@implementation DYCaiDianYingView

- (void)setZixun:(DYZiXun *)zixun {
    _zixun = zixun;
    self.tagLabel.text = zixun.tag;
    self.titleLabel.text = zixun.title;
    self.contentLabel.text = [NSString trimedSpaceReturnWithString:zixun.memo];
    [self.movieIcon sd_setImageWithURL:[NSURL URLWithString:zixun.pic1Url] placeholderImage:[UIImage imageNamed:@"actor_default_image_100x100"]];
}

+ (instancetype)caidianyingView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

@end
