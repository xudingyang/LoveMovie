//
//  DYHomeViewController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/27.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYHomeViewController.h"
#import "DYNavigationController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "DYHomeHeaderView.h"
#import "DYHomeScrollImage.h"
#import "ScrollImage.h"
#import "DYHomeMovie.h"
#import "DYHomeTableViewCell.h"
#import "DYZiXun.h"

@interface DYHomeViewController ()

/** manage */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** DYHomeScrollImage数组 */
@property (strong, nonatomic) NSArray<DYHomeScrollImage *> *scrollImageArray;
/** DYHomeMovie数组 */
@property (strong, nonatomic) NSArray<DYHomeMovie *> *movies;
/** totalHotMovie */
@property (assign, nonatomic) NSInteger totalHotMovie;
/** totalComingMovie */
@property (assign, nonatomic) NSInteger totalComingMovie;
/** totalCinemaCount */
@property (assign, nonatomic) NSInteger totalCinemaCount;

/** pageIndex */
@property (assign, nonatomic) NSInteger pageIndex;
/** 资讯数组 */
@property (strong, nonatomic) NSMutableArray *zixunArray;

@end

static NSString * const identifier = @"DYHomeViewControllerCell";

@implementation DYHomeViewController

#pragma mark - 懒加载manager
- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setuptableView];
//    [self setupHeaderView];
    [self loadFirstPage];
    [self setupRefresh];
}

- (void)setuptableView{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = DYGlobalBackgroundColor;
    
    [self setupHeaderView];
}

#pragma mark - 设置header
- (void)setupHeaderView {
    DYHomeHeaderView *headerView = [DYHomeHeaderView homeHeaderView];
    headerView.frame = CGRectMake(0, 0, DYScreenWidth, 670);
    self.tableView.tableHeaderView = headerView;
    NSMutableArray<NSString *> *tmp = [NSMutableArray<NSString *> array];
    for (DYHomeScrollImage *obj in self.scrollImageArray) {
        [tmp addObject:obj.img];
    }
    ScrollImage *scrl = [[ScrollImage alloc] initWithCurrentController:self urlString:tmp viewFrame:CGRectMake(0, 0, DYScreenWidth, 180) placeholderImage:[UIImage imageNamed:@"comment-bar-bg"]];
    scrl.timeInterval = 2.0;
    [headerView.scrollImage addSubview:scrl.view];
    
    headerView.movieArray = self.movies;
    headerView.showingNum = self.totalHotMovie;
    headerView.comingNum = self.totalComingMovie;
    headerView.cinemaNum = self.totalCinemaCount;
}

#pragma mark - 设置刷新控件
- (void)setupRefresh {
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
}

// 轮播器http://api.m.mtime.cn/PageSubArea/GetFirstPageAdvAndNews.api
// 电影http://api.m.mtime.cn/PageSubArea/HotPlayMovies.api?locationId=561
// 资讯http://api.m.mtime.cn/PageSubArea/GetHomeFeed.api?pageIndex=1
- (void)loadFirstPage {
    
    // DYHomeScrollImage轮播器
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"application/x-javascript"];
    [mutSet addObject:@"text/html"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    [self.manager GET:@"http://api.m.mtime.cn/PageSubArea/GetFirstPageAdvAndNews.api" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.scrollImageArray = [DYHomeScrollImage mj_objectArrayWithKeyValuesArray:responseObject[@"topPosters"]];
        [self setupHeaderView];
        
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    // 电影collectionView
    [self.manager GET:@"http://api.m.mtime.cn/PageSubArea/HotPlayMovies.api?locationId=561" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.movies = [DYHomeMovie mj_objectArrayWithKeyValuesArray:responseObject[@"movies"]];
        self.totalHotMovie = [responseObject[@"totalHotMovie"] integerValue];
        self.totalComingMovie = [responseObject[@"totalComingMovie"] integerValue];
        self.totalCinemaCount = [responseObject[@"totalCinemaCount"] integerValue];
        [self setupHeaderView];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    // 资讯
    NSInteger pageIndex = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageIndex"] = @(pageIndex);
    [self.manager GET:@"http://api.m.mtime.cn/PageSubArea/GetHomeFeed.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *temp = [DYZiXun mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (temp.count == 0) {
            return ;
        }
        self.zixunArray = (NSMutableArray *)temp;
        self.pageIndex = pageIndex;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
// 资讯http://api.m.mtime.cn/PageSubArea/GetHomeFeed.api?pageIndex=1
#pragma mark - 加载数据
- (void)loadData {
    NSInteger pageIndex = self.pageIndex + 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageIndex"] = @(pageIndex);
    [self.manager GET:@"http://api.m.mtime.cn/PageSubArea/GetHomeFeed.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSArray *temp = [DYZiXun mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        if (temp.count == 0) {
            return ;
        }
        [self.zixunArray addObjectsFromArray:temp];
        self.pageIndex = pageIndex;
        [self.tableView.mj_footer endRefreshing];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.zixunArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYHomeTableViewCell *cell = [DYHomeTableViewCell homeCellWithTableView:tableView];
 
    cell.zixun = self.zixunArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYZiXun *zixun = self.zixunArray[indexPath.row];
    
    return zixun.cellHeight;
}

// 这是为了保证，模态的控制器退出后，本控制器顶部保持原样
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:self.tableView];
}

#pragma mark - <UITableViewDelegate>控制颜色渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    CGFloat alphaScale = offset.y / 80.0;
    
    DYNavigationController *nav = (DYNavigationController *)self.navigationController;
    nav.navBarBgView.alpha = alphaScale;
    
    // 让下边有弹簧效果，上边没有。这里注意值传递的问题。scrollView.contentOffset不能换成上边的offset
    if (scrollView.contentOffset.y <= 0) {
        CGPoint TmpOffset = scrollView.contentOffset;
        TmpOffset.y = 0;
        scrollView.contentOffset = TmpOffset;
    }
}


- (void)dealloc{
    [self.manager invalidateSessionCancelingTasks:YES];
}

@end
