//
//  DYNewsTableVController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYNewsTableVController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFNetworking.h>
#import "DYNewsHeaderView.h"
#import "DYNews.h"
#import "DYNewsTableViewCell.h"

@interface DYNewsTableVController ()
/** manager */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** 大图的模型 */
@property (strong, nonatomic) DYNews *bigImageNews;
/** news */
@property (strong, nonatomic) NSMutableArray *news;
/** pageIndex */
@property (assign, nonatomic) NSInteger pageIndex;

/** bigImageFlag记录大图数据是否加载成功 */
@property (assign, nonatomic) BOOL bigSuccessFlag;
/** cellFlag记录cell数据是否加载成功 */
@property (assign, nonatomic) BOOL cellSuccessFlag;
/** bigImageFlag记录大图数据是否加载失败 */
@property (assign, nonatomic) BOOL bigFailFlag;
/** cellFlag记录cell数据是否加载失败 */
@property (assign, nonatomic) BOOL cellFailFlag;
@end

static NSString * const identifier = @"DYNewsTableViewCell";

@implementation DYNewsTableVController

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
    [self setuptableView];
}

#pragma mark - 设置tableView
- (void)setuptableView{
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    // 让滑动条的内边距跟着变化
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - 设置header
- (void)setupTableViewHeader{
    DYNewsHeaderView *header = [DYNewsHeaderView newsHeaderView];
    header.height = 290;
    header.news = self.bigImageNews;
    self.tableView.tableHeaderView = header;
}

#pragma mark - 设置刷新控件
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewNews)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreNews)];
}

#pragma mark - 下拉请求数据
- (void)loadNewNews{
    self.bigSuccessFlag = NO;
    self.cellSuccessFlag = NO;
    self.bigFailFlag = NO;
    self.cellFailFlag = NO;
    
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"text/html"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    // 加载header大图
    [self.manager GET:@"http://api.m.mtime.cn/PageSubArea/GetRecommendationIndexInfo.api" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.bigImageNews = [DYNews mj_objectWithKeyValues:responseObject[@"news"]];
        [self setupTableViewHeader];
        self.bigSuccessFlag = YES;
        if (self.cellSuccessFlag == YES || self.cellFailFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.bigFailFlag = YES;
        if (self.cellFailFlag == YES || self.cellSuccessFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
    }];
    
    NSInteger pageIndex = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageIndex"] = @(pageIndex);
    [self.manager GET:@"http://api.m.mtime.cn/News/NewsList.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.cellSuccessFlag = YES;
        if (self.bigSuccessFlag == YES || self.bigFailFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
        if (![responseObject[@"newsList"] isKindOfClass:[NSArray class]]) {
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        self.news = [DYNews mj_objectArrayWithKeyValuesArray:responseObject[@"newsList"]];
        self.pageIndex = pageIndex;
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.cellFailFlag = YES;
        if (self.bigSuccessFlag == YES || self.bigFailFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

#pragma mark - 上拉请求更多的数据
- (void)loadMoreNews{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSInteger pageIndex = self.pageIndex + 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"pageIndex"] = @(pageIndex);
    [self.manager GET:@"http://api.m.mtime.cn/News/NewsList.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (![responseObject[@"newsList"] isKindOfClass:[NSArray class]]) {
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        NSArray *tmp = [DYNews mj_objectArrayWithKeyValuesArray:responseObject[@"newsList"]];
        [self.news addObjectsFromArray:tmp];
        self.pageIndex = pageIndex;
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
        
        // 最后一页了，显示没有数据
        if (pageIndex >= 12) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.news.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYNewsTableViewCell *cell = [DYNewsTableViewCell newsCellWithTableView:tableView];

    DYNews *news = self.news[indexPath.row];
    cell.news = news;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYNews *news = self.news[indexPath.row];
    return news.cellHeight;
}

- (void)dealloc{
    [self.manager invalidateSessionCancelingTasks:YES];
}

@end
