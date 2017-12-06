//
//  ViewController.m
//  my
//
//  Created by xtjsb on 17/12/6.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *TextField1;
@property (weak, nonatomic) IBOutlet UITextField *TextField2;

@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)AddAction:(UIButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)AddAction:(UIButton *)sender {
    NSString *num1 = _TextField1.text;
    NSString *num2 = _TextField2.text;
    
    double n1 = num1.doubleValue;
    double n2 = [num2 doubleValue];
    
    double result = n1 + n2;
    self.label.text = [NSString stringWithFormat:@"%f", result];
    [self.view endEditing:YES];
}
@end
