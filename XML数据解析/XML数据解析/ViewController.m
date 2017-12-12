//
//  ViewController.m
//  XML数据解析
//
//  Created by xtjsb on 17/12/11.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<NSXMLParserDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textField;
- (IBAction)Action:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //获取沙盒路径
    NSString *homePath = NSHomeDirectory();
    NSLog(@"%@",homePath);
    //获取Document路径
    NSArray *docuPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [docuPaths lastObject];
    NSLog(@"%@",documentsPath);
    //追加文件夹路径
    NSString *testPath = [documentsPath stringByAppendingPathComponent:@"wy"];
    //追加文件路径
    NSString *textFile = [testPath stringByAppendingPathComponent:@"我的文件.txt"];
    NSFileManager *fileMng = [NSFileManager defaultManager];
    //参数二：文件夹重复是否覆盖
//    BOOL ret = [fileMng createDirectoryAtPath:testPath withIntermediateDirectories:NO attributes:nil error:nil];
    BOOL ret = [fileMng createFileAtPath:textFile contents:nil attributes:nil];
    if(ret){
        NSLog(@"文件创建成功");
    }else{
        NSLog(@"文件创建失败");
    }
    //写入文件
    NSString *content = @"写入到文件";
    BOOL bl = [content writeToFile:textFile atomically:YES encoding:NSUTF8StringEncoding error:nil];
    if(bl){
        NSLog(@"写入成功");
    }else{
        NSLog(@"写入失败");
    }
    //判断文件是否存在
    if([fileMng fileExistsAtPath:textFile]){
        NSLog(@"存在");
    }else{
        NSLog(@"不存在");
    }
    //追加内容
    //打开文件准备更新
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:textFile];
    [fileHandle seekToEndOfFile];//将节点调到末尾
    NSString *string = @"追加的内容";
    NSData *sringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [fileHandle writeData:sringData];
    [fileHandle closeFile];//关闭文件
    
    //删除操作
    BOOL we = [fileMng removeItemAtPath:textFile error:nil];
    if(we){
        NSLog(@"文件删除成功");
    }else{
        NSLog(@"文件删除失败");
    }
//    //获取Library路径
//    NSArray *libPaths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
//    NSLog(@"libPaths = %@",libPaths);
//    //获取Tmp路径
//    NSString *tmpPath = NSTemporaryDirectory();
//    NSLog(@"tmpPath = %@",tmpPath);
//    //获取路径的各个部分
//    NSArray *arrpath = [tmpPath pathComponents];
//    NSLog(@"arrpath = %@",arrpath);
//    //删除路径的最后一个部分
//    NSString *string = [tmpPath stringByDeletingLastPathComponent];
//    NSLog(@"string = %@",string);
//    //在路径后添加一个部分
//    NSString *filepath = [tmpPath stringByAppendingString:@"name.text"];
//    NSLog(@"filepath = %@",filepath);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Action:(UIButton *)sender {
//    NSString *xmlStr = @"<info>Tom</info>";
     NSString *xmlStr = @"<info name=\"James\"></info>";
    NSData *xmlData = [xmlStr dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser *xmlParser = [[NSXMLParser alloc]initWithData:xmlData];
    xmlParser.delegate = self;
    [xmlParser parse];
}
//准备解析
- (void)parserDidStartDocument:(NSXMLParser *)parser;{
    _textField.text = [_textField.text stringByAppendingString:@"准备解析"];
    _textField.text = [_textField.text stringByAppendingString:@"\n"];
}
//准备解析当前节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName attributes:(NSDictionary<NSString *, NSString *> *)attributeDict{
    _textField.text = [_textField.text stringByAppendingString:@"准备解析当前节点:"];
    _textField.text = [_textField.text stringByAppendingString:elementName];
    _textField.text = [_textField.text stringByAppendingString:@"\n"];
    _textField.text = [_textField.text stringByAppendingString:[attributeDict objectForKey:@"name"]];
    _textField.text = [_textField.text stringByAppendingString:@"\n"];
}
//获取首位节点的内容
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
//    _textField.text = [_textField.text stringByAppendingString:string];
//    _textField.text = [_textField.text stringByAppendingString:@"\n"];
}
//解析完当前节点
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(nullable NSString *)namespaceURI qualifiedName:(nullable NSString *)qName{
    _textField.text = [_textField.text stringByAppendingString:@"解析完当前节点"];
    _textField.text = [_textField.text stringByAppendingString:@"\n"];
}
//解析结束
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    _textField.text = [_textField.text stringByAppendingString:@"解析结束"];
    _textField.text = [_textField.text stringByAppendingString:@"\n"];
}
@end
