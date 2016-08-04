//
//  DYComingMovieVC.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/13.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYComingMovieVC.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>
#import "DYComingMovie.h"
#import "DYAttentionColletionVCell.h"
#import "DYComingMoiveGroup.h"
#import "DYComingTableVCell.h"
#import "DYMovieDetailVC.h"

@interface DYComingMovieVC () <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

/** attentions */
@property (strong, nonatomic) NSArray *attentions;
/** moviecomings */
@property (strong, nonatomic) NSArray *moviecomings;
/** movieComingGroups */
@property (strong, nonatomic) NSMutableArray *movieComingGroups;
/** manager */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** UITableView *tableView */
@property (weak, nonatomic) UITableView *tableView;
/** UIView *headerView */
@property (weak, nonatomic) UIView *headerView;
/** UICollectionView *collectionView  */
@property (weak, nonatomic) UICollectionView *collectionView;
@end

static NSString * const collectionCellID = @"DYAttentionMovieCell";
static NSString * const tableViewCellID = @"DYComingMovieCell";

@implementation DYComingMovieVC

#pragma mark - 懒加载manage
- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 懒加载attentions
- (NSArray *)attentions{
    if (_attentions == nil) {
        _attentions = [NSArray array];
    }
    return _attentions;
}

#pragma mark - 懒加载moviecomings
- (NSArray *)moviecomings{
    if (_moviecomings == nil) {
        _moviecomings = [NSArray array];
    }
    return _moviecomings;
}

#pragma mark - 懒加载movieComingGroups
- (NSMutableArray *)movieComingGroups{
    if (_movieComingGroups == nil) {
        _movieComingGroups = [NSMutableArray array];
    }
    return _movieComingGroups;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DYGlobalBackgroundColor;
    [self loadComingMovies];
    [self setupTableView];
    
}

#pragma mark - 设置tableView
- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc] init];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.frame = self.view.bounds;
    tableView.contentInset = UIEdgeInsetsMake(64 + DYIndicatorHeight, 0, 49, 0);
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.rowHeight = 140;
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DYComingTableVCell class]) bundle:nil] forCellReuseIdentifier:tableViewCellID];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 让滑动条的内边距跟着变化
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - 设置tableViewHeader
- (void)setupTableViewHeader{
    // 创建headerView
    UIView *headerView = [[UIView alloc] init];
    headerView.width = self.tableView.width;
    headerView.height = 290;
    self.headerView = headerView;
    
    // 标题“最受关注”
    UIView *content = [[UIView alloc] initWithFrame:CGRectMake(0, 0, headerView.width, 40)];
    content.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"最受关注";
    label.x = 15;
    label.font = [UIFont boldSystemFontOfSize:20];
    [label sizeToFit];
    label.y = (content.height - label.height) * 0.8;
    [content addSubview:label];
    [headerView addSubview:content];
    
    // collectionView
    [self setupCollectionView];
    
    // tableView第一组组头上边的（不属于组头）
    UIView *bottom = [[UIView alloc] init];
    bottom.backgroundColor = [UIColor whiteColor];
    bottom.x = 0;
    bottom.y = self.collectionView.y + self.collectionView.height + 20;
    bottom.width = headerView.width;
    bottom.height = headerView.height - bottom.y;
    UILabel *comingLabel = [[UILabel alloc] init];
    comingLabel.text = [NSString stringWithFormat:@"即将上映(%zd部)", self.moviecomings.count];
    comingLabel.font = [UIFont boldSystemFontOfSize:20];
    [comingLabel sizeToFit];
    comingLabel.x = 15;
    comingLabel.y = (bottom.height - comingLabel.height) * 0.5;
    [bottom addSubview:comingLabel];
    [headerView addSubview:bottom];
    
    self.tableView.tableHeaderView = headerView;
    
}

#pragma mark - 设置collectionView
- (void)setupCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(340, 185);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    
    UICollectionView *collectionView  = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 40, self.headerView.width, 190) collectionViewLayout:flowLayout];
    
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([DYAttentionColletionVCell class]) bundle:nil] forCellWithReuseIdentifier:collectionCellID];
    
    [self.headerView addSubview:collectionView];
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.contentInset = UIEdgeInsetsMake(0, 5, 0, 5);
    self.collectionView = collectionView;
    collectionView.dataSource = self;
    collectionView.delegate = self;
}

