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
    // Do any additional setup after loading the view, typically from a nib.
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
