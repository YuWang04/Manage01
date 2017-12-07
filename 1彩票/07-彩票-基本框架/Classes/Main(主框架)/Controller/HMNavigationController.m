//
//  HMNavigationController.m
//  07-彩票-基本框架
//
//  Created by Romeo on 15/12/15.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMNavigationController.h"

@interface HMNavigationController ()

@end

@implementation HMNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 设置导航栏图片
    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"NavBar64"] forBarMetrics:UIBarMetricsDefault];

    // 设置文字为白色
    [self.navigationBar setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] }];

    // 设置渲染的颜色
    [self.navigationBar setTintColor:[UIColor whiteColor]];
}

// 状态栏颜色
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

// 以后只要使用这个 nav 去push 那么都隐藏tabbar
- (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    viewController.hidesBottomBarWhenPushed = YES;

    [super pushViewController:viewController animated:animated];
}

@end
