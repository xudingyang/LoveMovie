//
//  DYLoginViewController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/12.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYLoginViewController.h"
#import "DYNavigationController.h"
#import "DYRegistViewController.h"
#import <SVProgressHUD.h>

@interface DYLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *accountLabel;

@property (weak, nonatomic) IBOutlet UITextField *pwdLabel;



@end

@implementation DYLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"正在登录";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItems = nil;
}

// 要是没有这一句，界面出来后，过一会儿，导航栏颜色会变浅一些。
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    DYNavigationController *nav = (DYNavigationController *)self.navigationController;
    nav.navBarBgView.alpha = 1;
}


#pragma mark - 监听事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

// 点击登录
- (IBAction)loginClick {
    if (self.accountLabel.text.length == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"账号不能为空"];
        return;
    }
    if (self.pwdLabel.text.length == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
        return;
    }
    // 因为没有服务器的登录接口，这里就模拟登录失败情形
    if (1) {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"账号或密码错误!"];
    }
}

// 点击免费注册
- (IBAction)registFree {
    DYRegistViewController *registVc = [[DYRegistViewController alloc] init];
    [self.navigationController pushViewController:registVc animated:YES];
}

@end
