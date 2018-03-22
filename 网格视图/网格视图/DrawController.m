//
//  DrawController.m
//  网格视图
//
//  Created by xtjsb on 2018/3/22.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import "DrawController.h"
#import "DrawView.h"
@interface DrawController ()

@end

@implementation DrawController
- (IBAction)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    DrawView *view = [[DrawView alloc]initWithFrame:CGRectMake(10, 100, 350, 300)];
    [self.view addSubview:view];
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
