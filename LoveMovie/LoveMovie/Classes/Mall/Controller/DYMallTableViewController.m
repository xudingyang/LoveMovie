//
//  DYMallTableViewController.m
//  LoveMovie
//
//  Created by xudingyang on 16/6/3.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYMallTableViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "DYMeHotGoods.h"
#import "ScrollImage.h"
#import "DYNavigationController.h"
#import "DYNoHighlitedButton.h"
#import "DYScrollViewImage.h"
#import "DYVerticalButton.h"
#import <UIImageView+WebCache.h>
#import "DYGoodItem.h"
#import "DYSqureButton.h"
#import "DYMeWebViewController.h"
#import "DYMeHotGoodsVCell.h"
#import "DYGoodsModel.h"
#import "DYMallTableViewCell.h"
#import "DYScanQRViewController.h"
#import "DYGoodsCarViewController.h"

@interface DYMallTableViewController ()

/** 辅助属性 contentSizeY */
@property (assign, nonatomic) CGFloat contentSizeY;


/** manager */
@property (strong, nonatomic) AFHTTPSessionManager *manager;
/** footer的数组 */
@property (strong, nonatomic) NSArray *goodsArray;
/** 轮播器图片数组 */
@property (strong, nonatomic) NSMutableArray *images;
/** 中间items的数组 */
@property (strong, nonatomic) NSArray *midItems;
/** cell对应的数组 */
@property (strong, nonatomic) NSArray *cellArray;

/** header */
@property (weak, nonatomic) UIView *headerView;
/** footer */
@property (weak, nonatomic) UIView *footerView;


@end

static NSString * const identifier = @"DYMallTableViewCell";

@implementation DYMallTableViewController

#pragma mark - 懒加载manager
- (AFHTTPSessionManager *)manager{
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
    }
    return _manager;
}

#pragma mark - 懒加载images
- (NSMutableArray *)images{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}

#pragma mark - 懒加载midItems
- (NSArray *)midItems{
    if (_midItems == nil) {
        _midItems = [NSArray array];
    }
    return _midItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    [self setupTableView];
    [self loadData];
}

#pragma mark - 设置导航条
- (void)setupNav{
    // 取消自动间距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 导航栏左边有个“扫描二维码”按钮
    DYNoHighlitedButton *button1 = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[UIImage imageNamed:@"icon_scan_barcode_white"] forState:UIControlStateNormal];
    [button1 sizeToFit];
    button1.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, -10);
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button1];
    [button1 addTarget:self action:@selector(scanQRCode) forControlEvents:UIControlEventTouchUpInside];
    
    // 导航栏右边有个“购物车”按钮
    DYNoHighlitedButton *button = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"v10_cart_notify"] forState:UIControlStateNormal];
    [button sizeToFit];
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self action:@selector(goodsCar) forControlEvents:UIControlEventTouchUpInside];
    
    // 中间有个搜索框
    DYNoHighlitedButton *searchButton = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
    searchButton.width = 200;
    searchButton.height = 36;
    searchButton.layer.cornerRadius = 5;
    searchButton.layer.masksToBounds = YES;
    searchButton.backgroundColor = [UIColor whiteColor];
    [searchButton setImage:[UIImage imageNamed:@"homePage_topPoster_search"] forState:UIControlStateNormal];
    searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    
    [searchButton setTitle:@"搜索正版电影周边" forState:UIControlStateNormal];
    [searchButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.navigationItem.titleView = searchButton;
}

