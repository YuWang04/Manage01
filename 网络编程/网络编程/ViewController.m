//
//  ViewController.m
//  网络编程
//
//  Created by xtjsb on 17/12/13.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "ViewController.h"
#define S_URL @"http://new.api.bandu.cn/book/listofgrade?grade_id=2"
#define D_URL @"http://www.baidu.com"
@interface ViewController ()<NSURLConnectionDataDelegate>
@property(nonatomic,strong)NSMutableData *data;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self sync];
//    [self ASync];
//    [self async_dalagate];
    [self post];
}

-(void)post{
    NSURL *url =[NSURL URLWithString:@"http://new.api.bandu.cn/book/listofgrade?"];
    NSMutableURLRequest *mRequest = [[NSMutableURLRequest alloc]initWithURL:url];
    mRequest.HTTPMethod = @"post";
    mRequest.HTTPBody = [@"grade_id=2" dataUsingEncoding:NSUTF8StringEncoding];
    [NSURLConnection sendAsynchronousRequest:mRequest queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(connectionError ==nil){
//            NSLog(@"数据%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"----->%@",dict);
        }else{
            NSLog(@"connectionError = %@",connectionError);
        }
    }];
    
}

//同步请求
-(void)sync{
    NSURL *url = [NSURL URLWithString:S_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection  sendSynchronousRequest:request returningResponse:&response error:&error];
    if(error == nil){
        NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"reponse =  %@",response);
        NSLog(@"网络数据%@",string);
    }else{
        NSLog(@"——%@",error);
    }
}
//异步请求
-(void)ASync{
    NSURL *url = [NSURL URLWithString:S_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if(!connectionError){
            NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"数据 = %@",str);
            NSLog(@"请求头 = %@",response);
        }else{
            NSLog(@"connectionError = %@",connectionError);
        }
        NSLog(@"当前线程%@",[NSThread currentThread]);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//异步请求--dalagate
-(void)async_dalagate{
    NSURL *url = [NSURL URLWithString:S_URL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"错误 =%@",error);
}
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"请求头 =%@",response);
    if(self.data){
        self.data.length = 0;
    }else{
        self.data = [[NSMutableData alloc]init];
    }
}
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"数据 =%zd",data.length);
    [self.data appendData:data];
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSLog(@"结束任务");
    NSString *string = [[NSString alloc]initWithData:_data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
}

@end
