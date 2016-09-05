//
//  DYShowPhotoBaseView.m
//  LoveMovie
//
//  Created by xudingyang on 16/8/22.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#define DYScreenW [UIApplication sharedApplication].keyWindow.frame.size.width
#define DYScreenH [UIApplication sharedApplication].keyWindow.frame.size.height
// 定义这个常量,就可以在使用Masonry不必总带着前缀 `mas_`:
#define MAS_SHORTHAND
// 定义这个常量,以支持在 Masonry 语法中自动将基本类型转换为 object 类型:
#define MAS_SHORTHAND_GLOBALS

#import "DYShowPhotoBaseView.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>
#import <SVProgressHUD.h>

@interface DYShowPhotoBaseView () <UIScrollViewDelegate>
/** currentRect scrollView中对应cell在window中的位置 */
@property (assign, nonatomic) CGRect currentRect;

/** baseView 用来放置scrollView的容器 */
@property (weak, nonatomic) UIView *baseView;
/** scrollView 用来展示图片的scrollView */
@property (weak, nonatomic) UIScrollView *scrollView;
/** currecntIndex scrollView中，当前图片的编号 */
@property (assign, nonatomic) NSInteger currecntIndex;
/** indexLabel 图片序号指示器 */
@property (weak, nonatomic) UILabel *indexLabel;

// scrollView的三张图片
/** leftImageView */
@property (weak, nonatomic) UIImageView *leftImageView;
/** centerImageView */
@property (weak, nonatomic) UIImageView *centerImageView;
/** rightImageView */
@property (weak, nonatomic) UIImageView *rightImageView;

/** canDownload标记是否下载完成。若图片未下载完成，则不许保存到相册 */
@property (assign, nonatomic) BOOL canDownload;

/** 保存按钮 */
@property (weak, nonatomic) UIButton *saveBtn;
@end

@implementation DYShowPhotoBaseView

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self setupScrollView];
    [self setupIndicator];
    [self setupSaveBtn];
}

