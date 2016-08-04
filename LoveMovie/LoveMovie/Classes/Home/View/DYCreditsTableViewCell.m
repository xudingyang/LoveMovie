//
//  DYCreditsTableViewCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/26.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYCreditsTableViewCell.h"
#import "DYPerson.h"
#import <UIImageView+WebCache.h>
#import "UIImage+DYExt.h"

@interface DYCreditsTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *actorIcon;
@property (weak, nonatomic) IBOutlet UIImageView *roleIcon;
@property (weak, nonatomic) IBOutlet UIView *midContentView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *chinesNameHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *englishNameHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *roleNameHeight;

@property (weak, nonatomic) IBOutlet UILabel *chineseName;
@property (weak, nonatomic) IBOutlet UILabel *englishName;
@property (weak, nonatomic) IBOutlet UILabel *roleName;


@end


@implementation DYCreditsTableViewCell

- (void)setPerson:(DYPerson *)person{
    _person = person;
    // 左边头像
    [self.actorIcon sd_setImageWithURL:[NSURL URLWithString:person.image] placeholderImage:[UIImage imageNamed:@"actor_default_image_100x100"]];
    // 右边的头像
    if ([person.personType isEqualToString:@"演员"] && person.roleCover.length != 0) {  // 有右边的头像，因为有些演员没有右边的头像
        self.roleIcon.hidden = NO;
        UIImage *placeHolder = [[UIImage imageNamed:@"actor_default_image_100x100"] circleImage];
        [self.roleIcon sd_setImageWithURL:[NSURL URLWithString:person.roleCover] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            self.roleIcon.image = image ? [image circleImage] : placeHolder;
        }];
    } else {
        self.roleIcon.hidden = YES;
    }
    // 中间的内容
    if ([person.personType isEqualToString:@"演员"]) { // 演员
        if (person.name.length != 0) {
            self.chinesNameHeight.constant = 30;
            self.chineseName.text = person.name;
        } else {
            self.chinesNameHeight.constant = 0;
        }
        if (person.nameEn.length != 0) {
            self.englishNameHeight.constant = 25;
            self.englishName.text = person.nameEn;
        } else {
            self.englishNameHeight.constant = 0;
        }
        self.roleNameHeight.constant = 25;
        self.roleName.text = person.personate;
        [self layoutIfNeeded];
    } else {  // 非演员
        if (person.name.length != 0) {
            self.chineseName.text = person.name;
            self.chinesNameHeight.constant = 40;
        } else {
            self.chinesNameHeight.constant = 0;
        }
        if (person.nameEn.length != 0) {
            self.englishName.text = person.nameEn;
            self.englishNameHeight.constant = 40;
        } else {
            self.englishNameHeight.constant = 0;
        }
        self.roleNameHeight.constant = 0;
        [self layoutIfNeeded];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
