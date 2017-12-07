//
//  HMLuckyController.m
//  07-彩票-基本框架
//
//  Created by Romeo on 15/12/16.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMLuckyController.h"

@interface HMLuckyController ()
@property (weak, nonatomic) IBOutlet UIImageView* imageView;

@end

@implementation HMLuckyController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    // 设置要做动画的图片
    self.imageView.animationImages = @[ [UIImage imageNamed:@"lucky_entry_light0"], [UIImage imageNamed:@"lucky_entry_light1"] ];

    // 时间
    self.imageView.animationDuration = 1;

    // 次数
    self.imageView.animationRepeatCount = 0;

    // 开始
    [self.imageView startAnimating];
}

@end
