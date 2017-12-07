//
//  UIView+Frame.m
//  07-彩票-基本框架
//
//  Created by Romeo on 15/12/16.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setX:(CGFloat)x
{
    // 获取 label 的 frame
    CGRect rect = self.frame;
    // 修改结构体
    rect.origin.x = x;
    // 赋值
    self.frame = rect;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    // 获取 label 的 frame
    CGRect rect = self.frame;
    // 修改结构体
    rect.origin.y = y;
    // 赋值
    self.frame = rect;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setW:(CGFloat)w
{
    // 获取 label 的 frame
    CGRect rect = self.frame;
    // 修改结构体
    rect.size.width = w;
    // 赋值
    self.frame = rect;
}

- (CGFloat)w
{
    return self.frame.size.width;
}

- (void)setH:(CGFloat)h
{
    // 获取 label 的 frame
    CGRect rect = self.frame;
    // 修改结构体
    rect.size.height = h;
    // 赋值
    self.frame = rect;
}

- (CGFloat)h
{
    return self.frame.size.height;
}

@end
