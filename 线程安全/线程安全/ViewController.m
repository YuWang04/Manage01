//
//  ViewController.m
//  线程安全
//
//  Created by xtjsb on 17/12/14.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,strong)NSThread *thread1;
@property(nonatomic,strong)NSThread *thread2;
@property(nonatomic,strong)NSThread *thread3;
@property(nonatomic,assign)NSInteger tickets;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tickets = 1000;
    self.thread1 = [[NSThread alloc]initWithTarget:self selector:@selector(selltickets) object:nil];
    self.thread1.name = @"小王";
    self.thread2 = [[NSThread alloc]initWithTarget:self selector:@selector(selltickets) object:nil];
    self.thread2.name = @"小张";
    self.thread3 = [[NSThread alloc]initWithTarget:self selector:@selector(selltickets) object:nil];
    self.thread3.name = @"小刚";
}

-(void)selltickets{
    while (self.tickets > 0) {
        //加锁，括号里的锁对象必须唯一
       // @synchronized (self) {
        NSInteger currentTickets = self.tickets;
        if(currentTickets > 0){
            NSLog(@"%@卖了一张票，还剩%ld",[NSThread currentThread].name,--self.tickets);
        }else{
            NSLog(@"没票了");
        }
     // }
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_thread1 start];
    [_thread2 start];
    [_thread3 start];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
