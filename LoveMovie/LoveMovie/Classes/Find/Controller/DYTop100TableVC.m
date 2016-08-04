//
//  DYTop100TableVC.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/21.
//  Copyright © 2016年 许定阳. All rights reserved.
//

/*****************************************************
 *  总结：
 *  主要技术点：tableView数据源方法和代理方法的调用顺序
 *          ->首先  多少组（数据源方法）
 *          ->然后  每组多少行（数据源方法）
 *          ->然后  每行多高（代理方法）
 *          ->接着  返回cell(数据源方法)
 *  点击cell里的label(点击整个cell也是一样的)，执行在cell视图类里面的代理方法。
 *  代理方法传过来当前cell。把该cell对应的indexPath记录下来，该indexPath对应状态也记录下来。
 *
 *  是记录indexPath处的cell的isBig状态，而不是记录该cell的isBig状态。
 *  因为cell的缓存池机制，某indexPath处的cell不可能一直在内存中。如果indexPath处的cell进入了
 *  缓存池，那么它保存的记忆就消失了；而且当该indexPath处的cell再次存入屏幕时候，那里的cell可
 *  能不是原先的cell了，而是从缓存池取出的别的cell。所以不要记录cell的状态，而是记录indexPath
 *  对应的状态。当indexPath对应的区域再次出现在屏幕的时候，再把该区域对应的cell改变为该状态，
 *  然后，cell视图类里面根据cell的状态，调整自己的布局。
 *
 *****************************************************/






#import "DYTop100TableVC.h"
#import "DYTop100HeaderView.h"
#import "DYHeaderInTicketList.h"
#import "DYTop100TableViewCell.h"
#import "DYMovieInTicketList.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFNetworking.h>
#import "DYTicketList.h"
#import "DYNoHighlitedButton.h"
#import "DYMovieDetailVC.h"

@interface DYTop100TableVC () <DYTop100TableViewCellDelegate>

/** array */
@property (strong, nonatomic) NSMutableArray *movies;

/** index */
@property (assign, nonatomic) NSInteger index;

/** currentIndexPath */
@property (strong, nonatomic) NSIndexPath *currentIndexPath;
/** indexIsBig 点击的cell的变大缩小状态*/
@property (assign, nonatomic) BOOL indexIsBig;
/** pageIndex */
@property (assign, nonatomic) NSInteger pageIndex;
/** manager */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** ticketList */
@property (strong, nonatomic) DYTicketList *ticketList;

@end

static NSString *identifier = @"DYTop100TableViewCell";

@implementation DYTop100TableVC

#pragma mark - 懒加载manager
- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupRefresh];
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.top100VcType == DYTimeTop100 || self.top100VcType == DYChineseTop100) {
        [self setupNav];
    }
}

#pragma mark - 设置Nav
- (void)setupNav{
    // 右边item
    self.navigationItem.rightBarButtonItems = nil;
    DYNoHighlitedButton *shareBtn = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"icon_sharing"] forState:UIControlStateNormal];
    [shareBtn sizeToFit];
    [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    self.navigationItem.rightBarButtonItem = shareItem;
    self.navigationItem.title = self.title;
}

#pragma mark - 分享按钮事件监听
- (void)shareClick{
    DYLog(@"shareClick");
}

#pragma mark - 设置tableView
- (void)setupTableView{
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DYTop100TableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
}

#pragma mark - 设置tableViewHeader
- (void)setupHeaderView{
    DYTop100HeaderView *headerView = [DYTop100HeaderView top100HeaderView];
    headerView.headerList = self.ticketList.header;
    headerView.width = self.tableView.width;
    headerView.x = 0;
    headerView.y = 0;
    self.tableView.tableHeaderView = headerView;
   
}

#pragma mark - 设置刷新控件
- (void)setupRefresh{
    if (self.top100VcType == DYTimeTop100 || self.top100VcType == DYChineseTop100) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        [self.tableView.mj_header beginRefreshing];
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    } else if (self.top100VcType == DYBigTop100 || self.top100VcType == DYCellTop100) {
        self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewDataAnather)];
        [self.tableView.mj_header beginRefreshing];
        
        self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreDataAnother)];
    }
}

