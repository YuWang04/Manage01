//
//  HMArenaController.m
//  07-彩票-基本框架
//
//  Created by Romeo on 15/12/15.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMArenaController.h"

@interface HMArenaController ()

@end

@implementation HMArenaController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 设置控制器的背景图片(拉伸)
    self.view.layer.contents = (__bridge id)[UIImage imageNamed:@"NLArenaBackground"].CGImage;

    //    UIBarMetricsDefault, // 横屏显示 竖屏显示
    //    UIBarMetricsCompact, // 横屏显示 竖屏不显示
    //    UIBarMetricsDefaultPrompt = 101, // 竖屏有副标题显示 横屏有副标题不显示
    //    UIBarMetricsCompactPrompt, // 竖屏有副标题不显示 横屏有副标题显示

    // 设置 navbar 的图片
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"NLArenaNavBar64"] forBarMetrics:UIBarMetricsDefault];

    // 获取 titleView
    UISegmentedControl* seg = (UISegmentedControl*)self.navigationItem.titleView;
    // 设置默认的背景图片
    [seg setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentBG"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    // 设置选中的背景图片
    [seg setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];

    // 设置文字的颜色
    [seg setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] } forState:UIControlStateNormal];
    [seg setTitleTextAttributes:@{ NSForegroundColorAttributeName : [UIColor whiteColor] } forState:UIControlStateSelected];


    // 取消蓝色的线
    [seg setTintColor:[UIColor clearColor]];
}

@end
