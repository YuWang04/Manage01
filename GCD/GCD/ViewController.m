//
//  ViewController.m
//  GCD
//
//  Created by xtjsb on 17/12/14.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "ViewController.h"
#define D_URl @"http://127.0.0.1/0_8.jpg"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self EruptSync];
//    [self EruptAsyn];
//    [self globalSync];
//    [self globalAsync];
//    [self serialSync];
//    [self serialAsync];
//    [self mainSync];
//    [self mainAsync];
//    [self GCDtd];
    [self once];
    [self apply];
    [self group];
}
/*
 前四个都是并发队列
 */
//并发队列 + 同步任务  没有开启新线程
- (void)EruptSync{
//创建并发队列
   dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
//在队列里添加任务
//同步任务
   dispatch_sync(queue, ^{
    for(int i = 0;i < 5; i++){
        NSLog(@"---1---%@",[NSThread currentThread]);
    }
});
   dispatch_sync(queue, ^{
    for(int i = 0;i < 5; i++){
        NSLog(@"---2---%@",[NSThread currentThread]);
    }
});
   dispatch_sync(queue, ^{
    for(int i = 0;i < 5; i++){
        NSLog(@"---3---%@",[NSThread currentThread]);
    }
});
}
//并发队列 + 异步任务：造成结果是，开启了新线程，任务是并发的
-(void)EruptAsyn{
    dispatch_queue_t queue = dispatch_queue_create("queue", DISPATCH_QUEUE_CONCURRENT);
    //异步任务
    dispatch_async(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---1---%@",[NSThread currentThread]);
        }

    });
    dispatch_async(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---2---%@",[NSThread currentThread]);
        }
        
    });
    dispatch_async(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---3---%@",[NSThread currentThread]);
        }
        
    });
}
//全局队列 + 同步任务 没有开启新线程，任务是逐个完成的
-(void)globalSync{
    dispatch_queue_t queue= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //在队列里添加任务
        //同步任务
        dispatch_sync(queue, ^{
            for(int i = 0;i < 5; i++){
                NSLog(@"---1---%@",[NSThread currentThread]);
            }
        });
        dispatch_sync(queue, ^{
            for(int i = 0;i < 5; i++){
                NSLog(@"---2---%@",[NSThread currentThread]);
            }
        });
        dispatch_sync(queue, ^{
            for(int i = 0;i < 5; i++){
                NSLog(@"---3---%@",[NSThread currentThread]);
            }
        });
}
//全局队列 + 异步任务  开启了新线程，任务是并发的
-(void)globalAsync{
    dispatch_queue_t queue= dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //在队列里添加任务
    //同步任务
    dispatch_async(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---1---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---2---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---3---%@",[NSThread currentThread]);
        }
    });
}


//串行队列 + 同步任务 没有开启新线程，任务是逐个完成的
-(void)serialSync{
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
    //在队列里添加任务
    //同步任务
    dispatch_sync(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---1---%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---2---%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---3---%@",[NSThread currentThread]);
        }
    });
}
//串行队列 + 异步任务 开启新的线程 任务是逐个完成的
-(void)serialAsync{
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
    //在队列里添加任务
    //同步任务
    dispatch_async(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---1---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---2---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---3---%@",[NSThread currentThread]);
        }
    });

}


//主队列 + 同步任务 会造成死锁的现象（不能在主队列里添加同步任务）
-(void)mainSync{
    dispatch_queue_t queue = dispatch_get_main_queue();
    //在队列里添加任务
    //同步任务
    dispatch_sync(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---1---%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---2---%@",[NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---3---%@",[NSThread currentThread]);
        }
    });
}
//主队列 + 异步任务 没有开启新线程
-(void)mainAsync{
    dispatch_queue_t queue = dispatch_get_main_queue();
    //在队列里添加任务
    //同步任务
    dispatch_async(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---1---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---2---%@",[NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for(int i = 0;i < 5; i++){
            NSLog(@"---3---%@",[NSThread currentThread]);
        }
    });
}

//线程通信
//同步任务先执行block的代码，
//异步任务先执行block外的代码
-(void)GCDtd{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //耗时操作
        NSURL *url = [NSURL URLWithString:D_URl];
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *image = [UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            //延迟执行
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t) (2*NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                //显示图片
                self.imageView.image = image;
                NSLog(@"222");
            });
            
        });
        NSLog(@"111");
    });
    
    
}

//一次性代码
-(void)once{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"123");
    });
}
//多次操作 index不能自动生成，自己加上
-(void)apply{
    dispatch_apply(10, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t index) {
        NSLog(@"--%ld--",index);
    });
}
//队列组
-(void)group{
    //创建组
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i = 0;i < 1000; i++){
        NSLog(@"我爱你");
        }
    });
    dispatch_group_async(group,dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for(int i = 0;i < 1000; i++){
        NSLog(@"喜欢你");
        }
    });
    //当两个异步操作完成后
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"还是喜欢你");
        [self GCDtd];
    });
}
@end