// http://api.m.mtime.cn/TopList/TopListDetailsByRecommend.api
#pragma mark - 加载新数据
- (void)loadNewData{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"application/x-javascript"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    NSInteger pageIndex = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"locationId"] = @(561);
    params[@"pageIndex"] = @(pageIndex);
    params[@"pageSubAreaID"] = @(self.top100VcType);
    
    [self.manager GET:@"http://api.m.mtime.cn/TopList/TopListDetailsByRecommend.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        if (![responseObject[@"movies"] isKindOfClass:[NSArray class]]) {
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        self.pageIndex = pageIndex;
        self.ticketList = [DYTicketList mj_objectWithKeyValues:responseObject];
        self.movies = [DYMovieInTicketList mj_objectArrayWithKeyValuesArray:responseObject[@"movies"]];
        [self setupHeaderView];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

// http://api.m.mtime.cn/TopList/TopListDetails.api
- (void)loadNewDataAnather{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"application/x-javascript"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    NSInteger pageIndex = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageIndex"] = @(pageIndex);
    params[@"topListId"] = @(self.topListId);
    
    [self.manager GET:@"http://api.m.mtime.cn/TopList/TopListDetails.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject[@"movies"] isKindOfClass:[NSArray class]]) {
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        self.pageIndex = pageIndex;
        self.ticketList = [DYTicketList mj_objectWithKeyValues:responseObject];
        self.movies = [DYMovieInTicketList mj_objectArrayWithKeyValuesArray:responseObject[@"movies"]];
        [self setupHeaderView];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 加载更多
- (void)loadMoreData{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"application/x-javascript"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    NSInteger pageIndex = self.pageIndex + 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"locationId"] = @(561);
    params[@"pageIndex"] = @(pageIndex);
    params[@"pageSubAreaID"] = @(self.top100VcType);
    
    [self.manager GET:@"http://api.m.mtime.cn/TopList/TopListDetailsByRecommend.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject[@"movies"] isKindOfClass:[NSArray class]]) {
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        self.pageIndex = pageIndex;
        self.ticketList = [DYTicketList mj_objectWithKeyValues:responseObject];
        NSArray *tmp = [DYMovieInTicketList mj_objectArrayWithKeyValuesArray:responseObject[@"movies"]];
        [self.movies addObjectsFromArray:tmp];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
        if ([responseObject[@"totalCount"] integerValue] <= self.movies.count || [responseObject[@"pageCount"] integerValue] <= pageIndex) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)loadMoreDataAnother{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"application/x-javascript"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    NSInteger pageIndex = self.pageIndex + 1;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageIndex"] = @(pageIndex);
    params[@"topListId"] = @(self.topListId);
    
    [self.manager GET:@"http://api.m.mtime.cn/TopList/TopListDetails.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (![responseObject[@"movies"] isKindOfClass:[NSArray class]]) {
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        self.pageIndex = pageIndex;
        self.ticketList = [DYTicketList mj_objectWithKeyValues:responseObject];
        NSArray *tmp = [DYMovieInTicketList mj_objectArrayWithKeyValuesArray:responseObject[@"movies"]];
        [self.movies addObjectsFromArray:tmp];
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
        if ([responseObject[@"totalCount"] integerValue] <= self.movies.count || [responseObject[@"pageCount"] integerValue] <= pageIndex) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYTop100TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.delegate = self;
    if (self.currentIndexPath == nil) {
        cell.isBig = NO;
    } else {
        if (self.currentIndexPath.row == indexPath.row && self.indexIsBig == YES) {
            cell.isBig = YES;
        } else if (self.currentIndexPath.row == indexPath.row && self.indexIsBig == NO){
            cell.isBig = NO;
        } else {
            cell.isBig = NO;
        }
    }
    
    DYMovieInTicketList *movie = self.movies[indexPath.row];
    cell.movie = movie;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYMovieInTicketList *movie = self.movies[indexPath.row];
    // 还未点击label的时候，currentIndexPath是Nil
    if (self.currentIndexPath == nil) {
        return movie.cellCloseHeight;
    } else{
        if (self.currentIndexPath.row == indexPath.row && self.indexIsBig == YES) {
            return movie.cellHeight;
        } else {
            return movie.cellCloseHeight;
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DYMovieInTicketList *movie = self.ticketList.movies[indexPath.row];
    
    DYMovieDetailVC *vc = [[DYMovieDetailVC alloc] init];
    vc.movieType = movie.movieType;
    vc.movieScore = movie.rating;
    vc.showDateArea = movie.showDateArea;
    vc.movieName = movie.chineseName;
    vc.movieEnName = movie.englishName;
    //    vc.movieLength = movie.movieLenght;
    vc.iconUrl = movie.posterUrl;
    vc.movieID = movie.movieID;
    vc.isTicket = movie.isTicket;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 代理方法
- (void)labelDidTapTop100Cell:(DYTop100TableViewCell *)cell{

    self.currentIndexPath = [self.tableView indexPathForCell:cell];

    self.indexIsBig = cell.isBig;

    [self.tableView reloadData];
}


- (void)dealloc{
    [self.manager invalidateSessionCancelingTasks:YES];
}
@end
