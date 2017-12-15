//
//  ViewController.m
//  NSOperation
//
//  Created by xtjsb on 17/12/14.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "ViewController.h"
#import "customOperation.h"
#define S_URl @"http://127.0.0.1/0_8.jpg"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) NSOperationQueue *queue;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self concurreatCount];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSOperation *operation = [[NSOperation alloc]init];
//    [self invocationOperation];
//    [self blockOperation];
//    [self customOperation];
//    [self xxx];
//    [self threadCommunication];
//    [self dependency];
    [self suspendedAndCancel];
}

//NSInvocationOperation
//不开启新线程
-(void)invocationOperation{
    NSInvocationOperation *ip = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(operation) object:nil];
    [ip start];
}
-(void)operation{
    NSLog(@"1和4---%@---",[NSThread currentThread]);
}

//NSBlockOperation
-(void)blockOperation{
    //在主线程中完成
    NSBlockOperation *bp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2---1---%@",[NSThread currentThread]);
    }];
    //添加的任务在子线程中完成
    [bp addExecutionBlock:^{
        NSLog(@"2---2---%@",[NSThread currentThread]);
    }];
    [bp start];
    
}
//自定义Operation
-(void)customOperation{
    customOperation *op = [[customOperation alloc]init];
    [op start];
}

//CGD队列形式 1、主队列 2、全局队列 3、串行队列（自己创建的） 4、并行队列（自己创建的）
//NSOperationQueue队列形式 1、主队列 2、自己创建的
-(void)xxx{
    //创建（默认）并行队列
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSInvocationOperation *ip = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(operation) object:nil];
    //将操作放置于队列中
    [queue addOperation:ip];
}
//线程通信
-(void)threadCommunication{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [queue addOperationWithBlock:^{
        NSURL *url = [NSURL URLWithString:S_URl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        NSLog(@"5--123--%@",[NSThread currentThread]);
        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
            self.imageView.image = image;
            NSLog(@"5--234--%@",[NSThread currentThread]);
        }];
    }];
    
}
//任务依赖
-(void)dependency{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    NSBlockOperation *bp1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"6--1--%@",[NSThread currentThread]);
    }];
    NSBlockOperation *bp2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"6--2--%@",[NSThread currentThread]);
    }];
    NSBlockOperation *bp3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"6--3--%@",[NSThread currentThread]);
    }];
    /*添加1、2之间的依赖关系：前者依赖于后者,即2先执行（注：任务之间不能相互依赖）
     [bp1 addDependency:bp2];[bp2 addDependency:bp1];不能同时存在
     */
    [bp1 addDependency:bp2];
    [queue addOperation:bp1];
    [queue addOperation:bp2];
    [queue addOperation:bp3];
}
//设置最大并发数
-(void)concurreatCount{
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    queue.maxConcurrentOperationCount = 1;
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"7--1--%@",[NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"7--2--%@",[NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 10000; i++) {
            NSLog(@"7--3--%@",[NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"7--4--%@",[NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"7--5--%@",[NSThread currentThread]);
        }
    }];
    [queue addOperationWithBlock:^{
        for (int i = 0; i < 1000; i++) {
            NSLog(@"7--6--%@",[NSThread currentThread]);
        }
    }];
    self.queue = queue;
}
//队列挂起和取消
-(void)suspendedAndCancel{
//    if(self.queue.suspended){
//        self.queue.suspended = NO;
//    }else{
//        self.queue.suspended = YES;
//    }
    [self.queue cancelAllOperations];
}
@end
