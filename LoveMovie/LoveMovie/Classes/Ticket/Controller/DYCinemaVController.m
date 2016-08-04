//
//  DYCinemaVController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/13.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYCinemaVController.h"
#import "DYCinema.h"
#import "DYCinemaTableViewCell.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>

@interface DYCinemaVController ()
/** manager */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** cinema数组 */
@property (strong, nonatomic) NSArray *cinemas;
@end

static NSString *identifier = @"cinemaTableViewCell";

@implementation DYCinemaVController

#pragma mark - 懒加载manager
- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self loadData];
}

- (void)setupTableView {
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DYCinemaTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.backgroundColor = DYGlobalBackgroundColor;
    self.tableView.estimatedRowHeight = 40;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

// http://api.m.mtime.cn/OnlineLocationCinema/OnlineCinemasByCity.api?locationId=561
- (void)loadData {
    [SVProgressHUD showWithStatus:@"臣妾正在玩命加载..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"application/x-javascript"];
    [mutSet addObject:@"text/html"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    NSMutableDictionary *parmas = [NSMutableDictionary dictionary];
    parmas[@"locationId"] = @(self.cityID);
    [self.manager GET:@"http://api.m.mtime.cn/OnlineLocationCinema/OnlineCinemasByCity.api" parameters:parmas progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        self.cinemas = [DYCinema mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DYLog(@"%@", error);
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"网络太差，臣妾做不到!"];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cinemas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYCinemaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.cinema = self.cinemas[indexPath.row];
    return cell;
}

#pragma mark - dealloc方法
- (void)dealloc{
    [self.manager invalidateSessionCancelingTasks:YES];
}

@end