- (void)setupScrollView {
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.bounds;
    [self addSubview:scrollView];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(DYScreenW * 3, DYScreenH);
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [scrollView setContentOffset:CGPointMake(DYScreenW, 0) animated:NO];
    scrollView.delegate = self;
    // 给scrollView添加手势，点击scrollView，大图缩小
    UITapGestureRecognizer *scrollViewGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDidClick)];
    [scrollView addGestureRecognizer:scrollViewGest];
    _scrollView = scrollView;
    
    // 设置初始图片
    UIImageView *leftImageView = [[UIImageView alloc] init];
    UIImageView *centerImageView = [[UIImageView alloc] init];
    UIImageView *rightImageView = [[UIImageView alloc] init];
    // 如果点击的是第一张
    if (self.index == 0) {
        [centerImageView sd_setImageWithURL:[NSURL URLWithString:_iconArray[0]] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
        [leftImageView sd_setImageWithURL:[NSURL URLWithString:_iconArray[_iconArray.count - 1]] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
        [rightImageView sd_setImageWithURL:[NSURL URLWithString:_iconArray[1]] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
    } else if (self.index == _iconArray.count - 1) {   // 如果点击的是最后一张
        [centerImageView sd_setImageWithURL:[NSURL URLWithString:_iconArray[_iconArray.count - 1]] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
        [leftImageView sd_setImageWithURL:[NSURL URLWithString:_iconArray[_iconArray.count - 2]] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
        [rightImageView sd_setImageWithURL:[NSURL URLWithString:_iconArray[0]] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
    } else {
        [centerImageView sd_setImageWithURL:[NSURL URLWithString:_iconArray[self.index]] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
        [leftImageView sd_setImageWithURL:[NSURL URLWithString:_iconArray[self.index - 1]] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
        [rightImageView sd_setImageWithURL:[NSURL URLWithString:_iconArray[self.index + 1]] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
    }
    self.currecntIndex = self.index;
    self.currentRect = CGRectFromString(self.rectArray[self.index]);
    self.indexLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.currecntIndex+1, _iconArray.count];
    
    UIImage *centerImage = centerImageView.image;
    UIImage *leftImage = leftImageView.image;
    UIImage *rightImage = rightImageView.image;
    
    CGFloat leftHeight = DYScreenW / leftImage.size.width * leftImage.size.height;
    leftImageView.frame = CGRectMake(0, (DYScreenH-leftHeight)*0.5, DYScreenW, leftHeight);
    [scrollView addSubview:leftImageView];
    _leftImageView = leftImageView;
    
    CGFloat centerHeight = DYScreenW / centerImage.size.width * centerImage.size.height;
    centerImageView.frame = CGRectMake(DYScreenW, (DYScreenH-centerHeight)*0.5, DYScreenW, centerHeight);
    [scrollView addSubview:centerImageView];
    _centerImageView = centerImageView;
    
    CGFloat rightHeight = DYScreenW / rightImage.size.width * rightImage.size.height;
    rightImageView.frame = CGRectMake(DYScreenW*2, (DYScreenH-rightHeight)*0.5, DYScreenW, rightHeight);
    [scrollView addSubview:rightImageView];
    _rightImageView = rightImageView;
    
    _canDownload = YES;
}

#pragma mark - 设置上边的图片下标指示器
- (void)setupIndicator {
    // 上边的图片序号指示器
    UILabel *indexLabel = [[UILabel alloc] init];
    [self addSubview:indexLabel];
    __weak typeof(self) weakSelf = self;
    [indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.top.equalTo(30);
        make.size.equalTo(CGSizeMake(100, 40));
    }];
    indexLabel.textColor = [UIColor whiteColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    _indexLabel = indexLabel;
    indexLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.currecntIndex+1, _iconArray.count];
}

#pragma mark - 下边的下载按钮
- (void)setupSaveBtn {
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:saveBtn];
    saveBtn.frame = CGRectMake((DYScreenW-80)*0.5, DYScreenH-70, 80, 40);
    [saveBtn setTitle:@"下载" forState:UIControlStateNormal];
    [saveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _saveBtn = saveBtn;
    [saveBtn addTarget:self action:@selector(savaBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)savaBtnClick {
    if (_canDownload == NO) {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showSuccessWithStatus:@"图片未加载完毕..."];
        return;
    }
    // 写到相册中
    UIImageWriteToSavedPhotosAlbum(self.centerImageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
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

// 刷新iamgeView中的图片。难点：计算左中右的下标
- (void)refreshImages{
    
    NSInteger leftImageIndex;
    NSInteger rightImageIndex;
    CGPoint offset = self.scrollView.contentOffset;
    // 向右滑动。这时候应该让currentIndex加1：即让currentIndex + 1的图片显示在屏幕上
    if (offset.x > DYScreenW) {
        self.currecntIndex = (self.currecntIndex + 1) % self.iconArray.count;
    }
    // 向左滑动。这时候应该让currentIndex减1：即让currentIndex - 1的图片显示在屏幕上
    else if (offset.x < DYScreenW) {
        self.currecntIndex = (self.currecntIndex + self.iconArray.count - 1) % self.iconArray.count;
    }
    
    leftImageIndex = (self.currecntIndex + self.iconArray.count - 1) % self.iconArray.count;
    rightImageIndex = (self.currecntIndex + 1) % self.iconArray.count;
    
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:self.iconArray[leftImageIndex]] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
    _canDownload = NO;
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:self.iconArray[self.currecntIndex]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (!image) {
            _canDownload = YES;
            self.centerImageView.image = image;
        } else {
            _canDownload = NO;
            self.centerImageView.image = [UIImage imageNamed:@"order_review_upload_img"];
        }
    }];
    
    [self.centerImageView sd_setImageWithURL:[NSURL URLWithString:self.iconArray[self.currecntIndex]] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _canDownload = YES;
    }];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:self.iconArray[rightImageIndex]] placeholderImage:[UIImage imageNamed:@"order_review_upload_img"]];
    
    CGFloat leftHeight = DYScreenW / self.leftImageView.image.size.width * self.leftImageView.image.size.height;
    CGFloat centerHeight = DYScreenW / self.centerImageView.image.size.width * self.centerImageView.image.size.height;
    CGFloat rightHeight = DYScreenW / self.rightImageView.image.size.width * self.rightImageView.image.size.height;
    self.leftImageView.frame = CGRectMake(0, (DYScreenH-leftHeight)*0.5, DYScreenW, leftHeight);
    self.centerImageView.frame = CGRectMake(DYScreenW, (DYScreenH-centerHeight)*0.5, DYScreenW, centerHeight);
    self.rightImageView.frame = CGRectMake(DYScreenW*2, (DYScreenH-rightHeight)*0.5, DYScreenW, rightHeight);
    
    _indexLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.currecntIndex+1, _iconArray.count];
    
    _currentRect = CGRectFromString(self.rectArray[self.currecntIndex]);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 刷新imageView的图片
    [self refreshImages];
    // 把currentPageIndex立刻移到中间来
    [scrollView setContentOffset:CGPointMake(DYScreenW, 0) animated:NO];
}

// scrollView的手势的方法
- (void)scrollViewDidClick {
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:_centerImageView.image];
    CGFloat tempHeight = DYScreenW / _centerImageView.image.size.width * _centerImageView.image.size.height;
    tempImageView.frame = CGRectMake(0, (DYScreenH-tempHeight)*0.5, DYScreenW, tempHeight);
    [self addSubview:tempImageView];
    [self.scrollView removeFromSuperview];
    [self.indexLabel removeFromSuperview];
    
    CGFloat width = _currentRect.size.width;
    if (width <= 0) {  // 如果cell没出现在界面中,即_currentRect = {0,0,0,0}；
        if (self.currecntIndex > self.index) {  // 说明往左滑动的，currentCell应该在屏幕下方
            _currentRect = CGRectMake(DYScreenW * (self.currecntIndex % 4) / 4, DYScreenH, 0, 0);
        } else if (self.currecntIndex < self.index) { // 说明往右滑动的，currentCell应该在屏幕上方
            _currentRect = CGRectMake(DYScreenW * (self.currecntIndex % 4) / 4, 0, 0, 0);
        }
    }
    [UIView animateWithDuration:1 animations:^{
        self.frame = _currentRect;
        tempImageView.frame = self.bounds;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
