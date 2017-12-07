//
//  HMTabBar.h
//  07-彩票-基本框架
//
//  Created by Romeo on 15/12/15.
//  Copyright © 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMTabBar : UIView

// 1.写 block 属性 (相当于 代理的  协议,协议方法, id 属性)
@property (nonatomic, copy) void (^tabbarButtonBlock)(NSInteger);

- (void)addButtonWithImage:(UIImage*)image andImageSel:(UIImage*)imageSel;
@end
