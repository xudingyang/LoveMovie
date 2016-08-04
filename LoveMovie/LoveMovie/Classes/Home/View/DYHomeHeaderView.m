//
//  DYHomeHeaderView.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/3.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYHomeHeaderView.h"
#import "DYGlobalTicketListVC.h"
#import "DYNavigationController.h"
#import "DYTabBarController.h"
#import "DYTrailerTableVController.h"
#import "DYTop100TableVC.h"
#import "DYMeWebViewController.h"
#import "DYNewsTableVController.h"
#import "DYShowingMovieTableVC.h"
#import "DYComingMovieVC.h"
#import "DYCinemaVController.h"
#import "DYHomeCollectionViewCell.h"
#import "DYFindViewController.h"
#import "DYHomeScrollImage.h"
#import "DYHomeMovie.h"
#import "DYHomeCollectionViewCell.h"
#import "DYMovieDetailVC.h"
#import "DYScanQRViewController.h"

@interface DYHomeHeaderView () <UICollectionViewDataSource, UICollectionViewDelegate>

// 二维码
@property (weak, nonatomic) IBOutlet UIImageView *erWeiMa;
// 选择城市
@property (weak, nonatomic) IBOutlet UILabel *citySelect;
// 搜索框
@property (weak, nonatomic) IBOutlet UIImageView *searchImage;
// 正在上映的总数
@property (weak, nonatomic) IBOutlet UILabel *totalShowing;
// 即将上映电影数目
@property (weak, nonatomic) IBOutlet UILabel *comingCount;
// 同城影院数目
@property (weak, nonatomic) IBOutlet UILabel *cinemaCount;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;

@end

static NSString * const identifer = @"DYHomeCollectionViewCell";

@implementation DYHomeHeaderView

- (void)setShowingNum:(NSInteger)showingNum {
    _showingNum = showingNum;
    self.totalShowing.text = [NSString stringWithFormat:@"共%zd部", showingNum];
}

- (void)setComingNum:(NSInteger)comingNum {
    _comingNum = comingNum;
    self.comingCount.text = [NSString stringWithFormat:@"%zd部 >", comingNum];
}

- (void)setCinemaNum:(NSInteger)cinemaNum {
    _cinemaNum = cinemaNum;
    self.cinemaCount.text = [NSString stringWithFormat:@"%zd家 >", cinemaNum];
}

- (void)setMovieArray:(NSArray<DYHomeMovie *> *)movieArray {
    _movieArray = movieArray;
    
}

// 当在这里设置的时候，外边的滚动条刚开始是滚动的，但是一旦被点击，就滚动了，为什么？
//- (void)setScrollImageArray:(NSArray<DYHomeScrollImage *> *)scrollImageArray {
//    _scrollImageArray = scrollImageArray;
//    NSMutableArray<NSString *> *tmp = [NSMutableArray<NSString *> array];
//    for (DYHomeScrollImage *obj in scrollImageArray) {
//        [tmp addObject:obj.img];
//    }
//
//    ScrollImage *scrl = [[ScrollImage alloc] initWithCurrentController:self.inputViewController urlString:tmp viewFrame:CGRectMake(0, 0, DYScreenWidth, 180) placeholderImage:[UIImage imageNamed:@"comment-bar-bg"]];
//    scrl.timeInterval = 2.0;
//    [self.scrollImage addSubview:scrl.view];
//}

+ (instancetype)homeHeaderView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // 二维码扫描
    UIGestureRecognizer *gest1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(erWeiMaSaoMiao)];
    [self.erWeiMa addGestureRecognizer:gest1];
    // 搜索框
    UIGestureRecognizer *gest2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchTap)];
    [self.searchImage addGestureRecognizer:gest2];
    // 城市选择
    UIGestureRecognizer *gest3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(citySelectBtn)];
    [self.citySelect addGestureRecognizer:gest3];
    // 正在上映的共多少部
    UIGestureRecognizer *gest4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(totalShowingClick)];
    [self.totalShowing addGestureRecognizer:gest4];
}

