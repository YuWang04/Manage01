//
//  HMTabBarController.m
//  07-彩票-基本框架
//
//  Created by Romeo on 15/12/15.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMTabBarController.h"
#import "HMTabBar.h"

@interface HMTabBarController ()

@end

@implementation HMTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 获取五个子控制器
    UIViewController* v1 = [self loadSubViewContollerWithSBName:@"Hall"];
    UIViewController* v2 = [self loadSubViewContollerWithSBName:@"Arena"];
    UIViewController* v3 = [self loadSubViewContollerWithSBName:@"Discovery"];
    UIViewController* v4 = [self loadSubViewContollerWithSBName:@"History"];
    UIViewController* v5 = [self loadSubViewContollerWithSBName:@"MyLottery"];

    // 设置 tabbarController子控制器
    self.viewControllers = @[ v1, v2, v3, v4, v5 ];

    // 创建一个自定义的 tabbar
    HMTabBar* tabbar = [[HMTabBar alloc] init];

    // 3.使用 block(遵守协议,使用代理方法)
    __weak HMTabBarController* weakSelf = self;
    tabbar.tabbarButtonBlock = ^(NSInteger index) {
        weakSelf.selectedIndex = index;
    };

    // 设置 tabbar 的 frame 为系统的 frame
    tabbar.frame = self.tabBar.bounds;

    for (int i = 0; i < self.viewControllers.count; ++i) {

        // 获取图片
        UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar%d", i + 1]];
        UIImage* imagePress = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar%dSel", i + 1]];

        [tabbar addButtonWithImage:image andImageSel:imagePress];

        // 取消高亮的效果
        //        tabbarButton.adjustsImageWhenHighlighted = NO;
    }

    // 添加到 tabbarController 中
    //    [self.view addSubview:tabbar];
    [self.tabBar addSubview:tabbar];
}

// 根据sb 名字返回 这个 sb 箭头所指向的控制器
- (UIViewController*)loadSubViewContollerWithSBName:(NSString*)name
{
    // 获取 sb对象
    UIStoryboard* sb = [UIStoryboard storyboardWithName:name bundle:nil];
    return [sb instantiateInitialViewController];
}
@end
