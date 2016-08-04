//
//  DYRegistViewController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/12.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYRegistViewController.h"
#import "DYNavigationController.h"
#import "DYLoginViewController.h"
#import <SVProgressHUD.h>

@interface DYRegistViewController ()

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;

@property (weak, nonatomic) IBOutlet UITextField *pwdField;

@property (weak, nonatomic) IBOutlet UITextField *yanZhengMaField;

@property (weak, nonatomic) IBOutlet UIButton *maleBtn;

@property (weak, nonatomic) IBOutlet UIButton *femaleBtn;

@property (weak, nonatomic) IBOutlet UIButton *agreeContractBtn;


@property (weak, nonatomic) IBOutlet UISwitch *isShowPwdSwitch;



@end

@implementation DYRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"欢迎注册";

    // 默认不显示密码
    self.isShowPwdSwitch.on = YES;
    self.pwdField.secureTextEntry = YES;
    // 默认没勾选条款
//    self.agreeContractBtn.selected = NO;
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

#pragma mark - 监听事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

// 是否显示密码
- (IBAction)isShowPwd {
    self.pwdField.secureTextEntry = self.isShowPwdSwitch.isOn;
}

// 获取验证码
- (IBAction)gotYanZhengMa {
}

// 同意条款
- (IBAction)agreeContract {
    
    self.agreeContractBtn.selected = !self.agreeContractBtn.selected;
}

// 选择性别男
- (IBAction)maleClick {
    if (!self.maleBtn.selected) {
        self.maleBtn.selected = YES;
        self.femaleBtn.selected = NO;
    }
}

// 选择性别女
- (IBAction)femaleClick {
    if (!self.femaleBtn.selected) {
        self.femaleBtn.selected = YES;
        self.maleBtn.selected = NO;
    }
}

// 注册按钮
- (IBAction)regisetClick {

    if (self.phoneNumberField.text.length == 0 || self.pwdField.text.length == 0 || self.yanZhengMaField.text.length == 0 || (self.femaleBtn.selected == NO && self.maleBtn.selected == NO)) {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"信息不完整，注册失败!"];
        return;
    }
    if (self.agreeContractBtn.selected == NO) {
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"请勾选同意条款!"];
        return;
    }
    [SVProgressHUD setMinimumDismissTimeInterval:2];
    [SVProgressHUD showSuccessWithStatus:@"注册成功"];
}

// 已有账号，转到登录界面
- (IBAction)hadAccountClick {
    DYLoginViewController *vc = [[DYLoginViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