- (void)scanQRCode {
    DYScanQRViewController *vc = [[DYScanQRViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goodsCar {
    DYGoodsCarViewController *vc = [[DYGoodsCarViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 设置tableView
- (void)setupTableView {
    self.tableView.backgroundColor = DYGlobalBackgroundColor;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DYMallTableViewCell class]) bundle:nil] forCellReuseIdentifier:identifier];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 设置header
- (void)setupTableViewHeader {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DYScreenWidth, 460)];
    self.headerView = headerView;
    // 顶部轮播器
    ScrollImage *scrl = [[ScrollImage alloc] initWithCurrentController:self urlString:self.images viewFrame:CGRectMake(0, 0, DYScreenWidth, 240) placeholderImage:[UIImage imageNamed:@"comment-bar-bg"]];
    scrl.timeInterval = 2.0;
    [headerView addSubview:scrl.view];
    // 下端导航栏
    UIView *itemsView = [[UIView alloc] initWithFrame:CGRectMake(0, 240, DYScreenWidth, 200)];
    [headerView addSubview:itemsView];
    CGFloat btnW = DYScreenWidth / 4;
    CGFloat btnH = 100;
    for (int i = 0; i < self.midItems.count; i++) {
        DYSqureButton *btn = [DYSqureButton buttonWithType:UIButtonTypeCustom];
        btn.width = btnW;
        btn.height = btnH;
        NSInteger currentRow = i / 4;
        NSInteger currentCol = i % 4;
        btn.x = currentCol * btnW;
        btn.y = currentRow * btnH;
        btn.square = self.midItems[i];
        [itemsView addSubview:btn];
    }
    
    self.tableView.tableHeaderView = headerView;
}

#pragma mark - 设置footer
- (void)setupTableViewFootr {
    // footerView
    UIView *footerView = [[UIView alloc] init];
    footerView.x = 0;
    footerView.y = 0;
    footerView.width = DYScreenWidth;
    footerView.backgroundColor = [UIColor clearColor];
    // 添加中间分割线
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, DYScreenWidth, 40)];
    label.text = @"您可能感兴趣的";
    label.textColor = [UIColor lightGrayColor];
    label.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:label];
    label.backgroundColor = [UIColor clearColor];
    
    // 格子的父view
    UIView *collectView = [[UIView alloc] init];
    [footerView addSubview:collectView];
    collectView.width = DYScreenWidth;
    collectView.x = 0;
    collectView.y = label.y + label.height + DYMargin;
    CGFloat collectViewH = 100;  // 赋初值，等格子加进来后再更正
    // 添加底部的格子（由于数据只展示有限几个，所以直接用for循环）
    NSInteger totalColums = 2;
    NSInteger goodsCount = self.goodsArray.count;
    CGFloat cellW = (DYScreenWidth - DYMargin * 3) * 0.5;
    CGFloat cellH = cellW + 60;
    for (NSInteger i = 0; i < goodsCount; i++) {
        NSInteger currentRow = i / totalColums;
        NSInteger currentColum = i % totalColums;
        CGFloat cellX = DYMargin + (cellW + DYMargin) * currentColum;
        CGFloat cellY = (cellH + DYMargin) * currentRow;
        DYMeHotGoodsVCell *cell = [DYMeHotGoodsVCell meHotGoodsCell];
        cell.frame = CGRectMake(cellX, cellY, cellW, cellH);
        [collectView addSubview:cell];
        // 传模型
        cell.hotGoods = self.goodsArray[i];
        if (i == goodsCount - 1) {
            collectViewH = cell.y +cell.height + DYMargin;
        }
    }
    collectView.height = collectViewH;
    // 底部提示条
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, collectView.y + collectView.height, DYScreenWidth, 60)];
    label1.text = @"貌似没有更多了^_^";
    label1.font = [UIFont boldSystemFontOfSize:25];
    label1.textColor = [UIColor blackColor];
    label1.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:label1];
    label1.backgroundColor = [UIColor clearColor];
    
    footerView.height = label1.y + label1.height + DYMargin;
    self.tableView.tableFooterView = footerView;
}

//  http://api.m.mtime.cn/PageSubArea/MarketFirstPageNew.api
// http://api.m.mtime.cn/ECommerce/RecommendProducts.api?goodsIds=102116,101517,102479&pageIndex=1
#pragma mark - 加载数据
- (void)loadData {
    NSMutableSet *mutSet = [NSMutableSet setWithSet:self.manager.responseSerializer.acceptableContentTypes];
    [mutSet addObject:@"application/x-javascript"];
    [mutSet addObject:@"text/html"];
    self.manager.responseSerializer.acceptableContentTypes = mutSet;
    
    [self.manager GET:@"http://api.m.mtime.cn/PageSubArea/MarketFirstPageNew.api" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // 设置headerView
        NSArray *scrollImg = [DYScrollViewImage mj_objectArrayWithKeyValuesArray:responseObject[@"scrollImg"]];
        for (DYScrollViewImage *tmp in scrollImg) {
            [self.images addObject:tmp.image];
        }
        self.midItems = [DYGoodItem mj_objectArrayWithKeyValuesArray:responseObject[@"navigatorIcon"]];
        [self setupTableViewHeader];
        // 设置cellArray的数据
        self.cellArray = [DYGoodsModel mj_objectArrayWithKeyValuesArray:responseObject[@"category"]];
        
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    [self.manager GET:@"http://api.m.mtime.cn/ECommerce/RecommendProducts.api?goodsIds=102116,101517,102479&pageIndex=1" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.goodsArray = [DYMeHotGoods mj_objectArrayWithKeyValuesArray:responseObject[@"goodsList"]];
        [self setupTableViewFootr];
        [self.tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.cellArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DYMallTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    DYGoodsModel *goodsModel = self.cellArray[indexPath.row];
    cell.goodsModel = goodsModel;
    return cell;
}

// 这是为了保证，模态的控制器退出后，本控制器顶部保持原样
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self scrollViewDidScroll:self.tableView];
}

#pragma mark - <UITableViewDelegate>控制颜色渐变
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    CGFloat alphaScale = offset.y / 80.0;
    
    DYNavigationController *nav = (DYNavigationController *)self.navigationController;
    nav.navBarBgView.alpha = alphaScale;
    
    // 让下边有弹簧效果，上边没有。这里注意值传递的问题。scrollView.contentOffset不能换成上边的offset
    if (scrollView.contentOffset.y <= 0) {
        CGPoint TmpOffset = scrollView.contentOffset;
        TmpOffset.y = 0;
        scrollView.contentOffset = TmpOffset;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 420;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    DYGoodsModel *goodsModel = self.cellArray[indexPath.row];
    DYMeWebViewController *vc = [[DYMeWebViewController alloc] init];
    vc.url = goodsModel.moreUrl;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
