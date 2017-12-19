//
//  TestSelectViewController.m
//  驾照助手
//
//  Created by xtjsb on 17/12/19.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "TestSelectViewController.h"
#import "TestSelectTableViewCell.h"
#import "TestSelectMode.h"
#import "AnswerViewController.h"
@interface TestSelectViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,copy)UITableView *tableView;
@end

@implementation TestSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.title = _myTitle;
    [self createTableView];
}

-(void)createTableView{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
//    return 7;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellId = @"TestSelectTableViewCell";
    TestSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(!cell){
        cell = [[[NSBundle mainBundle]loadNibNamed:cellId owner:self options:nil]lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius = 8;
    }
    TestSelectMode *model = _dataArray[indexPath.row];
    cell.numberLabel.text = model.pid;
    cell.titleLabel.text = model.pname;
    return  cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AnswerViewController *avc = [[AnswerViewController alloc]init];
    avc.number = indexPath.row;
    if(indexPath.row == 0){
    AnswerViewController *vc = [[AnswerViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
