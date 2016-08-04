//
//  DYTopListTableVController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTopListTableVController.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFNetworking.h>
#import "DYTopList.h"
#import "DYTopListHeaderView.h"
#import "DYTop100TableVC.h"

@interface DYTopListTableVController ()
/** manager */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** pageIndex */
@property (assign, nonatomic) NSInteger pageIndex;
/** 大图的模型 */
@property (strong, nonatomic) DYTopList *bigImageTopList;
/** cell数据的数组 */
@property (strong, nonatomic) NSMutableArray *topLists;

/** bigImageFlag记录大图数据是否加载成功 */
@property (assign, nonatomic) BOOL bigSuccessFlag;
/** cellFlag记录cell数据是否加载成功 */
@property (assign, nonatomic) BOOL cellSuccessFlag;
/** bigImageFlag记录大图数据是否加载失败 */
@property (assign, nonatomic) BOOL bigFailFlag;
/** cellFlag记录cell数据是否加载失败 */
@property (assign, nonatomic) BOOL cellFailFlag;
@end

static NSString * const identifier = @"DYTopListTableViewCell";

@implementation DYTopListTableVController

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

#pragma mark - 设置tableViewHeaderView
- (void)setupTableViewHeaderView{
    DYTopListHeaderView *headerView = [DYTopListHeaderView topListHeaderView];
    headerView.height = 320;
    headerView.topList = self.bigImageTopList;
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - 设置刷新控件
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopList)];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoretopList)];
}

// 大图 http://api.m.mtime.cn/PageSubArea/GetRecommendationIndexInfo.api
// cell的数据 http://api.m.mtime.cn/TopList/TopListOfAll.api?pageIndex=1
#pragma mark - 下拉刷新
- (void)loadNewTopList{
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
        self.bigSuccessFlag = YES;
        if (self.cellSuccessFlag == YES || self.cellFailFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
        self.bigImageTopList = [DYTopList mj_objectWithKeyValues:responseObject[@"topList"]];
        [self setupTableViewHeaderView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.bigFailFlag = YES;
        if (self.cellFailFlag == YES || self.cellSuccessFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
    }];
    // 加载下边cell的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSInteger pageIndex = 1;
    params[@"pageIndex"] = @(pageIndex);
    [self.manager GET:@"http://api.m.mtime.cn/TopList/TopListOfAll.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.cellSuccessFlag = YES;
        if (self.bigSuccessFlag == YES || self.bigFailFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
        // 因为这里涉及到往可变数组中添加数据，所以需要判断所添加的数据是否为nil。因为往可变数组中添加Nil,会导致崩溃。
        if (![responseObject[@"topLists"] isKindOfClass:[NSArray class]]) {
            [self.tableView.mj_header endRefreshing];
            return ;
        }
        self.pageIndex = pageIndex;
        self.topLists = [DYTopList mj_objectArrayWithKeyValuesArray:responseObject[@"topLists"]];
        [self.tableView reloadData];
        // 最后一页了，显示没有数据
        if (pageIndex >= [responseObject[@"pageCount"] integerValue] || self.topLists.count >= [responseObject[@"totalCount"] integerValue]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.cellFailFlag = YES;
        if (self.bigSuccessFlag == YES || self.bigFailFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

#pragma mark - 上拉加载更多
- (void)loadMoretopList{
    // 结束之前的所有请求
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"text/html"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    // 加载下边cell的数据
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSInteger pageIndex = self.pageIndex + 1;
    params[@"pageIndex"] = @(pageIndex);
    [self.manager GET:@"http://api.m.mtime.cn/TopList/TopListOfAll.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 因为这里涉及到往可变数组中添加数据，所以需要判断所添加的数据是否为nil。因为往可变数组中添加Nil,会导致崩溃
        if (![responseObject[@"topLists"] isKindOfClass:[NSArray class]]) {
            [self.tableView.mj_footer endRefreshing];
            return ;
        }
        [self.tableView.mj_footer endRefreshing];
        self.pageIndex = pageIndex;
        NSArray *tmpArray = [DYTopList mj_objectArrayWithKeyValuesArray:responseObject[@"topLists"]];
        [self.topLists addObjectsFromArray:tmpArray];
        
        [self.tableView reloadData];
        
        // 最后一页了，显示没有数据
        if (pageIndex >= [responseObject[@"pageCount"] integerValue] || self.topLists.count >= [responseObject[@"totalCount"] integerValue]) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];

}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topLists.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    DYTopList *topList = self.topLists[indexPath.row];
    
    cell.textLabel.text = topList.topListNameCn;
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    cell.textLabel.numberOfLines = 2;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DYTopList *topList = self.topLists[indexPath.row];
    DYTop100TableVC *vc = [DYTop100TableVC alloc];
    vc.top100VcType = DYCellTop100;
    vc.topListId = topList.topListID;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc{
    [self.manager invalidateSessionCancelingTasks:YES];
}

@end
