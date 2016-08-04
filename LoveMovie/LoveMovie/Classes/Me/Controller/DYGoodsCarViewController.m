//
//  DYGoodsCarViewController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/13.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYGoodsCarViewController.h"
#import "DYNavigationController.h"
#import "DYMeHotGoodsVCell.h"
#import "DYMeHotGoods.h"
#import "DYNoHighlitedButton.h"
#import <AFNetworking.h>
#import <MJExtension.h>
#import <SVProgressHUD.h>

@interface DYGoodsCarViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *contentScrollView;

/** 上边的view */
@property (weak, nonatomic) UIView *topView;
/** 下边的view */
@property (weak, nonatomic) UIView *bottomView;

/** 辅助属性，存储服务器发过来的商品数组 */
@property (strong, nonatomic) NSArray *goodsArray;
/** 辅助属性，scrollView的contentSize */
@property (assign, nonatomic) CGSize contentSize;

@end

@implementation DYGoodsCarViewController

- (NSArray *)goodsArray{
    if (_goodsArray == nil) {
        _goodsArray = [NSArray array];
    }
    return _goodsArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"购物车";
    self.view.frame = [UIScreen mainScreen].bounds;
    
    [self loadGoodsInfo];
}

// 设置scrollView的内容
- (void)setupContentScrollView{
    self.contentScrollView.frame = self.view.bounds;
    [self setupTopView];
    [self setupBottomView];
    self.contentScrollView.contentSize = self.contentSize;
    
//    这里只有一个scrollview，不必手动设置
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.contentScrollView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
}

// 网络请求
- (void)loadGoodsInfo{
    
    [SVProgressHUD showWithStatus:@"臣妾正在玩命加载..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [[AFHTTPSessionManager manager] POST:@"http://api.m.mtime.cn/ECommerce/HotBuyProducts.api" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.goodsArray = [DYMeHotGoods mj_objectArrayWithKeyValuesArray:responseObject[@"goodsList"]];
        
        // 有时候返回的是空数组，混蛋！
        if (self.goodsArray.count == 0) {
            [SVProgressHUD dismiss];
        } else {
            [SVProgressHUD setMinimumDismissTimeInterval:0.5];
            [SVProgressHUD showSuccessWithStatus:@"加载成功"];
        }
        
        [self setupContentScrollView];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [SVProgressHUD showErrorWithStatus:@"网络太差，臣妾做不到!"];
    }];
}

// 设置上边view的内容
- (void)setupTopView{
    // 创建topView容器
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.contentScrollView.width, 240)];
    [self.contentScrollView addSubview:topView];
    self.topView = topView;
    // 背景图片
    UIImageView *topViewBg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mainCellBackground"]];
    topViewBg.frame = topView.bounds;
    [topView insertSubview:topViewBg atIndex:0];
    
    // 添加购物车图片
    UIImageView *goodsCarImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_shoppingcart_nogood"]];
    [goodsCarImage sizeToFit];
    goodsCarImage.centerX = self.contentScrollView.width * 0.5;
    goodsCarImage.y = DYMargin * 2;
    [topView addSubview:goodsCarImage];
    
    // 添加“购物车还是空的”标语
    UILabel *label = [[UILabel alloc] init];
    label.text = @"购物车还是空的，快去挑几件中意的商品吧";
    [label setTextColor:DYRGBColor(134, 134, 134)];
    [label setFont:[UIFont systemFontOfSize:13]];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.x = 0;
    label.y = goodsCarImage.y + goodsCarImage.height + DYMargin;
    label.width = topView.width;
    label.height = 20;
    [topView addSubview:label];
    
    // 添加“去购物"按钮
    DYNoHighlitedButton *goBuyBtn = [[DYNoHighlitedButton alloc] init];
    goBuyBtn.y = label.y + label.height + DYMargin;
//    要设置宽度高度之后，再设置center。因为宽高未设置，这时候的中心就是左上角的点，那么肯定会显示错误
//    goBuyBtn.centerX = topView.width * 0.5;
    goBuyBtn.width = 80;
    goBuyBtn.height = 29;
    goBuyBtn.centerX = topView.width * 0.5;
    [goBuyBtn setBackgroundImage:[UIImage imageNamed:@"bt_line_gray_58"] forState:UIControlStateNormal];
    [goBuyBtn setTitle:@"去购物" forState:UIControlStateNormal];
    [goBuyBtn setTitleColor:DYRGBColor(134, 134, 134) forState:UIControlStateNormal];
    goBuyBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [topView addSubview:goBuyBtn];
}

// 设置底部view的内容
- (void)setupBottomView{
    // 添加中间分割线
    UIImageView *midImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"HotBuyProductsPrompt"]];
    midImage.width = self.contentScrollView.width;
    midImage.centerX = midImage.width * 0.5;
    midImage.y = self.topView.y + self.topView.height + DYMargin;
    midImage.height = 19;
    [self.contentScrollView addSubview:midImage];
    
    // 格子的父view
    UIView *collectView = [[UIView alloc] init];
    [self.contentScrollView addSubview:collectView];
    collectView.width = self.contentScrollView.width;
    collectView.x = 0;
    collectView.y = midImage.y + midImage.height + DYMargin;
    CGFloat collectViewH = 100;  // 赋初值，等格子加进来后再更正
    // 添加底部的格子（由于数据只展示有限几个，所以用直接用for循环）
    NSInteger totalColums = 2;
    NSInteger goodsCount = self.goodsArray.count;
    CGFloat cellW = (self.contentScrollView.width - DYMargin * 3) * 0.5;
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
    self.contentSize = CGSizeMake(self.view.width, collectView.y + collectViewH);
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItems = nil;
}

// 要是没有这一句，界面出来后果一会儿，导航栏颜色会变浅一些。
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    DYNavigationController *nav = (DYNavigationController *)self.navigationController;
    nav.navBarBgView.alpha = 1;
}


@end
