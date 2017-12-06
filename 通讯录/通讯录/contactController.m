//
//  contactController.m
//  通讯录
//
//  Created by xtjsb on 17/12/1.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "contactController.h"
#import "AddController.h"
#import "JKConModel.h"
#import "EditController.h"
#define ContactFilePath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"contacts.data"]
@interface contactController ()<AddControllerDelegate>
- (IBAction)addAction:(UIBarButtonItem *)sender;
- (IBAction)backClick:(id)sender;
@property(nonatomic,strong)NSMutableArray *array;
@end

@implementation contactController

-(NSMutableArray *)array{
    if(!_array){
        _array = [NSKeyedUnarchiver unarchiveObjectWithFile:ContactFilePath];
        if(_array == nil){
        _array = [[NSMutableArray alloc]init];
        }
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  //去除tableView多余的线
    [self clearExtraLine:self.tableView];
    self.view.backgroundColor = [UIColor whiteColor];
    }

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    JKConModel *contactModel = self.array[indexPath.row];//[[JKConModel alloc]init];
    cell.textLabel.text = contactModel.name;
    cell.detailTextLabel.text = contactModel.phone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    
    return cell;
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    AddController *addVc = segue.destinationViewController;
//    addVc.delegate = self;
    id vc = segue.destinationViewController;
    if([vc isKindOfClass:[AddController class]]){
        AddController *addVC = vc;
        addVC.delegate = self;
    }else if([vc isKindOfClass:[EditController class]]){
        EditController *editVC = vc;
        //取得选中那一行
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        editVC.model = self.array[path.row];
        editVC.delegate =  self;
    }
    
}

#pragma mark - tableView delegate
//滑动删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(editingStyle == UITableViewCellEditingStyleDelete){
        //删除数据model
        [self.array removeObjectAtIndex:indexPath.row];
        //刷新视图
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        //归档
        [NSKeyedArchiver archiveRootObject:self.array toFile:ContactFilePath];
        
        
    }
}
#pragma EditVc deleagate
//实现编辑页面代理方法
-(void)editViewController:(EditController*)editVc didSaveContact:(JKConModel*)model{
    [self.tableView reloadData];
    //归档
    [NSKeyedArchiver archiveRootObject:self.array toFile:ContactFilePath];
}
//实现添加页面代理方法
-(void)addContact:(AddController *)addVc didAddContact:(JKConModel *)contact{
    //添加数据模型
    [self.array addObject:contact];
    //刷新视图列表
    [self.tableView reloadData];
    //归档
    [NSKeyedArchiver archiveRootObject:self.array toFile:ContactFilePath];
    
}

- (IBAction)addAction:(UIBarButtonItem *)sender {
}

- (IBAction)backClick:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否注销" message:@"确定注销" preferredStyle:UIAlertControllerStyleActionSheet];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }]];
    //弹出alert控制器
    [self presentViewController:alert animated:YES completion:NULL];
}
//去除多余的线
-(void)clearExtraLine:(UITableView*)tableView{
    UITableView *view = [[UITableView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
}
@end
