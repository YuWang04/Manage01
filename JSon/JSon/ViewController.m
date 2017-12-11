//
//  ViewController.m
//  JSon
//
//  Created by xtjsb on 17/12/11.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "ViewController.h"
#import "FController.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tvParseResult;
- (IBAction)OnParseJson:(UIButton *)sender;
- (IBAction)changePage:(UIButton *)sender;

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


- (IBAction)OnParseJson:(UIButton *)sender {
//    NSString *jsonStr = @"{\"name\":\"James\",\"age\":\"30\",}";
//    NSString *jsonTreeStr = @"{\"user\":{\"name\":\"James\",\"age\":\"23\"}}";
//    NSString *jsonArrayStr = @"[{\"name\":\"james\"},{\"name\":\"jim\"}]";
    NSString *jsonTreeArrStr = @"{\"user\":[{\"name\":\"tom\"},{\"name\":\"jack\"}]}";
    NSData *jsonData = [jsonTreeArrStr dataUsingEncoding:NSUTF8StringEncoding];
    id  jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:nil];
    if([jsonObj isKindOfClass:[NSDictionary class]]){
//        NSDictionary *dic = (NSDictionary *)jsonObj;
//        NSDictionary *dic1 = [dic objectForKey:@"user"];
//        _tvParseResult.text = [_tvParseResult.text stringByAppendingString:@"\n"];
//        _tvParseResult.text = [_tvParseResult.text stringByAppendingString: [dic1 objectForKey:@"name"]];
//        _tvParseResult.text = [_tvParseResult.text stringByAppendingString:@"\n"];
//        _tvParseResult.text = [_tvParseResult.text stringByAppendingString: [dic1 objectForKey:@"age"]];
        NSDictionary *dic = (NSDictionary *)jsonObj;
        NSDictionary *arr = [dic objectForKey:@"user"];
        for (NSDictionary* dic1 in arr) {
            _tvParseResult.text = [_tvParseResult.text stringByAppendingString: [dic1 objectForKey:@"name"]];
            _tvParseResult.text = [_tvParseResult.text stringByAppendingString:@"\n"];
            
        }
    }
    if([jsonObj isKindOfClass:[NSArray class]]){
        NSArray *arr = (NSArray *)jsonObj;
        for (NSDictionary* dic in arr) {
            _tvParseResult.text = [_tvParseResult.text stringByAppendingString:@"\n"];
            _tvParseResult.text = [_tvParseResult.text stringByAppendingString: [dic objectForKey:@"name"]];
            _tvParseResult.text = [_tvParseResult.text stringByAppendingString:@"\n"];
         
        }
    }
}

- (IBAction)changePage:(UIButton *)sender {
    FController *vc = [[FController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
@end
