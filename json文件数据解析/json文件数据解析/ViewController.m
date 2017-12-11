//
//  ViewController.m
//  json文件数据解析
//
//  Created by xtjsb on 17/12/11.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "ViewController.h"
#import "JSONKit.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textField;
- (IBAction)Action:(UIButton *)sender;

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
    //JOSNKit:兼容ios5以下
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/as.json"];
    NSData *josnData = [NSData dataWithContentsOfURL:url];
    JSONDecoder *jsonDecoder = [[JSONDecoder alloc]init];
    id jsonObj = [jsonDecoder objectWithData:josnData];
    
//    //方法1
//    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/as.json"];
//    NSString *Jsonstr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
//    NSData *jsonData = [Jsonstr dataUsingEncoding:NSUTF8StringEncoding];
      //方法2
//    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/as.json"];
//    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
//    NSData *jsonData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
//    //在网络中解析，方法3
//    NSString *str = @"http://127.0.0.1/as.json";
//    NSURL *url = [NSURL URLWithString:str];
//    NSData *jsonData = [NSData dataWithContentsOfURL:url];
    
    
      //在文件中解析
//    NSString *jsonStr = nil;
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"as" ofType:@"json"];
//    NSFileManager *fileMgr = [NSFileManager defaultManager];
//    if([fileMgr fileExistsAtPath:filePath]){
//        jsonStr = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
//    }else{
//        _textField.text = @"文件不存在";
//        return;
//    }
//    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    
    
//    id  jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];//除了第一个，其他的方法都需要用到
    if([jsonObj isKindOfClass:[NSDictionary class]]){
        if([jsonObj isKindOfClass:[NSDictionary class]]){
            NSDictionary *dict = (NSDictionary*)jsonObj;
            NSDictionary *dict1 = [dict objectForKey:@"weatherinfo"];
            _textField.text = [_textField.text stringByAppendingString:[dict1 objectForKey:@"city"]];
            _textField.text = [_textField.text stringByAppendingString:@"\n"];
            _textField.text = [_textField.text stringByAppendingString:[dict1 objectForKey:@"cityid"]];
            _textField.text = [_textField.text stringByAppendingString:@"\n"];
            _textField.text = [_textField.text stringByAppendingString:[dict1 objectForKey:@"temp1"]];
            _textField.text = [_textField.text stringByAppendingString:@"\n"];
            _textField.text = [_textField.text stringByAppendingString:[dict1 objectForKey:@"temp2"]];
            _textField.text = [_textField.text stringByAppendingString:@"\n"];
            _textField.text = [_textField.text stringByAppendingString:[dict1 objectForKey:@"weather"]];
            _textField.text = [_textField.text stringByAppendingString:@"\n"];
            _textField.text = [_textField.text stringByAppendingString:[dict1 objectForKey:@"ptime"]];
        }
      
    }
    if([jsonObj isKindOfClass:[NSArray class]]){
       
    }

}
@end
