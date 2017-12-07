//
//  ViewController.m
//  弹幕
//
//  Created by xtjsb on 17/12/7.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "ViewController.h"
#import "bulletView.h"
#import "bulletManager.h"
@interface ViewController ()
@property(nonatomic,strong)bulletManager *manager;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [[bulletManager alloc]init];
    __weak typeof (self)myself = self;
    self.manager.generteViewBlock = ^(bulletView *view){
        [myself addBulletView:view];
    };
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [btn setTitle:@"start" forState:UIControlStateNormal];
    btn.frame = CGRectMake(100, 100, 60, 40);
    [btn addTarget:self action:@selector(ClickStart) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [btn2 setTitle:@"stop" forState:UIControlStateNormal];
    btn2.frame = CGRectMake(100, 150, 60, 40);
    [btn2 addTarget:self action:@selector(ClickStop) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
}


-(void)ClickStop{
    [self.manager stop];
}
-(void)ClickStart{
    [self.manager start];
    NSLog(@"qqwq");
}
-(void)addBulletView:(bulletView *)view{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    view.frame = CGRectMake(width, 300+view.tarjectroy*40, CGRectGetWidth(view.bounds), CGRectGetHeight(view.bounds));
    [self.view addSubview:view];
    [view startAnimation];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
