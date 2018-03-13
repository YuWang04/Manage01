//
//  HMTabBar.m
//  KVO
//
//  Created by xtjsb on 2018/3/13.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import "HMTabBar.h"
#import "tabBarController.h"
#define kScreenWidth kScreenSize.size.width
#define kScreenSize [UIScreen mainScreen].bounds
@interface HMTabBarButton : UIButton

@end

@implementation HMTabBarButton

- (void)setHighlighted:(BOOL)highlighted
{
    //    [super setHighlighted:highlighted];
}

@end

@interface HMTabBar ()

@property (nonatomic, weak) UIButton* currentButton;

@end
@implementation HMTabBar
- (void)addButtonWithImage:(UIImage*)image andImageSel:(UIImage*)imageSel
{
    // 创建 btn
    HMTabBarButton* tabbarButton = [[HMTabBarButton alloc] init];
    
    // 设置 btn 的图片
    [tabbarButton setBackgroundImage:image forState:UIControlStateNormal];
    [tabbarButton setBackgroundImage:imageSel forState:UIControlStateSelected];
    
    // 监听 btn
    [tabbarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchDown];
    
    // 添加到自己上
    [self addSubview:tabbarButton];
}

// 点击 tabbar 上按钮的时候调用
- (void)tabBarButtonClick:(UIButton*)sender
{
    
    // 取消记录的按钮的选中状态
    self.currentButton.selected = NO;
    // 设置点击的按钮为选中状态
    sender.selected = YES;
    // 记录选中的按钮
    self.currentButton = sender;
    
    // 切换控制器
    //    self.selectedIndex = sender.tag;
    // 判断 block 是否有值(代理方法 是不是能够响应)
    if (self.tabbarButtonBlock) {
        // 2.执行 block(执行代理方法)
        self.tabbarButtonBlock(sender.tag);
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    for (int i = 0; i < self.subviews.count; ++i) {
        
        // 获取 button
        UIButton* tabbarButton = self.subviews[i];
        
        // 设置 tag 切换控制器
        tabbarButton.tag = i;
        
        // 计算按钮的 frame
        CGFloat w = kScreenWidth / self.subviews.count;
        CGFloat h = 49;
        CGFloat x = i * w;
        CGFloat y = 0;
        
        tabbarButton.frame = CGRectMake(x, y, w, h);
        
        // 点一下第一个按钮
        if (i == 0) {
            [self tabBarButtonClick:tabbarButton];
        }
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
