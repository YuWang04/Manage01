//
//  ViewController.m
//  NSThread
//
//  Created by xtjsb on 17/12/14.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "ViewController.h"
#import "SController.h"
@interface ViewController ()
- (IBAction)Action:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextView *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Action:(UIButton *)sender {
    //开启子线程的三个方法
//    [self createThread1];
    [self createThread2];
//    [self createThread3];
}
-(void)createThread3{
    //开启一个后台线程（子线程）
    [self performSelectorInBackground:@selector(Arun:) withObject:nil];
}
-(void)createThread2{
    [NSThread detachNewThreadSelector:@selector(Arun:) toTarget:self withObject:nil];
}
-(void)createThread1{
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(Arun:) object:@"123"];
    [thread start];
}
-(void)Arun:(id)obj{
    NSLog(@"123");
    //方法1，线程休眠5s
//    [NSThread sleepForTimeInterval:3];
    //方法2
//    [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:2]];
    
    for(int i = 0;i<100000;i++){
        NSLog(@"%d",i);
        if(i==9000){
        //强制退出线程
        [NSThread exit];
        }

    }
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SController *sVC = [[SController alloc]init];
    [self presentViewController:sVC animated:YES completion:nil];
}
@end
