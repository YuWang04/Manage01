//
//  HMGroupBuyButton.m
//  07-彩票-基本框架
//
//  Created by Romeo on 15/12/16.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMGroupBuyButton.h"
#import "UIView+Frame.h"

@implementation HMGroupBuyButton

- (void)layoutSubviews
{
    [super layoutSubviews];

    // 交换 btn 内部控件的位置

    // label x = 0  ------
    self.titleLabel.x = 0;
    // imageView x = label.width   -------
    self.imageView.x = self.titleLabel.w;

    //  ------ ------ ------ ------ ------ ------ ------

    // label x = 0  ------

    //    // 获取 label 的 frame
    //    CGRect labelRect = self.titleLabel.frame;
    //    // 修改结构体
    //    labelRect.origin.x = 0;
    //    // 赋值
    //    self.titleLabel.frame = labelRect;

    // imageView x = label.width   -------

    //    // 获取 imageView 的 frame
    //    CGRect imageViewRect = self.imageView.frame;
    //    // 修改结构体
    //    imageViewRect.origin.x = labelRect.size.width;
    //    // 赋值
    //    self.imageView.frame = imageViewRect;
}

@end
