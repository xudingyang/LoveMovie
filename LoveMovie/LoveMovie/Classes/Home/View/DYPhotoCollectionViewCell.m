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

@property (weak, nonatomic) IBOutlet UIImageView *imge;
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

- (void)awakeFromNib {
    [super awakeFromNib];
    self.imge.userInteractionEnabled = YES;
    UIGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestTap)];
    [self.imge addGestureRecognizer:gest];
}

// 点击cell小图
- (void)gestTap {
    if (self.isSuccess == NO) {
        return;
    }
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    // 转换坐标系
    CGRect rectInWindow = [self.contentView convertRect:self.imge.frame toView:window];
    self.rectInWindow = rectInWindow;
    // 大图imageView
    UIImageView *otherImageView = [[UIImageView alloc] initWithImage:self.imge.image];
    otherImageView.frame = rectInWindow;
    otherImageView.userInteractionEnabled = YES;
    UIGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestTap1)];
    [otherImageView addGestureRecognizer:gest];
    self.otherImageView = otherImageView;
    [window addSubview:otherImageView];
    // 保存按钮
    DYNoHighlitedButton *saveBtn = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
    self.saveBtn = saveBtn;
    saveBtn.frame = CGRectMake(DYScreenWidth * 0.5 - 30, DYScreenHeight - 50, 60, 30);
    saveBtn.backgroundColor = [UIColor lightGrayColor];
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [saveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 大图背景图
    UIView *showPicView = [[UIView alloc] init];
    showPicView.backgroundColor = [UIColor blackColor];
    showPicView.frame = rectInWindow;
    
    self.showPicView = showPicView;
    
    self.isBig = NO;
    
    if (self.isBig == YES) {
        [self.saveBtn removeFromSuperview];
        [UIView animateWithDuration:0.5 animations:^{
            self.otherImageView.frame = self.rectInWindow;
            self.showPicView.frame = self.rectInWindow;
        } completion:^(BOOL finished) {
            [self.otherImageView removeFromSuperview];
            [self.showPicView removeFromSuperview];
        }];
    } else {
        [window addSubview:self.showPicView];
        [window addSubview:self.otherImageView];
        [UIView animateWithDuration:0.5 animations:^{
//            self.otherImageView.frame = window.bounds;
            CGFloat imageX = 0;
            CGFloat imageW = DYScreenWidth;
            UIImage *image = self.imge.image;
            CGFloat imageH = (DYScreenWidth / image.size.width) * image.size.height;
            CGFloat imageY = DYScreenHeight * 0.5 - imageH * 0.5;
            self.otherImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            self.showPicView.frame = window.bounds;
        } completion:^(BOOL finished) {
            [window addSubview:saveBtn];
        }];
    }
    self.isBig = !self.isBig;
}

// 点击变大之后的图
- (void)gestTap1 {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (self.isBig == YES) {
        [self.saveBtn removeFromSuperview];
        [UIView animateWithDuration:0.5 animations:^{
            self.otherImageView.frame = self.rectInWindow;
            self.showPicView.frame = self.rectInWindow;
        } completion:^(BOOL finished) {
            [self.otherImageView removeFromSuperview];
            [self.showPicView removeFromSuperview];
        }];
    } else {
        [window addSubview:self.showPicView];
        [window addSubview:self.otherImageView];
        [UIView animateWithDuration:0.5 animations:^{
//            self.otherImageView.frame = window.bounds;
            CGFloat imageX = 0;
            CGFloat imageW = DYScreenWidth;
            UIImage *image = self.imge.image;
            CGFloat imageH = (DYScreenWidth / image.size.width) * image.size.height;
            CGFloat imageY = DYScreenHeight * 0.5 - imageH * 0.5;
            self.otherImageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
            self.showPicView.frame = window.bounds;
        } completion:^(BOOL finished) {
            [window addSubview:self.saveBtn];
        }];
    }
    self.isBig = !self.isBig;
}

// 保存照片
- (void)saveBtnClick {
    // 写到相册中
//    if (self.isSuccess == NO) {
//        [SVProgressHUD showErrorWithStatus:@"图片未下载成功！"];
//        return;
//    }
    UIImageWriteToSavedPhotosAlbum(self.imge.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showSuccessWithStatus:@"保存成功"];
    } else {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"保存失败"];
    }
}

@end
