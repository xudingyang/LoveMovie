//
//  AppDelegate.m
//  LoveMovie
//
//  Created by xudingyang on 16/5/10.
//  Copyright © 2016年 许定阳. All rights reserved.
//

#import "AppDelegate.h"
#import "DYTabBarController.h"
#import "DYGuideNewView.h"
#import "DYLocationTool.h"
#import "DYTopWindowViewController.h"

@interface AppDelegate ()

/**  获取定位 */
@property (strong, nonatomic) DYLocationTool *locationTool;

/** topWindow */
@property (strong, nonatomic) UIWindow *topWindow;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.window makeKeyAndVisible];
    
    DYTabBarController *tabBarVc = [[DYTabBarController alloc] init];
    self.window.rootViewController = tabBarVc;
    
    NSLog(@"哈哈哈");
    // 新特性引导界面
    [DYGuideNewView showGuideView];
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // 获取定位
    self.locationTool = [DYLocationTool sharedLoactionTool];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CGFloat distance = [self.locationTool distanceFromLatitude:34.27 andLongitude:108.93];
        NSLog(@"distance: %f",distance / 1000);
    });
    
    UIWindow *topWindow = [[UIWindow alloc] initWithFrame:application.statusBarFrame];
    self.topWindow = topWindow;
    DYTopWindowViewController *rootVc = [[DYTopWindowViewController alloc] init];
    topWindow.rootViewController = rootVc;
    topWindow.windowLevel = UIWindowLevelAlert;
    topWindow.hidden = NO;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
