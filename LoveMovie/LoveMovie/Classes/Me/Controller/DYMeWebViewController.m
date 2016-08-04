//
//  DYMeWebViewController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/13.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYMeWebViewController.h"
#import "DYMeHotGoods.h"
#import "DYNoHighlitedButton.h"

@interface DYMeWebViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

/** nextBtn */
@property (weak, nonatomic) DYNoHighlitedButton *refreshBtn;

/** previousBtn */
@property (weak, nonatomic) DYNoHighlitedButton *previousBtn;

@end

@implementation DYMeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(-50, 0, 0, 0);
    self.webView.scrollView.bounces = NO;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItems = nil;
    
    // 导航栏右边的“前一页”按钮
    DYNoHighlitedButton *previousBtn = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
    self.previousBtn = previousBtn;
    [previousBtn setTitle:@"<前一页" forState:UIControlStateNormal];
    [previousBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [previousBtn setTitleColor:[UIColor blackColor] forState:UIControlStateDisabled];
    previousBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    previousBtn.width = 60;
    previousBtn.height = 30;
    [previousBtn addTarget:self action:@selector(previousClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 导航栏右边“刷新”按钮
    DYNoHighlitedButton *refreshBtn = [DYNoHighlitedButton buttonWithType:UIButtonTypeCustom];
    self.refreshBtn = refreshBtn;
    [refreshBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [refreshBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    refreshBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    refreshBtn.width = 40;
    refreshBtn.height = 30;
    [refreshBtn addTarget:self action:@selector(refreshBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *previous = [[UIBarButtonItem alloc] initWithCustomView:previousBtn];
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
    
    self.navigationItem.rightBarButtonItems = @[refresh, previous];
    
}

#pragma mark - 按钮监听
- (void)previousClick{
    [self.webView goBack];
}
- (void)refreshBtnClick{
    [self.webView reload];
}
@end
