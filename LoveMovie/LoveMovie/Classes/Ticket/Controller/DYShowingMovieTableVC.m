//
//  DYShowingMovieTableVC.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/13.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYShowingMovieTableVC.h"
#import "DYHotMovie.h"
#import "DYShowingMovieTableVCell.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "DYMovieDetailVC.h"

@interface DYShowingMovieTableVC ()
/** hotMovies 存放服务器发来的电影数据*/
@property (strong, nonatomic) NSArray *hotMoviews;
/** manage */
@property (strong, nonatomic) AFHTTPSessionManager *manage;
@end

static NSString * const identifier = @"showingMovieCell";

@implementation DYShowingMovieTableVC

#pragma mark - 懒加载manage
- (AFHTTPSessionManager *)manage{
    if (_manage == nil) {
        _manage = [AFHTTPSessionManager manager];
    }
    return _manage;
}
#pragma mark - 懒加载hotMovies
- (NSArray *)hotMoviews{
    if (_hotMoviews == nil) {
        _hotMoviews = [NSArray array];
    }
    return _hotMoviews;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self loadHotMovies];
}

#pragma mark -设置tableView
- (void)setupTableView{
    self.view.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(64 + DYIndicatorHeight, 0, 49, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 140;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DYShowingMovieTableVCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    // 让滑动条的内边距跟着变化
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

- (void)setupFooterView{
    UIView *footer = [[UIView alloc] init];
    footer.height = 40;
    footer.width = self.tableView.width;
    footer.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"正在热映的影片就这些啦";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    [footer addSubview:label];
    label.center = footer.center;
    
    self.tableView.tableFooterView = footer;
}

/**
 *  GET方式  http://api.m.mtime.cn/Showtime/LocationMovies.api?locationId=561
 */
#pragma mark - 加载数据
- (void)loadHotMovies{
    
    [SVProgressHUD showWithStatus:@"臣妾正在玩命加载..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];

    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manage.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"application/x-javascript"];
    [mutSet addObject:@"text/html"];
     self.manage.responseSerializer.acceptableContentTypes = mutSet;
    
    [self.manage GET:@"http://api.m.mtime.cn/Showtime/LocationMovies.api?locationId=561" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        self.hotMoviews = [DYHotMovie mj_objectArrayWithKeyValuesArray:responseObject[@"ms"]];
        [self setupFooterView];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"网络太差，臣妾做不到!"];
        DYLog(@"%@", error);
    }];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.hotMoviews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYShowingMovieTableVCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.hotMovie = self.hotMoviews[indexPath.row];
    return cell;
}

#pragma mark - tableView代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DYHotMovie *movie = self.hotMoviews[indexPath.row];
    
    DYMovieDetailVC *vc = [[DYMovieDetailVC alloc] init];
    vc.movieType = movie.movieType;
    vc.movieScore = movie.movieScore;
    vc.showDateArea = movie.showDateArea;
    vc.movieName = movie.movieName;
    vc.movieEnName = movie.englishName;
    vc.movieLength = movie.movieLenght;
    vc.iconUrl = movie.moviewIcon;
    vc.movieID = movie.moviewID;
    vc.isTicket = movie.isTicket;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - dealloc方法
- (void)dealloc{
    [self.manage invalidateSessionCancelingTasks:YES];
}

@end
