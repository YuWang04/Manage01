//
//  tabBarController.m
//  KVO
//
//  Created by xtjsb on 2018/3/12.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import "tabBarController.h"
#import "OneController.h"
#import "TwoController.h"
#import "HMTabBar.h"
@interface tabBarController ()

@end

@implementation tabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
    // 创建一个自定义的 tabbar
    HMTabBar* tabbar = [[HMTabBar alloc] init];
    
    // 3.使用 block(遵守协议,使用代理方法)
    __weak tabBarController* weakSelf = self;
    tabbar.tabbarButtonBlock = ^(NSInteger index) {
        weakSelf.selectedIndex = index;
    };
    
    // 设置 tabbar 的 frame 为系统的 frame
    tabbar.frame = self.tabBar.bounds;
    NSMutableArray *viewControllerArray = [NSMutableArray array];
    
    OneController *vc1 = [[OneController alloc]init];
    vc1.view.backgroundColor = [UIColor redColor];
//    vc1.tabBarItem.title=@"联系人";
    UIImage* image = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar1"]];
    UIImage* imagePress = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar1Sel"]];
    [tabbar addButtonWithImage:image andImageSel:imagePress];
    [viewControllerArray addObject:vc1];
    
    TwoController *vc2 = [[TwoController alloc]init];
    vc2.view.backgroundColor = [UIColor yellowColor];
    UIImage* image2 = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar2"]];
    UIImage* imagePress2 = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar2Sel"]];
    [tabbar addButtonWithImage:image2 andImageSel:imagePress2];
    [viewControllerArray addObject:vc2];
    
    OneController *vc3 = [[OneController alloc]init];
    vc3.view.backgroundColor = [UIColor redColor];
    //    vc2.tabBarItem.title=@"联系人";
    UIImage* image3 = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar3"]];
    UIImage* imagePress3 = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar3Sel"]];
    [tabbar addButtonWithImage:image3 andImageSel:imagePress3];
    [viewControllerArray addObject:vc3];
    
    TwoController *vc4 = [[TwoController alloc]init];
    vc4.view.backgroundColor = [UIColor yellowColor];
    UIImage* image4 = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar2"]];
    UIImage* imagePress4 = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar2Sel"]];
    [tabbar addButtonWithImage:image4 andImageSel:imagePress4];
    [viewControllerArray addObject:vc4];
    
    OneController *vc5 = [[OneController alloc]init];
    vc5.view.backgroundColor = [UIColor redColor];
    //    vc2.tabBarItem.title=@"联系人";
    UIImage* image5 = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar3"]];
    UIImage* imagePress5 = [UIImage imageNamed:[NSString stringWithFormat:@"TabBar3Sel"]];
    [tabbar addButtonWithImage:image5 andImageSel:imagePress5];
    [viewControllerArray addObject:vc5];
    
    self.viewControllers = viewControllerArray;
    [self.tabBar addSubview:tabbar];
}

- (void)didReceiveMemoryWarning {
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
