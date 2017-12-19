//
//  FirstViewController.m
//  驾照助手
//
//  Created by xtjsb on 17/12/19.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "FirstViewController.h"
#import "FierstTableViewCell.h"
#import "TestSelectViewController.h"
#import "myDataManager.h"
@interface FirstViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,copy)UITableView *tableView;
@property(nonatomic,assign)NSArray *dataArray;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    //给array赋值就用这个
    _dataArray = [NSArray arrayWithObjects:@"章节练习",@"顺序练习",@"随机练习",@"专项练习",@"仿真考试", nil];
    [self createTableView];
    [self createView];
    
}
//-(NSArray*)dataArray{
//    if(!_dataArray){
//        _dataArray = @[@"章节练习",@"顺序练习",@"随机练习",@"专项练习",@"仿真考试"];
//    }
//    return _dataArray;
//}
-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 250) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
}

-(void)createView{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2-150, self.view.frame.size.height-64-140, 300, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"...............我的考试分析...............";
    [self.view addSubview:label];
    for(int i = 0; i < 4; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(self.view.frame.size.width/4*i + self.view.frame.size.width/4/2-30, self.view.frame.size.height-64-100, 60, 60);
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",12+i]] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        NSArray *arr = @[@"我的错题",@"我的收藏",@"我的成绩",@"联系统计"];
        UILabel *lb = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/4*i+self.view.frame.size.width/4/2-30, self.view.frame.size.height-64-25, 60, 20)];
        lb.textAlignment = NSTextAlignmentCenter;
        lb.text = arr[i];
        lb.font = [UIFont boldSystemFontOfSize:13];
        [self.view addSubview:lb];
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"FierstTableViewCell";
    FierstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
    }
    cell.myImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.png",indexPath.row+7]];
    cell.myLabel.text = _dataArray[indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}


//代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0://章节练习
        {
            TestSelectViewController *con = [[TestSelectViewController alloc]init];
            con.dataArray = [myDataManager getData:chapter];
            con.myTitle = @"章节练习";
            UIBarButtonItem *item = [[UIBarButtonItem alloc]init];
            item.title = @"";
            self.navigationItem.backBarButtonItem = item;
            [self.navigationController pushViewController:con animated:YES];
        }
            break;
            
        default:
            break;
    }
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
