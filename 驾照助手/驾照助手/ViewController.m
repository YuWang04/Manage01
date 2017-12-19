//
//  ViewController.m
//  驾照助手
//
//  Created by xtjsb on 17/12/18.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "ViewController.h"
#import "SelectView.h"
#import "FirstViewController.h"
@interface ViewController ()
{
    SelectView* _selectView;
}
@property (weak, nonatomic) IBOutlet UIButton *seletBtn;
@end

@implementation ViewController
- (IBAction)Click:(UIButton *)sender {
    switch (sender.tag) {
        case 100:{
           [UIView animateWithDuration:0.3 animations:^{
               _selectView.alpha = 1;
           }];
        }
            break;
        
        case 101:{//科目一
            FirstViewController *vc1 = [[FirstViewController alloc]init];
            [self.navigationController pushViewController:vc1 animated:YES];
        }
            break;
        case 102:{
            
        }
            break;
        case 103:{
            
        }
            break;
        case 104:{
            
        }
            break;
        case 105:{
            
        }
            break;
        case 106:{
            
        }
            break;
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _selectView = [[SelectView alloc]initWithFrame:self.view.frame andBtn:_seletBtn];
    _selectView.alpha = 0;
    [self.view addSubview:_selectView];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
