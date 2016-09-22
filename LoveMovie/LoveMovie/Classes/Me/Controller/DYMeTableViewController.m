//
//  DYMeTableViewController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/10.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYMeTableViewController.h"
#import "DYMeHeaderView.h"
#import "DYNavigationController.h"
#import "DYNoHighlitedButton.h"
#import "DYLoginViewController.h"

@interface DYMeTableViewController ()

@property (strong, nonatomic) DYNavigationController *nav;
@property (strong, nonnull) UIViewController *hehe;
@end

@implementation DYMeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = DYGlobalBackgroundColor;
    
    self.tableView.tableHeaderView = [DYMeHeaderView meHeaderView];
    
    [self setupNav];
}

- (void)setupNav{
    // 导航栏右边有个“信封”
    DYNoHighlitedButton *button = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"icon_my_message"] forState:UIControlStateNormal];
    [button sizeToFit];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    // 刚开始的时候，导航栏隐藏，信封不隐藏，外间距为0
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
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

#pragma mark - <UITableViewDelegate>点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - 事件监听
// 点按我的优惠券cell
- (IBAction)mySaleTicket:(UITapGestureRecognizer *)sender {
    DYLoginViewController *loginVc = [[DYLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVc animated:YES];
}

- (IBAction)myMovie:(UITapGestureRecognizer *)sender {
    DYLoginViewController *loginVc = [[DYLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVc animated:YES];
}

- (IBAction)myCollect:(UITapGestureRecognizer *)sender {
    DYLoginViewController *loginVc = [[DYLoginViewController alloc] init];
    [self.navigationController pushViewController:loginVc animated:YES];
}

@end
