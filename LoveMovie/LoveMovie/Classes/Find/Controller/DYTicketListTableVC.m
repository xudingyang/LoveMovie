//
//  DYTicketListTableVC.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/20.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTicketListTableVC.h"
#import "DYNoHighlitedButton.h"
#import "DYTicketListTableViewCell.h"
#import <MJRefresh.h>
#import <MJExtension.h>
#import <AFNetworking.h>
#import "DYTicketList.h"
#import "DYMovieInTicketList.h"
#import "DYHeaderInTicketList.h"
#import "DYMovieDetailVC.h"

@interface DYTicketListTableVC ()
/** manager */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** ticketList */
@property (strong, nonatomic) DYTicketList *ticketList;
@end

static NSString * const identifier = @"DYTicketListCell";

@implementation DYTicketListTableVC

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
    self.tableView.contentInset = UIEdgeInsetsMake(64 + DYIndicatorHeight, 0, 49, 0);
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DYTicketListTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    self.tableView.rowHeight = 168;
    // 让滑动条的内边距跟着变化
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - 设置刷新控件
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadData)];
    [self.tableView.mj_header beginRefreshing];
}

// http://api.m.mtime.cn/TopList/TopListDetailsByRecommend.api?locationId=561&pageIndex=1&pageSubAreaID=2020
- (void)loadData{
    
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"application/x-javascript"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"locationId"] = @(561);
    params[@"pageIndex"] = @(1);
    params[@"pageSubAreaID"] = @(self.areaNumber);
    
    [self.manager GET:@"http://api.m.mtime.cn/TopList/TopListDetailsByRecommend.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.ticketList = [DYTicketList mj_objectWithKeyValues:responseObject];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.ticketList.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYTicketListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    DYMovieInTicketList *movie = self.ticketList.movies[indexPath.row];
    cell.movie = movie;
    return cell;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    // 创建view
    UIView *header = [[UIView alloc] init];
    header.width = self.tableView.width;
    header.height = 30;
    header.x = 0;
    header.y = 0;
    // 增加毛玻璃效果
    UIToolbar *bar = [[UIToolbar alloc] init];
    bar.frame = header.bounds;
    [header addSubview:bar];
    // 添加label
    UILabel *label = [[UILabel alloc] init];
    DYHeaderInTicketList *headerList = self.ticketList.header;
    label.text = headerList.summary;   //@"2016.5.13-2016.5.34 (单位：万美元)";
    label.textColor = [UIColor darkGrayColor];
    [label sizeToFit];
    label.center = bar.center;
    [header addSubview:label];
    return header;
}

- (void)dealloc{
    [self.manager invalidateSessionCancelingTasks:YES];
}

@end
