//
//  AnswerViewController.m
//  驾照助手
//
//  Created by xtjsb on 17/12/19.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "AnswerViewController.h"
#import "AnswerScrollView.h"
#import "myDataManager.h"
#import "AnswerModel.h"
@interface AnswerViewController ()

@end

@implementation AnswerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    NSMutableArray *arr = [[NSMutableArray alloc]init];
//    NSArray *arr = @[@"5",@"4",@"3",@"2",@"1"];
    NSArray *array = [myDataManager getData:answer];
    //取需要的题目
    for(int i = 0;i < array.count-1; i++){
        AnswerModel *model = array[i];
        if([model.pid intValue]==_number+1){
            [arr addObject:model];
        }
    }
    AnswerScrollView *view = [[AnswerScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) withDataArray:array];
    [self.view addSubview:view];
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
