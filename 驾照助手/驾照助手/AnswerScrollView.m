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
    NSMutableArray *_hadAnswerArray;//记录答过的题
}
-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array{
    self = [super initWithFrame:frame];
    if(self){
        _currentPage = 0;
        _dataArray = [[NSArray alloc]initWithArray:array];
        _hadAnswerArray = [[NSMutableArray alloc]init];
        for (int i = 0; i<array.count; i++) {
            [_hadAnswerArray addObject:@"0"];
        }
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
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    AnswerModel *model = [self getThefitmodel:tableView];
    NSString *str = [NSString stringWithFormat:@"答案解析:%@",model.mdesc];
    UIFont *font = [UIFont systemFontOfSize:16];
    return  [Tool getSizeWithString:str With:font WithSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat hight;
    AnswerModel *model = [self getThefitmodel:tableView];
    if([model.mtype intValue]==1){
        NSString *str = [[Tool getAnswerWithString:model.mquestion]objectAtIndex:0];
        UIFont *font = [UIFont systemFontOfSize:16];
        hight = [Tool getSizeWithString:str With:font WithSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }else{
        NSString *str = model.mquestion;
        UIFont *font = [UIFont systemFontOfSize:16];
        hight = [Tool getSizeWithString:str With:font WithSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }
    if(hight<=80){
        return 80;
    }else{
        return hight;
    }
}
//设置tableView上的问题
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    CGFloat hight;
    NSString *str;
    AnswerModel *model = [self getThefitmodel:tableView];
    str = [NSString stringWithFormat:@"答案解析：%@",model.mdesc];
    UIFont *font = [UIFont systemFontOfSize:16];
    hight = [Tool getSizeWithString:str With:font WithSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;

    
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, hight)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, hight-20)];
    label.text = str;
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    label.textColor = [UIColor greenColor];
    [view addSubview:label];
    
    int page = [self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if([_hadAnswerArray[page-1] intValue]!=0){
        return view;
    }
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    CGFloat hight;
    NSString *str;
    AnswerModel *model = [self getThefitmodel:tableView];
    if([model.mtype intValue]==1){
        str = [[Tool getAnswerWithString:model.mquestion]objectAtIndex:0];
        UIFont *font = [UIFont systemFontOfSize:16];
        hight = [Tool getSizeWithString:str With:font WithSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }else{
        NSString *str = model.mquestion;
        UIFont *font = [UIFont systemFontOfSize:16];
        hight = [Tool getSizeWithString:str With:font WithSize:CGSizeMake(tableView.frame.size.width-20, 400)].height+20;
    }

    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SIZE.width, hight)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, tableView.frame.size.width-20, hight-20)];
    label.text = [NSString stringWithFormat:@"%d.%@",[self getQuestionNumber:tableView andCurrentPage:_currentPage],str];
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    [view addSubview:label];
//    view.backgroundColor = [UIColor redColor];
    return view;
}
-(int)getQuestionNumber:(UITableView *)tableView andCurrentPage:(int)page{
    if(tableView==_leftTabVeiw&&page==0){
        return 1;
    }else if (tableView==_leftTabVeiw&&page>0){
        return page;
    }else if (tableView==_mainTabView&&page>0&&page<_dataArray.count-1){
        return page+1;
    }else if (tableView==_mainTabView&&page==0){
        return 2;
    }else if (tableView==_mainTabView&&page==_dataArray.count-1){
        return page;
    }else if (tableView==_rightTabView&&page<_dataArray.count-1){
        return page+2;
    }else if (tableView==_rightTabView&&page==_dataArray.count-1){
        return page+1;
    }
    return 0;
}
//选中选项（题目）方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    int page = [self getQuestionNumber:tableView andCurrentPage:_currentPage];
    //判断选的题是否做过
    if([_hadAnswerArray[page-1] intValue]!=0){
        return;
    }else{
        [_hadAnswerArray replaceObjectAtIndex:page-1 withObject:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
         }
    [self reloadData];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"AnswerTableViewCell";
    AnswerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(!cell){
        //返回的是一个数组，取一个值（只有一个元素firstObject也可以）
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil]lastObject];
        cell.numberLabel.layer.masksToBounds = YES;
        cell.numberLabel.layer.cornerRadius  = 10;
        //选中风格
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.numberLabel.text = [NSString stringWithFormat:@"%c",(char)('A'+indexPath.row)];
    AnswerModel *model = [self getThefitmodel:tableView];
    
    if([model.mtype intValue] == 1){
        cell.answerLabel.text = [[Tool getAnswerWithString:model.mquestion]objectAtIndex:indexPath.row+1];
        
    }
    int page = [self getQuestionNumber:tableView andCurrentPage:_currentPage];
    if([_hadAnswerArray[page-1]intValue]!=0){
        if([model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+(int)indexPath.row]]){
            cell.numberImage.hidden = NO;
            cell.numberImage.image = [UIImage imageNamed:@"19.png"];
        }
        if(![model.manswer isEqualToString:[NSString stringWithFormat:@"%c",'A'+[_hadAnswerArray[page-1]intValue]-1]]&&indexPath.row==[_hadAnswerArray[page-1]intValue]-1){
            cell.numberImage.hidden = NO;
            cell.numberImage.image = [UIImage imageNamed:@"20.png"];
        }else{
            cell.numberImage.hidden = YES;
        }
        
    }
    return cell;
}
-(AnswerModel *)getThefitmodel:(UITableView *)tableView{
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
    return  model;
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
