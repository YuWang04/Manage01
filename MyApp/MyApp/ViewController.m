//
//  ViewController.m
//  MyApp
//
//  Created by xtjsb on 2018/4/2.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "ViewController.h"
#import "SXTCategate.h"
#import "GameVc.h"
#import "CalendarVC.h"
static NSString *identifier = @"cellID";
static NSString *cellID = @"identifier";
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *subCatorgateView;
@property(nonatomic,strong) UITableView *catogateView;
@property(nonatomic,strong)NSArray *categorList;

@end

@implementation ViewController
-(NSArray *)categorList{
    if(!_categorList){
        _categorList = [SXTCategate loadData];
    }
    return _categorList;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.catogateView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width/3, self.view.frame.size.height) style:UITableViewStylePlain];
    _catogateView.delegate = self;
    _catogateView.dataSource = self;
//    _catogateView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:_catogateView];
    
    self.subCatorgateView = [[UITableView alloc]initWithFrame:CGRectMake(self.view.frame.size.width/3, 0, self.view.frame.size.width/3*2, self.view.frame.size.height) style:UITableViewStylePlain];
    _subCatorgateView.delegate = self;
    _subCatorgateView.dataSource = self;
//    _catogateView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_subCatorgateView];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.catogateView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.catogateView) {
        return self.categorList.count;
    }
    NSIndexPath *selectIdx = [self.catogateView indexPathForSelectedRow];
    SXTCategate *cate = self.categorList[selectIdx.row];
    return cate.subcategories.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.catogateView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        SXTCategate *cate = self.categorList[indexPath.row];
        cell.textLabel.text = cate.name;
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        NSIndexPath *idx = [self.catogateView indexPathForSelectedRow];
        SXTCategate *cate = self.categorList[idx.row];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.text = cate.subcategories[indexPath.row];
        return cell;
    }
    return nil;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == self.catogateView){
        [self.subCatorgateView reloadData];
    }else{
        if (indexPath.row == 0) {
            GameVc *gamevc = [[GameVc alloc]init];
            [self.navigationController pushViewController:gamevc animated:YES];
        }
        if (indexPath.row == 1) {
            CalendarVC *gamevc = [[CalendarVC alloc]init];
            [self.navigationController pushViewController:gamevc animated:YES];
        }
    }

}


@end
