//
//  DYReviewTableVController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYReviewTableVController.h"
#import "DYReview.h"
#import "DYReviewHeaderView.h"
#import <AFNetworking.h>
#import <MJRefresh.h>
#import <MJExtension.h>
#import "DYReviewTableVCell.h"
#import "DYDetailReviewViewController.h"
#import "DYMovieInReview.h"
@interface DYReviewTableVController ()
/** manager */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** 大图的模型 */
@property (strong, nonatomic) DYReview *bigImageReview;
/** Reviews */
@property (strong, nonatomic) NSArray *reviews;

/** bigImageFlag记录大图数据是否加载成功 */
@property (assign, nonatomic) BOOL bigSuccessFlag;
/** cellFlag记录cell数据是否加载成功 */
@property (assign, nonatomic) BOOL cellSuccessFlag;
/** bigImageFlag记录大图数据是否加载失败 */
@property (assign, nonatomic) BOOL bigFailFlag;
/** cellFlag记录cell数据是否加载失败 */
@property (assign, nonatomic) BOOL cellFailFlag;
@end

static NSString * const identifier = @"DYReviewTableViewCell";

@implementation DYReviewTableVController
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
    [self setupRefresh];
}

- (void)setuptableView{
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DYReviewTableVCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    self.tableView.rowHeight = 153;
    // 让滑动条的内边距跟着变化
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - 设置tableViewHeader
- (void)setupHeaderView{
    DYReviewHeaderView *header = [DYReviewHeaderView reviewHeaderView];
    header.review = self.bigImageReview;
    header.height = 220;
    header.tapReview = ^(NSInteger review_ID, NSString *movieName){
        DYDetailReviewViewController *detailReviewVC = [[DYDetailReviewViewController alloc] init];
        detailReviewVC.reviewID = review_ID;
        detailReviewVC.movieName = movieName;
        [self.navigationController pushViewController:detailReviewVC animated:YES];
    };
    self.tableView.tableHeaderView = header;
}

#pragma mark - 设置tableViewFooter
- (void)setupFooterView{
    UIView *footer = [[UIView alloc] init];
    footer.height = 40;
    footer.width = self.tableView.width;
    footer.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"暂时就这么多影评";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    [footer addSubview:label];
    label.center = footer.center;
    self.tableView.tableFooterView = footer;
}

#pragma mark - 设置上拉下拉刷新(这里数据较少，不设置上拉)
- (void)setupRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadReviews)];
    [self.tableView.mj_header beginRefreshing];
}

// 大图 http://api.m.mtime.cn/PageSubArea/GetRecommendationIndexInfo.api
// 下边的tableVeiw http://api.m.mtime.cn/MobileMovie/Review.api?needTop=false
#pragma mark - 从服务器请求数据
- (void)loadReviews{
    self.bigSuccessFlag = NO;
    self.cellSuccessFlag = NO;
    self.bigFailFlag = NO;
    self.cellFailFlag = NO;
    
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"text/html"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    // 加载大图数据
    [self.manager GET:@"http://api.m.mtime.cn/PageSubArea/GetRecommendationIndexInfo.api" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.bigSuccessFlag = YES;
        if (self.cellSuccessFlag == YES || self.cellFailFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
        self.bigImageReview = [DYReview mj_objectWithKeyValues:responseObject[@"review"]];
        [self setupHeaderView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.bigFailFlag = YES;
        if (self.cellFailFlag == YES || self.cellSuccessFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
    }];
    
    // 加载下边的tableView
    [self.manager GET:@"http://api.m.mtime.cn/MobileMovie/Review.api?needTop=false" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.cellSuccessFlag = YES;
        if (self.bigSuccessFlag == YES || self.bigFailFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
        self.reviews = [DYReview mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        [self setupFooterView];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        self.cellFailFlag = YES;
        if (self.bigSuccessFlag == YES || self.bigFailFlag == YES) {
            [self.tableView.mj_header endRefreshing];
        }
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.reviews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYReviewTableVCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    DYReview *review = self.reviews[indexPath.row];
    cell.review = review;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DYReview *review = self.reviews[indexPath.row];
    DYDetailReviewViewController *detailReviewVC = [[DYDetailReviewViewController alloc] init];
    detailReviewVC.reviewID = review.cellID;
    DYMovieInReview *movie = review.movie;
    detailReviewVC.movieName = movie.title;
    [self.navigationController pushViewController:detailReviewVC animated:YES];
}

- (void)dealloc{
    [self.manager invalidateSessionCancelingTasks:YES];
}

@end
