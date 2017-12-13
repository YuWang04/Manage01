//
//  ViewController.m
//  NSURLSession类网络操作
//
//  Created by xtjsb on 17/12/13.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "ViewController.h"
#define S_URL @"http://new.api.bandu.cn/book/listofgrade?grade_id=2"
#define IMAGE_URL @"http://127.0.0.1/0_8.jpg"

@interface ViewController ()<NSURLSessionDataDelegate>
@property(nonatomic,strong)NSMutableData *data;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self dataTask];//Get
//    [self post];//Post
//    [self Session];
    [self downLoad];
    
    
}
//一.Download下载任务
-(void)downLoad{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *LoadDask = [session downloadTaskWithURL:[NSURL URLWithString:IMAGE_URL] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:location]];
        //获取主队列，进行UI操作
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
    }];
    [LoadDask resume];
}


//二.DataDask代理方法
-(void)Session{
    NSURL *url = [NSURL URLWithString:S_URL];
    //封装一个请求类
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask * dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}
#pragma mark 代理方法
//接收到服务器的响应
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler{
    NSLog(@"didReceiveResponse");
    if(self.data == nil){
        self.data = [[NSMutableData alloc]init];
    }else{
        _data.length = 0;
    }
    completionHandler(NSURLSessionResponseAllow);
}
//接收到数据，该方法会被调用多次
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    NSLog(@"didReceiveData");
    [self.data appendData: data];
}
//数据请求完成或者请求出现错误的方法
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error{
    NSLog(@"didCompleteWithError");
    if(!error){
        id objc = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"%@",objc);
    }
}

//三.
-(void)post{
    NSURL *url =[NSURL URLWithString:@"http://new.api.bandu.cn/book/listofgrade?"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"post";
    request.HTTPBody = [@"grade_id=2" dataUsingEncoding:NSUTF8StringEncoding];
    //创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    //根据会话创建任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",objc);
        }else{
            NSLog(@"%@",error);
        }
        //block内容在子线程中执行，如果想做UI操作必须回归主线程
        //回归主线程方法
        //1
        //        [self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>]
        //2
        //        dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
        //3
        //        [[NSOperationQueue mainQueue]addOperationWithBlock:<#^(void)block#>];
    }];
    //启动任务
    [dataTask resume];
}

//四.
-(void)dataTask{
    NSURL *url = [NSURL URLWithString:S_URL];
    //封装一个请求类
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //创建会话
    NSURLSession *session = [NSURLSession sharedSession];
    //根据会话创建任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(!error){
            id objc = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@",objc);
        }else{
            NSLog(@"%@",error);
        }
        //block内容在子线程中执行，如果想做UI操作必须回归主线程
        //回归主线程方法
        //1
        //        [self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>]
        //2
        //        dispatch_async(<#dispatch_queue_t  _Nonnull queue#>, <#^(void)block#>)
        //3
        //        [[NSOperationQueue mainQueue]addOperationWithBlock:<#^(void)block#>];
    }];
    //启动任务
    [dataTask resume];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