- (void)layoutSubviews {
    [self setupCollectionView];
}

- (void)setupCollectionView {
    self.flowLayout.itemSize = CGSizeMake(120, 200);
    self.flowLayout.minimumLineSpacing = 10;
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DYHomeCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:identifer];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movieArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    DYHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifer forIndexPath:indexPath];
    cell.moview = self.movieArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    DYMovieDetailVC *vc = [[DYMovieDetailVC alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    vc.automaticallyAdjustsScrollViewInsets = NO;
    DYHomeMovie *movie = self.movieArray[indexPath.item];
    
    vc.movieType = movie.type;
    vc.movieScore = movie.ratingFinal;
    vc.showDateArea = movie.showDateArea;
    vc.movieName = movie.titleCn;
    vc.movieEnName = movie.titleEn;
    vc.movieLength = [NSString stringWithFormat:@"%zd分钟", movie.length];
    vc.iconUrl = movie.img;
    vc.movieID = movie.movieId;
    vc.isTicket = YES;
    
    [currentNav pushViewController:vc animated:YES];
}

- (void)erWeiMaSaoMiao {
    DYScanQRViewController *vc = [[DYScanQRViewController alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    [currentNav pushViewController:vc animated:YES];
}

- (void)searchTap {
    DYLog(@"搜索");
}

- (void)citySelectBtn {
    DYLog(@"城市");
}

// 正在上映
- (void)totalShowingClick {
    
    DYShowingMovieTableVC *vc = [[DYShowingMovieTableVC alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    vc.automaticallyAdjustsScrollViewInsets = NO;
    [currentNav pushViewController:vc animated:YES];
}

// 即将上映
- (IBAction)comingBtnClick {
    DYComingMovieVC *vc = [[DYComingMovieVC alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    vc.automaticallyAdjustsScrollViewInsets = NO;
    [currentNav pushViewController:vc animated:YES];
}

// 同城影院
- (IBAction)tongCityBtnClick {
    DYCinemaVController *vc = [[DYCinemaVController alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    vc.automaticallyAdjustsScrollViewInsets = NO;
    [currentNav pushViewController:vc animated:YES];
}

// 时光热榜
- (IBAction)timeTopList {
    DYTop100TableVC *vc = [[DYTop100TableVC alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    vc.top100VcType = DYTimeTop100;
    vc.title = @"时光Top100";
    [currentNav pushViewController:vc animated:YES];
}

// 全球票房榜
- (IBAction)globalTicket {
    DYGlobalTicketListVC *vc = [[DYGlobalTicketListVC alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    
    [currentNav pushViewController:vc animated:YES];
    vc.chooseAreaNumber = DYAmerica;
}

// 新片预告
- (IBAction)newMovieTrailer {
    DYTrailerTableVController *vc = [[DYTrailerTableVController alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    vc.automaticallyAdjustsScrollViewInsets = NO;

    [currentNav pushViewController:vc animated:YES];
}

// 猜电影
- (IBAction)guessMoview {
    
    DYMeWebViewController *vc = [[DYMeWebViewController alloc] init];
    vc.url = @"http://feature.mtime.cn/puzzle/";
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    CGFloat height = vc.view.height; // 只是在这里就加载view
    height = height;
    vc.automaticallyAdjustsScrollViewInsets = YES;
    [currentNav pushViewController:vc animated:YES];
}

// 全部资讯
- (IBAction)allNews {
//    DYNewsTableVController *vc = [[DYNewsTableVController alloc] init];
    DYTabBarController *tabBarVc = (DYTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    DYNavigationController *currentNav = tabBarVc.selectedViewController;
    tabBarVc.selectedIndex = 3;
//    vc.automaticallyAdjustsScrollViewInsets = NO;
//    [currentNav pushViewController:vc animated:YES];
}


@end
