//
//  DYTrailerTableVController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTrailerTableVController.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "DYTrailer.h"
#import "DYTrailerTableVCell.h"
#import "DYTrailerHeaderView.h"
#import "DYVideoPlayViewController.h"

@interface DYTrailerTableVController ()
/** manager */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** 大图的模型 */
@property (strong, nonatomic) DYTrailer *bigImageTrailer;
/** trailers */
@property (strong, nonatomic) NSArray *trailers;

// 这里涉及到两个网络请求，所以要全部完成的时候才能停止刷新控制，需要同步
/** bigImageFlag记录大图数据是否加载成功 */
@property (assign, nonatomic) BOOL bigSuccessFlag;
/** cellFlag记录cell数据是否加载成功 */
@property (assign, nonatomic) BOOL cellSuccessFlag;
/** bigImageFlag记录大图数据是否加载失败 */
@property (assign, nonatomic) BOOL bigFailFlag;
/** cellFlag记录cell数据是否加载失败 */
@property (assign, nonatomic) BOOL cellFailFlag;
@end

static NSString * const identifier = @"DYTrailerTableViewCell";

@implementation DYTrailerTableVController

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
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DYTrailerTableVCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    self.tableView.rowHeight = 117;
    // 让滑动条的内边距跟着变化
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - 设置tableViewHeader
- (void)setupTableViewHeader{
    DYTrailerHeaderView *header = [DYTrailerHeaderView trailerHeaderView];
    header.trailer = self.bigImageTrailer;
    header.height = 220;
    self.tableView.tableHeaderView = header;
}

#pragma mark - 设置tableViewFooter
- (void)setupFooterView{
    UIView *footer = [[UIView alloc] init];
    footer.height = 40;
    footer.width = self.tableView.width;
    footer.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"暂时没有更多的预告片";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    [footer addSubview:label];
    label.center = footer.center;
    
    self.tableView.tableFooterView = footer;
}
#pragma mark - 设置上拉下拉刷新(这里数据较少，不设置上拉)
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadTrailers)];
    [self.tableView.mj_header beginRefreshing];
}

// 大图 http://api.m.mtime.cn/PageSubArea/GetRecommendationIndexInfo.api
// 下边的tableVeiw http://api.m.mtime.cn/PageSubArea/TrailerList.api
#pragma mark - 从服务器请求数据
- (void)loadTrailers{
    self.bigSuccessFlag = NO;
    self.cellSuccessFlag = NO;
    self.bigFailFlag = NO;
    self.cellFailFlag = NO;
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"text/html"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    [self.manager GET:@"http://api.m.mtime.cn/PageSubArea/GetRecommendationIndexInfo.api" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.bigSuccessFlag = YES;
        if (self.cellSuccessFlag == YES || self.cellFailFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
        self.bigImageTrailer = [DYTrailer mj_objectWithKeyValues:responseObject[@"trailer"]];
        [self setupTableViewHeader];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.bigFailFlag = YES;
        if (self.cellFailFlag == YES || self.cellSuccessFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
    }];
    
    [self.manager GET:@"http://api.m.mtime.cn/PageSubArea/TrailerList.api" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.cellSuccessFlag = YES;
        if (self.bigSuccessFlag == YES || self.bigFailFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
        self.trailers = [DYTrailer mj_objectArrayWithKeyValuesArray:responseObject[@"trailers"]];
        [self setupFooterView];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.cellFailFlag = YES;
        if (self.bigSuccessFlag == YES || self.bigFailFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.trailers.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYTrailerTableVCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    DYTrailer *trailer = self.trailers[indexPath.row];
    cell.trailer = trailer;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DYTrailer *trailer = self.trailers[indexPath.row];
    DYVideoPlayViewController *playVc = [[DYVideoPlayViewController alloc] init];
    playVc.vedioName = trailer.movieName;
    NSLog(@"%@", trailer.movieName);
    playVc.hightUrl = trailer.hightUrl;
    [self presentViewController:playVc animated:YES completion:nil];
}

- (void)dealloc{
    [self.manager invalidateSessionCancelingTasks:YES];
}
@end
