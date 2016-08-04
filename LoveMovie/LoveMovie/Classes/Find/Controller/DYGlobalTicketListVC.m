//
//  DYGlobalTicketListVC.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/20.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYGlobalTicketListVC.h"
#import "DYTicketListTableVC.h"
#import "DYNoHighlitedButton.h"

@interface DYGlobalTicketListVC () <UIScrollViewDelegate>

/** UIView *indicatorView */
@property (weak, nonatomic) UIView *indicatorView;
/** UIView *bottomLine */
@property (weak, nonatomic) UIView *bottomLine;
/** UIScrollView *contentScrollView */
@property (weak, nonatomic) UIScrollView *contentScrollView;
/** currentBtn */
@property (weak, nonatomic) DYNoHighlitedButton *currentBtn;
/** buttons */
@property (strong, nonatomic) NSMutableArray *buttons;

@end

@implementation DYGlobalTicketListVC

#pragma mark - 懒加载buttons
- (NSMutableArray *)buttons{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (void)setChooseAreaNumber:(DYAreaNumber)chooseAreaNumber{
    for (DYTicketListTableVC *vc in self.childViewControllers) {
        if (chooseAreaNumber == vc.areaNumber) {
            NSInteger index = [self.childViewControllers indexOfObject:vc];
            [self didSelectedButton:self.buttons[index]];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupChildViewControllers];
    [self setupIndicatorView];
    [self setupContentScrollView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupNav];
}

#pragma mark - 设置Nav
- (void)setupNav{
    // 右边item
    self.navigationItem.rightBarButtonItems = nil;
    DYNoHighlitedButton *shareBtn = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setImage:[UIImage imageNamed:@"icon_sharing"] forState:UIControlStateNormal];
    [shareBtn sizeToFit];
    [shareBtn addTarget:self action:@selector(shareClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:shareBtn];
    self.navigationItem.rightBarButtonItem = shareItem;

}

#pragma mark - 分享按钮事件监听
- (void)shareClick{
    DYLog(@"shareClick");
}

#pragma mark - 设置指示器
- (void)setupIndicatorView{
    // 创建容器view
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = DYRGBColor(246, 246, 246);
    indicatorView.width = DYScreenWidth;
    indicatorView.height = DYIndicatorHeight;
    indicatorView.x = 0;
    indicatorView.y = 64;
    [self.view addSubview:indicatorView];
    
    // 添加指示器。只是添加，还没有设置
    UIView *bottomLine = [[UIView alloc] init];
    self.bottomLine = bottomLine;
    bottomLine.height = 2;
    bottomLine.y = indicatorView.height - bottomLine.height;
    bottomLine.backgroundColor = [UIColor whiteColor];
    [indicatorView addSubview:bottomLine];
    bottomLine.backgroundColor = DYRGBColor(4, 117, 196);
    
    // 创建并添加按钮
    for (NSInteger index = 0; index < self.childViewControllers.count; index++) {
        DYNoHighlitedButton *button = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
        button.y = 0;
        button.width = indicatorView.width / self.childViewControllers.count;
        button.height = indicatorView.height;
        button.x = button.width * index;
        [indicatorView addSubview:button];
        [self.buttons addObject:button];
        UIViewController *vc = self.childViewControllers[index];
        [button setTitle:vc.title forState:UIControlStateNormal];
        [button setTitleColor:DYRGBColor(4, 117, 196) forState:UIControlStateDisabled];
        [button setTitleColor:DYRGBColor(50, 50, 50) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(indicatorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (index == 0) {
            [button.titleLabel sizeToFit];
            self.bottomLine.width = button.titleLabel.width;
            self.bottomLine.centerX = button.centerX;
            [self didSelectedButton:button];
        }
    }
}

#pragma mark - 设置下边的scrollView
- (void)setupContentScrollView{
    UIScrollView *contentScrollView = [[UIScrollView alloc] init];
    self.contentScrollView = contentScrollView;
    contentScrollView.delegate = self;
    contentScrollView.frame = self.view.bounds;
    [self.view insertSubview:contentScrollView atIndex:0];
    contentScrollView.contentSize = CGSizeMake(self.childViewControllers.count * contentScrollView.width, 0);
    contentScrollView.pagingEnabled = YES;
    contentScrollView.bounces = NO;
    
    // 默认添加第一个子控制器（在滚动方法里实现添加）
    [self scrollViewDidEndScrollingAnimation:contentScrollView];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.contentScrollView.showsHorizontalScrollIndicator = NO;
}

#pragma mark - 添加childVcs
- (void)setupChildViewControllers{
    DYTicketListTableVC *mainLand = [[DYTicketListTableVC alloc] init];
    mainLand.title = @"内地";
    mainLand.areaNumber = DYMainLand;
    [self addChildViewController:mainLand];
    
    DYTicketListTableVC *america = [[DYTicketListTableVC alloc] init];
    america.title = @"北美";
    america.areaNumber = DYAmerica;
    [self addChildViewController:america];
    
    DYTicketListTableVC *hongKong = [[DYTicketListTableVC alloc] init];
    hongKong.title = @"香港";
    hongKong.areaNumber = DYHongKong;
    [self addChildViewController:hongKong];
    
    DYTicketListTableVC *taiWan = [[DYTicketListTableVC alloc] init];
    taiWan.title = @"台湾";
    taiWan.areaNumber = DYTaiWan;
    [self addChildViewController:taiWan];
    
    DYTicketListTableVC *jaPan = [[DYTicketListTableVC alloc] init];
    jaPan.title = @"日本";
    jaPan.areaNumber = DYJapan;
    [self addChildViewController:jaPan];
    
    DYTicketListTableVC *korea = [[DYTicketListTableVC alloc] init];
    korea.title = @"韩国";
    korea.areaNumber = DYKorea;
    [self addChildViewController:korea];
}

#pragma mark - 按钮事件监听
- (void)indicatorBtnClick:(DYNoHighlitedButton *)button{
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
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@票房榜",self.childViewControllers[index].title];
}


#pragma mark - <UIScrollViewDelegate>
// 由于本方法是在动画结束的时候调用，所以其他地方要主动调用，才能执行本方法。
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    CGFloat viewX = index * scrollView.width;
    CGFloat viewY = 0;
    CGFloat viewW = scrollView.width;
    CGFloat viewH = scrollView.height;
    UIViewController *vc = self.childViewControllers[index];
    vc.view.frame = CGRectMake(viewX, viewY, viewW, viewH);
    [scrollView addSubview:vc.view];
}
// 减速完成，scrollView停下来之后
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 这里要主动调用该方法，不然不会加载控制器。（因为加载控制器的操作在该方法里面）
    [self scrollViewDidEndScrollingAnimation:scrollView];
    //    [self scrollViewDidEndDragging:scrollView willDecelerate:YES];
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self didSelectedButton:self.buttons[index]];
}

@end
