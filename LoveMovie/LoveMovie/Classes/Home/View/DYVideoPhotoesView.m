//
//  DYVideoPhotoesView.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/24.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYVideoPhotoesView.h"
#import "DYVideo.h"
#import "DYPotoes.h"
#import <UIImageView+WebCache.h>
#import "DYTrailerTableViewController.h"
#import "DYPhotoesViewController.h"
#import "DYTabBarController.h"
#import "DYNavigationController.h"
#import "DYPhotoType.h"

@interface DYVideoPhotoesView ()

@property (weak, nonatomic) IBOutlet UIImageView *videoIcon;
@property (weak, nonatomic) IBOutlet UIImageView *potoIcon;



@end

@implementation DYVideoPhotoesView

+ (instancetype)videoPhotoesView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)setPoto:(DYPotoes *)poto{
    _poto = poto;
    [self.potoIcon sd_setImageWithURL:[NSURL URLWithString:poto.image] placeholderImage:[UIImage imageNamed:@"movie_default_image_170×254"]];
}

- (void)setVideo:(DYVideo *)video{
    _video = video;
    [self.videoIcon sd_setImageWithURL:[NSURL URLWithString:video.image] placeholderImage:[UIImage imageNamed:@"movie_default_image_170×254"]];
}

/**
 *  @class DYPhotoType;
 @class DYPotoes;

 */
- (IBAction)photoBtnClick {
    if ([self.potoCount.text integerValue] == 0) {
        return;
    }
    DYPhotoesViewController *vc = [[DYPhotoesViewController alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    if (self.photoes.count == 0 || self.photoTypes.count == 0) {
        return;
    }
    vc.photoes = self.photoes;
    vc.photoTypes = self.photoTypes;
    vc.movieEnName = self.movieEnName;
    vc.movieName = self.movieName;
    [currentNav pushViewController:vc animated:YES];
}

- (IBAction)videoBtnClick {
    if ([self.videoCount.text integerValue] == 0) {
        return;
    }
    DYTrailerTableViewController *vc = [[DYTrailerTableViewController alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    vc.movieID = self.movieID;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    [currentNav pushViewController:vc animated:YES];
}

@end