#pragma mark - 设置tableViewFooter
- (void)setupTableViewFooter{
    UIView *footer = [[UIView alloc] init];
    footer.height = 40;
    footer.width = self.tableView.width;
    footer.backgroundColor = [UIColor clearColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"即将上映的影片就这些啦";
    label.textColor = [UIColor lightGrayColor];
    label.font = [UIFont systemFontOfSize:16];
    [label sizeToFit];
    [footer addSubview:label];
    label.center = footer.center;
    
    self.tableView.tableFooterView = footer;
}

#pragma mark - 从服务器请求数据
- (void)loadComingMovies{
    
    [SVProgressHUD showWithStatus:@"臣妾正在玩命加载..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"application/x-javascript"];
    [mutSet addObject:@"text/html"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    [self.manager GET:@"http://api.m.mtime.cn/Movie/MovieComingNew.api?locationId=561" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [SVProgressHUD dismiss];
        
        self.attentions = [DYComingMovie mj_objectArrayWithKeyValuesArray:responseObject[@"attention"]];
        
        self.moviecomings = [DYComingMovie mj_objectArrayWithKeyValuesArray:responseObject[@"moviecomings"]];
        
        // 因为这里用到了self.moviecomings.count，所以放这里设置
        [self setupTableViewHeader];
        [self setupTableViewFooter];
        [self.collectionView reloadData];
        
        // 按月份分组
        [self groupedMovieByMonth];

        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"网络太差，臣妾做不到!"];
    }];
     
     
}

#pragma mark - 把数据按照月份分组
- (void)groupedMovieByMonth{
    // 用集合剔除重复的数字
    NSMutableSet *set = [NSMutableSet set];
    for (DYComingMovie *comingMovie in self.moviecomings) {
        [set addObject:@(comingMovie.rMonth)];
    }
    // 转成有序数组
    NSMutableArray *tmpArray = [NSMutableArray array];
    for (NSNumber *num in set) {
        [tmpArray addObject:num];
    }
    NSArray *sortedArray = [tmpArray sortedArrayUsingSelector:@selector(compare:)]; // 系统方法，按照升序排列
    
    // 遍历月份，把对应月份的movie放到对应的数组中去
    for (int i = 0; i < sortedArray.count; i++) {
        // 用于存放 {@"month" : 月份, @"月份" : 当月movie数组 }
        // 然后，把这个字典转模型，模型类中有 (月份) (movie数组) 两个属性
        NSMutableDictionary *mutDict = [NSMutableDictionary dictionary];
        // 用来存放该月movie的临时数组
        NSMutableArray *mutArray = [NSMutableArray array];
        // 再次遍历所有数据，根据月份归类到对应的月份电影数组中
        for (int j = 0; j < self.moviecomings.count; j++) {
            DYComingMovie *movie = self.moviecomings[j];
            // 如果movie的月份跟当前sortedArray[i]的下边一致，说明是该月的电影。加入到该月的数组中
            if (movie.rMonth == [sortedArray[i] integerValue]) {
                [mutArray addObject:movie];
            }
        } // end for 该月的movie已全部加入到了该月的数组
        // 把数组加入到字典
        mutDict[@"comingMoives"] = mutArray;
        mutDict[@"keyMonth"] = sortedArray[i];
        DYComingMoiveGroup *tmpMovieGroup = [DYComingMoiveGroup mj_objectWithKeyValues:mutDict];
        [self.movieComingGroups addObject:tmpMovieGroup];
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.movieComingGroups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    // 得到当月的一个movie数组
    DYComingMoiveGroup *group = self.movieComingGroups[section];
    // 该movie数组里元素的个数
    return group.comingMoives.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DYComingTableVCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellID];
    // 得到当月的一个movie数组
    DYComingMoiveGroup *group = self.movieComingGroups[indexPath.section];
    // 得到该movie数组中的一个movie元素
    DYComingMovie *movie = group.comingMoives[indexPath.row];
    cell.movie = movie;
    return cell;
}

#pragma mark - UITableViewDelegate
// 这个方法不能漏掉，不然不知道header的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    DYComingMoiveGroup *group = self.movieComingGroups[section];
    
    UIView *sectionHeaderView = [[UIView alloc] init];
    sectionHeaderView.height = 30;
    sectionHeaderView.width = self.tableView.width;
    sectionHeaderView.x = 0;
    sectionHeaderView.y = 0;
    sectionHeaderView.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"%zd月", group.keyMonth];
    label.font = [UIFont systemFontOfSize:15];
    label.x = 15;
    label.height = 29;
    label.width = 60;
    label.y = 0;
    [sectionHeaderView addSubview:label];
    
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.height = 1;
    bottomLine.x = 15;
    bottomLine.y = sectionHeaderView.height - bottomLine.height;
    bottomLine.width = sectionHeaderView.width - bottomLine.x;
    bottomLine.backgroundColor = [UIColor blackColor];
    bottomLine.alpha = 0.2;
    [sectionHeaderView addSubview:bottomLine];
    
    return sectionHeaderView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DYComingMoiveGroup *group = self.movieComingGroups[indexPath.section];
    DYComingMovie *movie = group.comingMoives[indexPath.row];
    
    DYMovieDetailVC *vc = [[DYMovieDetailVC alloc] init];
    vc.movieType = movie.type;
    vc.movieScore = -1.0;
    vc.showDateArea = movie.showDateArea;
    vc.movieName = movie.movieName;
    vc.movieEnName = movie.movieName;
    vc.movieLength = 0;
    vc.iconUrl = movie.image;
    vc.movieID = movie.moviewID;
    vc.isTicket = movie.isTicket;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.attentions.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DYAttentionColletionVCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellID forIndexPath:indexPath];
    cell.movie = self.attentions[indexPath.item];
    
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DYComingMovie *movie = self.attentions[indexPath.item];
    
    DYMovieDetailVC *vc = [[DYMovieDetailVC alloc] init];
    vc.movieType = movie.type;
    vc.movieScore = -1.0;
    vc.showDateArea = movie.showDateArea;
    vc.movieName = movie.movieName;
    vc.movieEnName = movie.movieName;
    vc.movieLength = 0;
    vc.iconUrl = movie.image;
    vc.movieID = movie.moviewID;
    vc.isTicket = movie.isTicket;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - dealloc方法
- (void)dealloc{
    [self.manager invalidateSessionCancelingTasks:YES];
}
@end
