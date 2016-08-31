//
//  DYPhotoCollectionViewCell.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/4.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYPhotoCollectionViewCell.h"
#import "DYPotoes.h"
#import <UIImageView+WebCache.h>
#import "DYNoHighlitedButton.h"
#import <SVProgressHUD.h>

@interface DYPhotoCollectionViewCell ()


/** CGRect rectInWindow */
@property (assign, nonatomic) CGRect rectInWindow;
/** UIImageView *otherImageView */
@property (weak, nonatomic) UIImageView *otherImageView;
/** isBig */
@property (assign, nonatomic) BOOL isBig;
/** 保存按钮 */
@property (weak, nonatomic) DYNoHighlitedButton *saveBtn;
/** 展示大图的view showPicView */
@property (weak, nonatomic) UIView *showPicView;
/** 图片下载成功标志 */
@property (assign, nonatomic) BOOL isSuccess;

@end

@implementation DYPhotoCollectionViewCell

- (void)setPhoto:(DYPotoes *)photo {
    _photo = photo;
    UIImage *placeHolder = [UIImage imageNamed:@"bg_route_option_highlighted"];
    [self.imge sd_setImageWithURL:[NSURL URLWithString:photo.image] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image != nil) {
            self.isSuccess = YES;
        }
        self.imge.image = image ? image : placeHolder;
    }];
}


@end
