//
//  DYFindViewController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/19.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYFindViewController.h"
#import "DYNewsTableVController.h"
#import "DYTrailerTableVController.h"
#import "DYTopListTableVController.h"
#import "DYReviewTableVController.h"
#import "DYNoHighlitedButton.h"

@interface DYFindViewController () <UIScrollViewDelegate>
/** currentBtn 当前选中的btn */
@property (weak, nonatomic) DYNoHighlitedButton *currentBtn;
/** buttons 保存按钮数组 */
@property (strong, nonatomic) NSMutableArray *buttons;
/** UIView *bottomLine */
@property (weak, nonatomic) UIView *bottomLine;
/** UIScrollView *contentScrollView */
@property (weak, nonatomic) UIScrollView *contentScrollView;
/** UIView *titles */
@property (weak, nonatomic) UIView *titles;
@end

@implementation DYFindViewController

#pragma mark - 懒加载buttons
- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = DYGlobalBackgroundColor;
    [self setupChildViewControllers];
    [self setupNav];
    [self setupContentScrollView];
}

- (void)setVcIndex:(NSInteger)vcIndex {
    _vcIndex = vcIndex;
    [self didSelectedButton:self.buttons[vcIndex]];
}

#pragma mark - 添加子控制器
- (void)setupChildViewControllers{

    DYNewsTableVController *news = [[DYNewsTableVController alloc] init];
    news.title = @"新闻";
    [self addChildViewController:news];
    
    DYTrailerTableVController *trailer = [[DYTrailerTableVController alloc] init];
    trailer.title = @"预告片";
    [self addChildViewController:trailer];
    
    DYTopListTableVController *topList = [[DYTopListTableVController alloc] init];
    topList.title = @"排行榜";
    [self addChildViewController:topList];
    
    DYReviewTableVController *review = [[DYReviewTableVController alloc] init];
    review.title = @"影评";
    [self addChildViewController:review];
}

// 因为titles是直接加在tabBar上的，所以需要这么操作
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.titles.hidden = YES;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.titles.hidden = NO;
}

#pragma mark - 设置导航条
- (void)setupNav{
    // 添加盛放按钮的容器view
    UIView *titles = [[UIView alloc] init];
    titles.frame = self.navigationController.navigationBar.bounds;
    [self.navigationController.navigationBar addSubview:titles];
    self.titles = titles;
    // 添加按钮下的指示器。这里只添加，但是不设置宽度，因为宽度要根据选中的按钮而变化
    UIView *bottomLine = [[UIView alloc] init];
    self.bottomLine = bottomLine;
    bottomLine.height = 2;
    bottomLine.y = titles.height - bottomLine.height;
    bottomLine.backgroundColor = [UIColor whiteColor];
    [titles addSubview:bottomLine];
    
    // 添加按钮
    CGFloat btnW = titles.width / 4;
    CGFloat btnH = titles.height;
    for (int i = 0; i < self.childViewControllers.count; i++) {
        UIViewController *vc = self.childViewControllers[i];
        DYNoHighlitedButton *btn = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
        [self.buttons addObject:btn];
        [btn setTitle:vc.title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = 0;
        btn.x = btnW * i;
        [titles addSubview:btn];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i == 0) {
            [btn.titleLabel sizeToFit];
            self.bottomLine.width = btn.titleLabel.width;
            self.bottomLine.centerX = btn.centerX;
            [self didSelectedButton:btn];
        }
    }
    // 默认选中第一个。不要在这里设置。因为这时候按钮只是设置了，还没有布局，拿不到label的尺寸，所以bottomLine无法设置
    // 在for循环了直接设置。
//    [self didSelectedButton:self.buttons[0]];
}
#pragma mark - 设置contentScrollView
- (void)setupContentScrollView{
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView = contentScrollView;
    contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * self.view.width, 0);
    contentScrollView.frame = self.view.bounds;
    contentScrollView.pagingEnabled = YES;
    contentScrollView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view insertSubview:contentScrollView atIndex:0];
    [self scrollViewDidEndScrollingAnimation:contentScrollView];
}

#pragma mark - 监听按钮点击事件
- (void)btnClick:(DYNoHighlitedButton *)button{
    [self didSelectedButton:button];
}
- (void)didSelectedButton:(DYNoHighlitedButton *)button{
    self.currentBtn.enabled = YES;
    button.enabled = NO;
    self.currentBtn = button;
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomLine.width = button.titleLabel.width;
        self.bottomLine.centerX = button.centerX;
    }];
    
    NSInteger index = [self.buttons indexOfObject:button];
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = index * self.contentScrollView.width;
    [self.contentScrollView setContentOffset:offset animated:YES];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    CGFloat viewY = 0;
    CGFloat viewW = scrollView.width;
    CGFloat viewH = scrollView.height;
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    CGFloat viewX = index * scrollView.width;
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(viewX, viewY, viewW, viewH);
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 这里要主动调用该方法，不然不会加载控制器。（因为加载控制器的操作在该方法里面）
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //    [self scrollViewDidEndDragging:scrollView willDecelerate:YES];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self didSelectedButton:self.buttons[index]];
}
@end
