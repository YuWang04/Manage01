//
//  HMGroupBuyController.m
//  07-彩票-基本框架
//
//  Created by Romeo on 15/12/16.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMGroupBuyController.h"
#import "UIView+Frame.h"

@interface HMGroupBuyController ()

@property (nonatomic, weak) UIView* blueView;

@end

@implementation HMGroupBuyController

- (UIView*)blueView
{
    if (!_blueView) {
        UIView* blueView = [[UIView alloc] init];
        blueView.backgroundColor = [UIColor blueColor];
        blueView.frame = CGRectMake(0, 64, kScreenWidth, 0);
        [self.view addSubview:blueView];

        _blueView = blueView;
    }
    return _blueView;
}

// 全部彩种的点击事件
- (IBAction)groupBuyClick:(UIButton*)sender
{

    [UIView animateWithDuration:0.25
                     animations:^{
                         // 如果高度有值 那么设置为0 如果没有值(值为0) 那么设置150
                         self.blueView.h = self.blueView.h ? 0 : 150;

                         // 旋转 只要一点 就在自身的基础上 加半圈儿
                         sender.imageView.transform = CGAffineTransformRotate(sender.imageView.transform, M_PI);

                     }];
    
    
    
   
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self blueView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
