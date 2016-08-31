//
//  DYPhotoesViewController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/26.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYPhotoesViewController.h"
#import "DYPhotoType.h"
#import "DYPotoes.h"
#import "DYHotMovie.h"
#import <UIImageView+WebCache.h>
#import "DYPhotoCollectionViewCell.h"
#import "DYShowPhotoBaseView.h"

@interface DYPhotoesViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
/** 指示器indicatorScrollView */
@property (weak, nonatomic) UIScrollView *indicatorScrollView;
/** buttons */
@property (strong, nonatomic) NSMutableArray *buttons;
/** currentBtn 记录当前button */
@property (weak, nonatomic) UIButton *currentBtn;
/** bottomLine 按钮下的横线 */
@property (weak, nonatomic) UIView *bottomLine;
/** collectionView */
@property (weak, nonatomic) UICollectionView *collectionView;

/** photoArray当前正在显示的该类照片 */
@property (strong, nonatomic) NSArray *photoArray;
/** 放置图片的url */
@property (strong, nonatomic) NSArray<NSString *> *iconArray;
/** rectArray 盛放位置的数组 */
@property (strong, nonatomic) NSArray<NSString *> *rectArray;
@end

static NSString * const identifier = @"photoCollectionViewCell";

@implementation DYPhotoesViewController

#pragma mark - 懒加载buttons
- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (NSArray *)photoArray {
    if (_photoArray == nil) {
        _photoArray = [NSArray array];
    }
    return _photoArray;
}

- (NSArray<NSString *> *)iconArray {
    if (_iconArray == nil) {
        _iconArray = [NSArray array];
    }
    return _iconArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupIndicatorScrollView];
    [self setupCollectionView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupNav];
}

- (void)setupNav{
    // 右边消掉
    self.navigationItem.rightBarButtonItems = nil;
    
    UIView *view = [[UIView alloc] init];
    view.size = CGSizeMake(240, 44);
    
    UILabel *name = [[UILabel alloc] init];
    name.textAlignment = NSTextAlignmentCenter;
    name.text = self.movieName;
    name.font = [UIFont boldSystemFontOfSize:18];
    name.textColor = [UIColor whiteColor];
    name.frame = CGRectMake(0, 0, view.width, 24);
    [view addSubview:name];
    
    UILabel *nameEn = [[UILabel alloc] init];
    nameEn.textAlignment = NSTextAlignmentCenter;
    nameEn.text = self.movieEnName;
    nameEn.font = [UIFont systemFontOfSize:14];
    nameEn.textColor = [UIColor whiteColor];
    nameEn.frame = CGRectMake(0, 24, view.width, 16);
    [view addSubview:nameEn];
    
    self.navigationItem.titleView = view;
}

#pragma mark - 设置上部指示器
- (void)setupIndicatorScrollView{
    UIScrollView *indicatorScrollView = [[UIScrollView alloc] init];
    indicatorScrollView.frame = CGRectMake(0, 64, self.view.width, 44);
    indicatorScrollView.backgroundColor = [UIColor whiteColor];
    indicatorScrollView.showsVerticalScrollIndicator = NO;
    indicatorScrollView.showsHorizontalScrollIndicator =NO;
    [self.view addSubview:indicatorScrollView];
    self.indicatorScrollView = indicatorScrollView;
    
    // 添加按钮下的横线
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.height = 2;
    bottomLine.y = indicatorScrollView.height - bottomLine.height - 0.5;
    bottomLine.backgroundColor = DYRGBColor(4, 117, 196);
    [indicatorScrollView addSubview:bottomLine];
    self.bottomLine = bottomLine;
    
    // 添加按钮
    CGFloat buttonX = 0;
    for (int i = 0; i < self.photoTypes.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.y = 0;
        DYPhotoType *photoType = self.photoTypes[i];
        [button setTitle:photoType.typeName forState:UIControlStateNormal];
        [button.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [button.titleLabel sizeToFit];
        button.width = button.titleLabel.width + 40;
        button.height = 44;
        button.x = buttonX;
        buttonX = buttonX + button.width;
        [button setTitleColor:DYRGBColor(4, 117, 196) forState:UIControlStateDisabled];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(selectedButton:) forControlEvents:UIControlEventTouchUpInside];
        [indicatorScrollView addSubview:button];
        [self.buttons addObject:button];
    }
    indicatorScrollView.contentSize = CGSizeMake(buttonX, 0);
    [self selectedButton:self.buttons[0]];
}

