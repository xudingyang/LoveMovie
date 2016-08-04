//
//  DYNetFriendCommentVC.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/27.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYNetFriendCommentVC.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "DYLoginViewController.h"
#import "DYNetCommentTableViewCell.h"
#import "DYCommentData.h"
#import "DYNetFriendComment.h"

@interface DYNetFriendCommentVC () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *bottomTool;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/** manage */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** pageIndex */
@property (assign, nonatomic) NSInteger pageIndex;
/** comments */
@property (strong, nonatomic) NSMutableArray *comments;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;



@end

static NSString * const identifier = @"DYNetCommentTableViewCell";

@implementation DYNetFriendCommentVC

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
    // 右边消掉
    self.navigationItem.rightBarButtonItems = nil;
}

#pragma mark - 设置tableView
- (void)setupTableView{
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DYNetCommentTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    self.tableView.backgroundColor = DYGlobalBackgroundColor;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"application/x-javascript"];
    [mutSet addObject:@"text/html"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    // 监听键盘的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChageFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChageFrame:(NSNotification *)info{
    // UIKeyboardFrameEndUserInfoKey 显示/隐藏完毕后的frame
    CGRect frame = [info.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改底部约束 = 键盘的y值
    self.bottomSpace.constant = self.view.height - frame.origin.y;
    // 动画时间
    CGFloat duration = [info.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 改了约束，不是改frame，并不会自动更新位置。这里强制布局
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - 设置刷新控件
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadFirstPage)];
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
}

- (void)loadFirstPage{
    NSInteger pageIndex = 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"movieId"] = @(self.movieID);
    params[@"pageIndex"] = @(pageIndex);
    [self.manager GET:@"http://api.m.mtime.cn/Showtime/HotMovieComments.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DYCommentData *data = [DYCommentData mj_objectWithKeyValues:responseObject[@"data"]];
        [self.tableView.mj_header endRefreshing];
        self.comments = (NSMutableArray *)data.cts;
        self.pageIndex = pageIndex;
        [self.tableView reloadData];
        self.navigationItem.title = [NSString stringWithFormat:@"短评(%zd)", data.totalCount];
        if (data.totalCount <= self.comments.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void)loadMoreData{
    NSInteger pageIndex = self.pageIndex + 1;
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"movieId"] = @(self.movieID);
    params[@"pageIndex"] = @(pageIndex);
    [self.manager GET:@"http://api.m.mtime.cn/Showtime/HotMovieComments.api" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        DYCommentData *data = [DYCommentData mj_objectWithKeyValues:responseObject[@"data"]];
        [self.tableView.mj_footer endRefreshing];
        NSArray *temp = data.cts;
        if (temp) {
            [self.comments addObjectsFromArray:temp];
        }
        self.pageIndex = pageIndex;
        [self.tableView reloadData];
        if (data.totalCount <= self.comments.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self.tableView.mj_footer endRefreshing];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.comments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYNetCommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    DYNetFriendComment *comment = self.comments[indexPath.row];
    cell.comment = comment;
    return cell;
}


- (IBAction)postClick {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"哥们，你还没登录呢" message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *login = [UIAlertAction actionWithTitle:@"登录" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.view endEditing:YES];
        DYLoginViewController *loginVc = [[DYLoginViewController alloc] init];
        [self.navigationController pushViewController:loginVc animated:YES];
    }];
    UIAlertAction *cacel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"好吧" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:login];
    [alert addAction:ok];
    [alert addAction:cacel];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)dealloc{
    [self.manager invalidateSessionCancelingTasks:YES];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
