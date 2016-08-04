//
//  DYTrailerTableViewController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/26.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTrailerTableViewController.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "DYVideo.h"
#import "DYHomeTrailerTableViewCell.h"
#import "DYVideoPlayViewController.h"

@interface DYTrailerTableViewController ()
/** manage */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** pageIndex */
@property (assign, nonatomic) NSInteger pageIndex;

/** videos */
@property (strong, nonatomic) NSMutableArray *videos;
@end

static NSString * const identifier = @"DYHomeTrailerTableViewCell";

@implementation DYTrailerTableViewController

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

#pragma mark - 设置tableView
- (void)setupTableView{
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"application/x-javascript"];
    [mutSet addObject:@"text/html"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DYHomeTrailerTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    
    self.tableView.rowHeight = 120;
    
    self.navigationItem.title = @"预告片&拍摄花絮";
}

#pragma mark - 设置刷新控件
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstPage)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

// http://api.m.mtime.cn/Movie/Video.api?movieId=209122&pageIndex=1
#pragma mark - 加载第一页数据
- (void)loadFirstPage{
    NSInteger pageIndex = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"movieId"] = @(self.movieID);
    params[@"pageIndex"] = @(pageIndex);
    [self.manager GET:@"http://api.m.mtime.cn/Movie/Video.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.videos = [DYVideo mj_objectArrayWithKeyValuesArray:responseObject[@"videoList"]];
        self.pageIndex = pageIndex;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        if (self.pageIndex >= [responseObject[@"totalPageCount"] integerValue] || self.videos.count >= [responseObject[@"totalCount"] integerValue]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - 加载新数据
- (void)loadMoreData{
    NSInteger pageIndex = self.pageIndex + 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"movieId"] = @(self.movieID);
    params[@"pageIndex"] = @(pageIndex);
    [self.manager GET:@"http://api.m.mtime.cn/Movie/Video.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject[@"videoList"] isKindOfClass:[NSArray class]]) {
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        
        NSArray *temp = [DYVideo mj_objectArrayWithKeyValuesArray:responseObject[@"videoList"]];
        [self.videos addObjectsFromArray:temp];
        self.pageIndex = pageIndex;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        if (self.pageIndex >= [responseObject[@"totalPageCount"] integerValue] || self.videos.count >= [responseObject[@"totalCount"] integerValue]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.videos.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYHomeTrailerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    DYVideo *video = self.videos[indexPath.row];
    cell.video = video;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DYVideo *video = self.videos[indexPath.row];
    DYVideoPlayViewController *playVc = [[DYVideoPlayViewController alloc] init];
    playVc.vedioName = video.title;
    playVc.hightUrl = video.hightUrl;
    [self presentViewController:playVc animated:YES completion:nil];
}

- (void)dealloc{
    [self.manager invalidateSessionCancelingTasks:YES];
}

@end