#pragma mark - 监听按钮事件
- (void)selectedButton:(UIButton *)button{
    self.currentBtn.enabled = YES;
    button.enabled = NO;
    self.currentBtn = button;
    
    NSInteger index = [self.buttons indexOfObject:button];
    if (index == 0) {
        self.photoArray = self.photoes;
    } else {
        DYPhotoType *type = self.photoTypes[index];
        NSMutableArray *temp = [NSMutableArray array];
        for (DYPotoes *photo in self.photoes) {
            if (photo.type == type.type) {
                [temp addObject:photo];
            }
        }
        self.photoArray = temp;
    }
    [self.collectionView reloadData];
    [self.collectionView setContentOffset:CGPointMake(0, -118) animated:NO];
    
    self.bottomLine.width = button.width;
    self.bottomLine.centerX = button.centerX;
    
    CGPoint offset = CGPointMake(0, 0);
    CGFloat halfViewWidth = self.view.width * 0.5;  // 父view(这里是屏幕)的一半宽度
    CGFloat contentSizeWidth = self.indicatorScrollView.contentSize.width;  // contentSize of Width
    // 当   (屏幕的一半) < (按钮中心.x) < (indicator总长 - 屏幕的一半) 时，按钮中心移动到屏幕中心
    if (button.centerX > halfViewWidth && button.centerX < contentSizeWidth - halfViewWidth) {
        offset.x = button.centerX - self.view.width * 0.5;
    }
    // 当不在上述范围时候，要移动到对应的位置，不然它不会自动滚动
    if (button.centerX <= halfViewWidth) {  // 到左边的时候
        offset.x = 0;
    }
    if (button.centerX >= contentSizeWidth - halfViewWidth) {
        offset.x = contentSizeWidth - self.view.width;
    }
    if (contentSizeWidth < self.view.width) {
        offset.x = 0;
    }
    [self.indicatorScrollView setContentOffset:offset animated:YES];
    
    NSMutableArray<NSString *> *mutIcons = [NSMutableArray<NSString *> array];
    for (NSInteger index = 0; index < self.photoArray.count; index++) {
        DYPotoes *photo = self.photoArray[index];
        [mutIcons addObject:photo.image];
    }
    self.iconArray = mutIcons;
    [self countCellRect];
}

#pragma mark - 设置collectionView
- (void)setupCollectionView{
    // 布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(80, 80);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 创建
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    collectionView.contentInset = UIEdgeInsetsMake(118, 11, 20, 11);
    [self.view insertSubview:collectionView atIndex:0];
    self.collectionView = collectionView;
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DYPhotoCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:identifier];
    // 代理、数据源
    collectionView.dataSource = self;
    collectionView.delegate = self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DYPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    DYPotoes *photo = self.photoArray[indexPath.item];
    cell.photo = photo;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    DYPhotoCollectionViewCell *cell = (DYPhotoCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.imge.image == nil) return;
    [self scrollViewDidScroll:self.collectionView];
    DYShowPhotoBaseView *baseView = [[DYShowPhotoBaseView alloc] initWithFrame:self.view.bounds];
    baseView.iconArray = self.iconArray;
    baseView.rectArray = self.rectArray;
    baseView.collectionView = self.collectionView;
    baseView.index = indexPath.row;
    [[UIApplication sharedApplication].keyWindow addSubview:baseView];
    
    baseView.backgroundColor = [UIColor blackColor];
}

- (void)countCellRect {
    NSMutableArray<NSString *> *array = [NSMutableArray<NSString *> array];
    for (NSInteger index = 0; index < self.photoArray.count; index++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        DYPhotoCollectionViewCell *cell = (DYPhotoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
        UIWindow* window = [UIApplication sharedApplication].keyWindow;
        CGRect rectInWindow = [cell convertRect:cell.imge.frame toView:window];
        [array addObject:NSStringFromCGRect(rectInWindow)];
    }
    self.rectArray = array;
}

// 计算滑动之时，cell的位置
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
//    NSMutableArray<NSString *> *array = [NSMutableArray<NSString *> array];
//    for (NSInteger index = 0; index < self.photoArray.count; index++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//        DYPhotoCollectionViewCell *cell = (DYPhotoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
//        UIWindow* window = [UIApplication sharedApplication].keyWindow;
//        CGRect rectInWindow = [cell convertRect:cell.imge.frame toView:window];
//        [array addObject:NSStringFromCGRect(rectInWindow)];
//    }
//    self.rectArray = array;
    [self countCellRect];
}

// 此方法会在cell显示出来后再执行，所以这里可以计算滑动之前cell的位置
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    NSMutableArray<NSString *> *array = [NSMutableArray<NSString *> array];
//    for (NSInteger index = 0; index < self.photoArray.count; index++) {
//        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
//        DYPhotoCollectionViewCell *cell = (DYPhotoCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
//        UIWindow* window = [UIApplication sharedApplication].keyWindow;
//        CGRect rectInWindow = [cell convertRect:cell.imge.frame toView:window];
//        [array addObject:NSStringFromCGRect(rectInWindow)];
//    }
//    self.rectArray = array;
    [self countCellRect];
    NSLog(@"%@", _rectArray);
}

@end
