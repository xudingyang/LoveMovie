//
//  DYSettingTableVController.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/12.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "DYSettingTableVController.h"
#import "DYNavigationController.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface DYSettingTableVController ()

@property (weak, nonatomic) IBOutlet UILabel *currentViesionLabel;

@property (weak, nonatomic) IBOutlet UILabel *cacheLabel;

@end

@implementation DYSettingTableVController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (CGFloat)getCacheSize{
    // 图片缓存(他这里是字节为单位，到时候要换成兆)
    CGFloat imageCacheSize = [[SDImageCache sharedImageCache] getSize];
    return imageCacheSize / 1000 / 1000;
}

- (NSString *)getVersion{
    // 获取当前版本号
    NSString *key = @"CFBundleShortVersionString";
    NSString *currentVesion = [NSBundle mainBundle].infoDictionary[key];
    return currentVesion;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.cacheLabel.text = [NSString stringWithFormat:@"%0.3fMB", [self getCacheSize]];
    self.currentViesionLabel.text = [NSString stringWithFormat:@"(当前版本%@)", [self getVersion]];
}

// 要是没有这一句，界面出来后果一会儿，导航栏颜色会变浅一些。
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    DYNavigationController *nav = (DYNavigationController *)self.navigationController;
    nav.navBarBgView.alpha = 1;
}

#pragma mark - 监听事件
// 检查版本
- (IBAction)checkVersion:(UITapGestureRecognizer *)sender {
    // 这里不能获得版本信息，模拟是最新版的
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"版本检测" message:@"您安装的是最新版本" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *other = [UIAlertAction actionWithTitle:@"闲得慌，就是要点" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"好吧，哥们怕你了"];
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    }];
    
    [alert addAction:ok];
    [alert addAction:cancel];
    [alert addAction:other];
    
    [self.tabBarController presentViewController:alert animated:YES completion:nil];
}

// 清除缓存
- (IBAction)clearCache:(UITapGestureRecognizer *)sender {
    [[SDImageCache sharedImageCache] clearDisk];
    self.cacheLabel.text = [NSString stringWithFormat:@"%0.3fMB", [self getCacheSize]];
}

@end
