//
//  DYTicketVController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/13.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYTicketVController.h"
#import "DYMovieVController.h"
#import "DYCinemaVController.h"
#import "DYNoHighlitedButton.h"
#import "DYIndicatorView.h"

@interface DYTicketVController () <DyIndicatorViewDelegate>

/** 城市btn */
@property (weak, nonatomic) DYNoHighlitedButton *cityBtn;



@end

@implementation DYTicketVController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 因为在setupnav里面，指示器默认选中第一个，我们就需要加载子控制器了，所以这句放前边
    [self addChildViewControllers];
    [self setupNav];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - 设置导航条
- (void)setupNav{
    // 设置左边的“城市按钮”
    DYNoHighlitedButton *cityBtn = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
    self.cityBtn = cityBtn;
    [cityBtn setTitle:@"武汉" forState:UIControlStateNormal];
    [cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cityBtn setImage:[UIImage imageNamed:@"icon_index_selectcity"] forState:UIControlStateNormal];
    cityBtn.size = CGSizeMake(70, 29);
    [cityBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 40, 0, -40)];
    [cityBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [cityBtn addTarget:self action:@selector(citySelect) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:cityBtn];
    self.navigationItem.leftBarButtonItem = left;
    
    // 设置右边的搜索按钮
    DYNoHighlitedButton *searchBtn = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[UIImage imageNamed:@"v10_search_icon"] forState:UIControlStateNormal];
    searchBtn.size = CGSizeMake(50, 29);
    [searchBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
    [searchBtn addTarget:self action:@selector(searchClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithCustomView:searchBtn];
    self.navigationItem.rightBarButtonItem = right;
    
    // 设置中间的选项按钮
    DYIndicatorView *midView = [[DYIndicatorView alloc] init];
    midView.delegate = self;
    midView.frame = CGRectMake(0, 0, 160, 29);
    midView.layer.cornerRadius = 14.5;
    midView.layer.masksToBounds = YES;
    NSArray *titles = @[@"电影", @"影院"];
    midView.titles = titles;
    self.navigationItem.titleView = midView;
    
}

#pragma mark -添加子控制器
- (void)addChildViewControllers{
    DYMovieVController *movieVc = [[DYMovieVController alloc] init];
    DYCinemaVController *cinameVc = [[DYCinemaVController alloc] init];
    [self addChildViewController:movieVc];
    [self addChildViewController:cinameVc];
}

#pragma mark - 事件监听
#pragma mark - 城市选择按钮
- (void)citySelect{
    
}

#pragma mark - 点击搜索按钮
- (void)searchClick{
    
}

#pragma mark - <DyIndicatorViewDelegate>点击导航条上的指示器，切换子控制器
- (void)indicatorViewDidSelectedButtonTitle:(NSString *)title{
    if ([title isEqualToString:@"电影"]) {
        self.childViewControllers[0].view.frame = self.view.bounds;
        [self.view addSubview:self.childViewControllers[0].view];
        [self.view bringSubviewToFront:self.childViewControllers[0].view];
    } else if ([title isEqualToString:@"影院"]) {
        DYCinemaVController *vc = self.childViewControllers[1];
        vc.cityID = 561;  // 武汉
        self.childViewControllers[1].view.frame = self.view.bounds;
        
        [self.view addSubview:self.childViewControllers[1].view];
        [self.view bringSubviewToFront:self.childViewControllers[1].view];
    }
}
@end
