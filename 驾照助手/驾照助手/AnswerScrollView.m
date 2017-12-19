//
//  AnswerScrollView.m
//  驾照助手
//
//  Created by xtjsb on 17/12/19.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "AnswerScrollView.h"
#import "AnswerTableViewCell.h"
#import "AnswerModel.h"
#import "Tool.h"
#define SIZE self.frame.size
@interface AnswerScrollView()<UITableViewDelegate,UITableViewDataSource>

@end
@implementation AnswerScrollView
{
    UIScrollView *_scrollView;
    UITableView *_leftTabVeiw;
    UITableView *_mainTabView;
    UITableView *_rightTabView;
    NSArray *_dataArray;
}
-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array{
    self = [super initWithFrame:frame];
    if(self){
        _currentPage = 0;
        _dataArray = [[NSArray alloc]initWithArray:array];
        _scrollView = [[UIScrollView alloc]initWithFrame:frame];
        _scrollView.delegate = self;
        _leftTabVeiw = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _mainTabView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _rightTabView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
        _leftTabVeiw.delegate = self;
        _leftTabVeiw.dataSource = self;
        _mainTabView.delegate = self;
        _mainTabView.dataSource = self;
        _rightTabView.delegate = self;
        _rightTabView.dataSource = self;
        //设置翻页效果
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.showsVerticalScrollIndicator  =NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        if(_dataArray.count>1){
            _scrollView.contentSize = CGSizeMake(SIZE.width*2, 0);
            
        }
        [self createView];
    }
    return self;
}
-(void)createView{
    _leftTabVeiw.frame = CGRectMake(0, 0, SIZE.width, SIZE.height);
    _mainTabView.frame = CGRectMake(SIZE.width, 0, SIZE.width, SIZE.height);
    _rightTabView.frame = CGRectMake(SIZE.width*2, 0, SIZE.width, SIZE.height);
    [_scrollView addSubview:_leftTabVeiw];
    [_scrollView addSubview:_mainTabView];
    [_scrollView addSubview:_mainTabView];
    [self addSubview:_scrollView];
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, 100)];
    view.backgroundColor = [UIColor redColor];
    return view;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"AnswerTableViewCell";
    AnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        //返回的是一个数组，取一个值（只有一个元素firstObject也可以）
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius  = 10;
        
    }
    cell.numberLabel.text = [NSString stringWithFormat:@"%c",(char)('A'+indexPath.row)];
    AnswerModel *model;
    if(tableView==_leftTabVeiw&&_currentPage==0){
        model = _dataArray[_currentPage];
    }else if(tableView==_leftTabVeiw&&_currentPage>0){
        model = _dataArray[_currentPage-1];
    }else if(tableView==_mainTabView&&_currentPage==0){
        model = _dataArray[_currentPage+1];
    }else if (tableView==_mainTabView&&_currentPage>0&&_currentPage<_dataArray.count-1){
        model = _dataArray[_currentPage];
    }else if (tableView==_mainTabView&&_currentPage==_dataArray.count-1){
        model = _dataArray[_currentPage-1];
    }else if(tableView==_rightTabView&&_currentPage==_dataArray.count-1){
        model = _dataArray[_currentPage];
    }else if (tableView==_rightTabView&&_dataArray.count<_dataArray.count-1){
        model = _dataArray[_currentPage+1];
    }
    if([model.mtype intValue] == 1){
        cell.answerLabel.text = [[Tool getAnswerWithString:model.mquestion]objectAtIndex:indexPath.row+1];
        
    }
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint currentOffset = scrollView.contentOffset;
    int page = currentOffset.x/SIZE.width;
    if(page<_dataArray.count-1&&page>0){
        _scrollView.contentSize = CGSizeMake(currentOffset.x + SIZE.width*2, 0);
        _mainTabView.frame = CGRectMake(currentOffset.x, 0, SIZE.width, SIZE.height);
        _leftTabVeiw.frame = CGRectMake(currentOffset.x-SIZE.width, 0, SIZE.width, SIZE.height);
        _rightTabView.frame = CGRectMake(currentOffset.x+SIZE.width, 0, SIZE.width, SIZE.height);
    }
    _currentPage = page;
    [self reloadData];
}
-(void)reloadData{
    [_leftTabVeiw reloadData];
    [_mainTabView reloadData];
    [_rightTabView reloadData];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
