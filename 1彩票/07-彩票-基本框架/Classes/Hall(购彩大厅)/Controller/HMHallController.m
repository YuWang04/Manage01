//
//  HMHallController.m
//  07-彩票-基本框架
//
//  Created by Romeo on 15/12/15.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMHallController.h"

@interface HMHallController ()

@property (nonatomic, weak) UIView* coverView;
@property (nonatomic, weak) UIImageView* imageView;

@end

@implementation HMHallController

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage* image = [UIImage imageNamed:@"CS50_activity_image"];

    // 告诉系统 使用这个图片的时候 不进行渲染
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    // 创建item
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(activityClick)];

    self.navigationItem.leftBarButtonItem = item;
}

// 活动的点击事件
- (void)activityClick
{

    // 遮罩
    UIView* coverView = [[UIView alloc] initWithFrame:kScreenSize];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0.5;
    // 添加到最外层的控制器
    [self.tabBarController.view addSubview:coverView];
    self.coverView = coverView;

    // imageView
    UIImageView* imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"showActivity"]];
    // 开启用户交互
    imageView.userInteractionEnabled = YES;
    imageView.center = self.view.center;

    //    [coverView addSubview:imageView];
    // 注意: 不添加到 cover 上的原因 是因为 父控件如果透明 那么子控件也会透明
    [self.tabBarController.view addSubview:imageView];
    self.imageView = imageView;

    // 关闭按钮
    UIButton* closeButton = [[UIButton alloc] init];
    // 获取图片
    UIImage* closeButtonImage = [UIImage imageNamed:@"alphaClose"];
    closeButton.frame = CGRectMake(imageView.bounds.size.width - closeButtonImage.size.width, 0, 0, 0);
    [closeButton setBackgroundImage:closeButtonImage forState:UIControlStateNormal];
    [closeButton sizeToFit];
    [imageView addSubview:closeButton];
    // 监听关闭按钮的点击
    [closeButton addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
}

// 关闭按钮
- (void)closeClick
{
    [UIView animateWithDuration:0.25
                     animations:^{
                         [self.coverView removeFromSuperview];
                         [self.imageView removeFromSuperview];
                     }];
}

@end