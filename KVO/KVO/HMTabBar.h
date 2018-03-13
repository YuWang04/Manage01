//
//  HMTabBar.h
//  KVO
//
//  Created by xtjsb on 2018/3/13.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMTabBar : UIView
// 1.写 block 属性 (相当于 代理的  协议,协议方法, id 属性)
@property (nonatomic, copy) void (^tabbarButtonBlock)(NSInteger);

- (void)addButtonWithImage:(UIImage*)image andImageSel:(UIImage*)imageSel;
@end
