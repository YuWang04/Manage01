//
//  GameVc.m
//  MyApp
//
//  Created by xtjsb on 2018/4/3.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "GameVc.h"

@interface GameVc ()
@property(nonatomic,strong)UIButton *firstBtn;
@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)UIButton *btn;
@end

@implementation GameVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消消乐";
    self.view.backgroundColor = [UIColor whiteColor];
    [self layoutView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)layoutView{
    if(_btn){
        [_btn removeFromSuperview];
    }
    _backView = [[UIView alloc]initWithFrame:CGRectMake(20, 150, 500, 500)];
    //    _backView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_backView];
    NSMutableArray * nmArray = [NSMutableArray array];
    
    for (int i = 0; i < 8; i ++) {
        int random = arc4random()%7 + 1;
        NSString * randomStr = [NSString stringWithFormat:@"%zd",random];
        [nmArray addObject:randomStr];
        [nmArray addObject:randomStr];
        
    }
    for (int i = 0; i < 4; i ++) {
        for(int j = 0;j < 4;j ++){
            int arrStr = arc4random()%nmArray.count;
            NSString *str = [nmArray objectAtIndex:arrStr];
            UIImage *image = [UIImage imageNamed:str];
            UIButton *btn = [UIButton new];
            btn.frame = CGRectMake(50*i+20, 50*j+50, 50, 50);
            [btn setImage:image forState:UIControlStateNormal];
            [nmArray removeObjectAtIndex:arrStr];
            [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = [str integerValue];
            [_backView addSubview:btn];
        }
    }
}
-(void)layoutView1{
    if(_btn){
    [_btn removeFromSuperview];
    }
    _backView = [[UIView alloc]initWithFrame:CGRectMake(20, 150, 500, 500)];
//    _backView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_backView];
    NSMutableArray * nmArray = [NSMutableArray array];
    
    for (int i = 0; i < 18; i ++) {
        int random = arc4random()%7 + 1;
        NSString * randomStr = [NSString stringWithFormat:@"%zd",random];
        [nmArray addObject:randomStr];
        [nmArray addObject:randomStr];
        
    }
    for (int i = 0; i < 6; i ++) {
        for(int j = 0;j < 6;j ++){
            int arrStr = arc4random()%nmArray.count;
            NSString *str = [nmArray objectAtIndex:arrStr];
            UIImage *image = [UIImage imageNamed:str];
        UIButton *btn = [UIButton new];
            btn.frame = CGRectMake(50*i+20, 50*j+50, 50, 50);
            [btn setImage:image forState:UIControlStateNormal];
            [nmArray removeObjectAtIndex:arrStr];
            [btn addTarget:self action:@selector(startGame:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = [str integerValue];
            [_backView addSubview:btn];
      }
  }
    
}
-(void)layoutView2{
    if(_btn){
        [_btn removeFromSuperview];
    }
    _backView = [[UIView alloc]initWithFrame:CGRectMake(20, 150, 500, 500)];
    //    _backView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_backView];
    NSMutableArray * nmArray = [NSMutableArray array];
    
    for (int i = 0; i < 32; i ++) {
        int random = arc4random()%7 + 1;
        NSString * randomStr = [NSString stringWithFormat:@"%zd",random];
        [nmArray addObject:randomStr];
        [nmArray addObject:randomStr];
        
    }
    for (int i = 0; i < 8; i ++) {
        for(int j = 0;j < 8;j ++){
            int arrStr = arc4random()%nmArray.count;
            NSString *str = [nmArray objectAtIndex:arrStr];
            UIImage *image = [UIImage imageNamed:str];
            UIButton *btn = [UIButton new];
            btn.frame = CGRectMake(40*i+20, 40*j+50, 40, 40);
            [btn setImage:image forState:UIControlStateNormal];
            [nmArray removeObjectAtIndex:arrStr];
            [btn addTarget:self action:@selector(cliickBtn:) forControlEvents:UIControlEventTouchUpInside];
            btn.tag = [str integerValue];
            [_backView addSubview:btn];
        }
    }
}
-(void)clickBtn:(UIButton *)button{
    if(_firstBtn == nil){
        _firstBtn = button;
        _firstBtn.enabled = NO;
    }else{
        if (_firstBtn .tag == button.tag) {
            [_firstBtn removeFromSuperview];
            [button removeFromSuperview];
            _firstBtn =nil;
            if(self.backView.subviews.count == 0){
                NSLog(@"WIN");
                 _btn = [UIButton new];
                _btn.frame = CGRectMake(100, 500, 80, 50);
//                _btn.backgroundColor = [UIColor blueColor];
                [_btn setTitle:@"下一关" forState:UIControlStateNormal];
                [_btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                [_btn addTarget:self action:@selector(layoutView1) forControlEvents:UIControlEventTouchUpInside];
                [self.view addSubview: _btn];
            }
        }else{
            _firstBtn.enabled = YES;
            _firstBtn = nil;
            
        }
    }
}

-(void)startGame:(UIButton*)btn{

    if (_firstBtn == nil) {
        _firstBtn = btn;
        _firstBtn.enabled = NO;
    }else{
        if (_firstBtn.tag == btn.tag) {

            [_firstBtn removeFromSuperview];

            [btn removeFromSuperview];
            _firstBtn = nil;
            if(self.backView.subviews.count == 0){
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"闯关成功" message:@"我要继续" preferredStyle:UIAlertControllerStyleActionSheet];
                
                                [alert addAction:[UIAlertAction actionWithTitle:@"进入下一关" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                                    [self layoutView2];
                
                                }]];
                                [alert addAction:[UIAlertAction actionWithTitle:@"退出游戏" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                                    [self.navigationController popViewControllerAnimated:YES];
                
                                }]];
                                [self presentViewController:alert animated:YES completion:nil];
            }
        }else {
            _firstBtn.enabled = YES;
            _firstBtn = nil;
        }
    }
}
-(void)cliickBtn:(UIButton*)btn{
    if (_firstBtn == nil) {
        _firstBtn = btn;
        _firstBtn.enabled = NO;
    }else{
        if (_firstBtn.tag == btn.tag) {
            
            [_firstBtn removeFromSuperview];
            
            [btn removeFromSuperview];
            _firstBtn = nil;
            if(self.backView.subviews.count == 0){
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"闯关成功" message:@"过关" preferredStyle:UIAlertControllerStyleActionSheet];
                
                [alert addAction:[UIAlertAction actionWithTitle:@"恭喜通关" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    UIImageView *Iview = [[UIImageView alloc]initWithFrame:self.view.frame];
                    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"p3"]];
                    [Iview setImage:image];
                    [self.view addSubview:Iview];
                    
                }]];
                    [self presentViewController:alert animated:YES completion:nil];
            }
        }else {
            _firstBtn.enabled = YES;
            _firstBtn = nil;
        }
    }
}

@end
