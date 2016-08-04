//
//  DYMovieVController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/13.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYMovieVController.h"
#import "DYShowingMovieTableVC.h"
#import "DYComingMovieVC.h"
#import "DYNoHighlitedButton.h"

@interface DYMovieVController () <UIScrollViewDelegate>
/** buttons 用来保存指示器按钮数组 */
@property (strong, nonatomic) NSMutableArray *buttons;
/** currentBtn 记录当前选中的按钮 */
@property (weak, nonatomic) DYNoHighlitedButton *currentBtn;
/** UIView *bottomLine */
@property (weak, nonatomic) UIView *bottomLine;
/** UIScrollView *contentScrollView */
@property (weak, nonatomic) UIScrollView *contentScrollView;

///** bottomLine上一次的frame */
//@property (assign, nonatomic) CGRect previousFrame;
///** 上一次的contentOffset */
//@property (assign, nonatomic) CGPoint previousOffset;
@end

@implementation DYMovieVController

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
    [self setupChildenControllers];
    [self setupIdicatorView];
    [self setupContentScrollView];
    
}

#pragma mark - 添加子控制器
- (void)setupChildenControllers{
    DYShowingMovieTableVC *showingVc = [[DYShowingMovieTableVC alloc] initWithStyle:UITableViewStylePlain];
    showingVc.title = @"正在热映";
    [self addChildViewController:showingVc];
    
    DYComingMovieVC *comingVc = [[DYComingMovieVC alloc] init];
    comingVc.title = @"即将上映";
    [self addChildViewController:comingVc];
}

#pragma mark - 设置指示器
- (void)setupIdicatorView{
    // 创建容器view
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = DYRGBColor(246, 246, 246);
    indicatorView.width = DYScreenWidth;
    indicatorView.height = DYIndicatorHeight;
    indicatorView.x = 0;
    indicatorView.y = 64;
    [self.view addSubview:indicatorView];
    
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
        [button setTitleColor:DYRGBColor(4, 117, 196) forState:UIControlStateSelected];
        [button setTitleColor:DYRGBColor(50, 50, 50) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(indicatorBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    // 添加按钮底下的线条
    UIView *bottomLine = [[UIView alloc] init];
    bottomLine.height = 2;
    bottomLine.width = indicatorView.width / self.childViewControllers.count;
    bottomLine.x = 0;
    bottomLine.y = indicatorView.height - bottomLine.height;
    [indicatorView addSubview:bottomLine];
    bottomLine.backgroundColor = DYRGBColor(4, 117, 196);
    self.bottomLine = bottomLine;
    // 默认选中第一个按钮
    [self didSelectedButton:self.buttons[0]];
}

#pragma mark - 设置下方的scrollView
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
}

#pragma mark - 按钮事件监听
- (void)indicatorBtnClick:(DYNoHighlitedButton *)button{
    [self didSelectedButton:button];
}

- (void)didSelectedButton:(DYNoHighlitedButton *)button{
    NSInteger index = [self.buttons indexOfObject:button];
    if (self.currentBtn == button) {
        return;
    }
    self.currentBtn.selected = NO;
    button.selected = YES;
    self.currentBtn = button;
    [UIView animateWithDuration:0.2 animations:^{
        self.bottomLine.centerX = self.currentBtn.centerX;
    }];
    CGPoint offset = self.contentScrollView.contentOffset;
    offset.x = self.contentScrollView.width * index;
    // 用代码让它滚，最好调用scrollViewDidEndScrollingAnimation方法
    [self.contentScrollView setContentOffset:offset animated:YES];
}


#pragma mark - <UIScrollViewDelegate>
// 这个加的动画有闪烁bug，待解决
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
//    self.previousFrame = self.bottomLine.frame;
//    self.previousOffset = scrollView.contentOffset;
//}
//
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    CGFloat deltaX = scrollView.contentOffset.x - self.previousOffset.x;
//    CGFloat scale = deltaX / scrollView.width;
//    CGFloat bottomDeltaX = self.bottomLine.width * scale;
//    self.bottomLine.x = self.previousFrame.origin.x + bottomDeltaX;
//}

// 滚动动画结束时候调用。用setContentOffset方法主动更改offset时候，就应该用这方法。用手滑动的时候，不会调用这方法，需要在相关地方显示调用该方法。
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
