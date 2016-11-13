//
//  AppDelegate.m
//  网易新闻
//
//  Created by mac on 16/11/4.
//  Copyright © 2016年 macd. All rights reserved.
//

#import "AppDelegate.h"
#import <AFNetworkActivityIndicatorManager.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    // 设置网络指示器 - 非常重要的一个用户体验！
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;

    sleep(3);
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    
    Class cls = NSClassFromString(@"WYMainController");
    UIViewController * vc = [cls new];
    
    _window.rootViewController = vc;
    [_window makeKeyAndVisible];
    
    return YES;
}



@end
