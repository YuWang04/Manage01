//
//  ViewController.m
//  文件操作
//
//  Created by xtjsb on 17/12/12.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
- (IBAction)Click:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *doucument = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucumentStr = [doucument lastObject];
    NSString *path = [doucumentStr stringByAppendingString:@"/wy"];
    NSString *filePath = [path stringByAppendingPathComponent:@"我的文件.txt"];
    NSLog(@"path = %@",path);
    NSFileManager *fileMng = [NSFileManager defaultManager];
    [fileMng createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:nil];
    [fileMng createFileAtPath:filePath contents:nil attributes:nil];
    //写入文件
    NSString *string = @"爱我中华";
    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    UIImage *image = [UIImage imageNamed:@"black"];
    NSData *data = UIImagePNGRepresentation(image);
    NSString *name = [path stringByAppendingPathComponent:@"图片"];
    [data writeToFile:name atomically:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Click:(UIButton *)sender {
    NSArray *doucument = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *doucumentStr = [doucument lastObject];
    NSString *path = [doucumentStr stringByAppendingString:@"/wy"];
    NSString *filePath = [path stringByAppendingPathComponent:@"我的文件.txt"];
    NSString *str = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    self.textView.text = [self.textView.text stringByAppendingString:str];
    self.textView.text = [self.textView.text stringByAppendingString:@"\n"];
}
@end
