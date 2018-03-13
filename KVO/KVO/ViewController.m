//
//  ViewController.m
//  KVO
//
//  Created by xtjsb on 2018/3/12.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "tabBarController.h"
@interface ViewController ()
@property (nonatomic, strong) Person *person;

@property (nonatomic, strong) UILabel *heartbeatLabel;
@property (nonatomic, strong)UIButton *runButton;
@property (nonatomic, strong)UITextField *fd;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.person = [[Person alloc] init];
    [self.person setValue:@"72" forKey:@"heartbeat"];
    [self.person addObserver:self forKeyPath:@"heartbeat" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:nil];
    
    self.heartbeatLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 30)];
    self.heartbeatLabel.textColor = [UIColor redColor];
    self.heartbeatLabel.text = [self.person valueForKey:@"heartbeat"];
    [self.view addSubview:self.heartbeatLabel];
    
    _runButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    [_runButton setTitle:@"asas" forState:UIControlStateNormal];
    _runButton.frame = CGRectMake(200, 200, 100, 30);
    _runButton.backgroundColor = [UIColor redColor];
    _runButton.layer.masksToBounds = YES;
    _runButton.layer.cornerRadius = 8;
    _runButton.enabled = NO;
    _runButton.backgroundColor = [UIColor redColor];
    [_runButton addTarget:self action:@selector(run:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_runButton];
    NSLog(@"111111~~~~%@",_heartbeatLabel.text);
    
    _fd = [[UITextField alloc]init];
    _fd.backgroundColor = [UIColor redColor];
    _fd.frame = CGRectMake(10, 300, 100, 40);
    [self.view addSubview:_fd];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updata) name:UITextFieldTextDidChangeNotification object:self.fd];
}
-(void)updata{
    if(self.fd.text.length){
        self.runButton.enabled = YES;
    }else{
        self.runButton.enabled = NO;
    }
}
- (void)run:(UIButton *)sender {
    
    [self.person setValue:@"100" forKey:@"heartbeat"];
    NSLog(@"222222~~~~%@",_heartbeatLabel.text);
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"heartbeat"])
    {
        self.heartbeatLabel.text = [change objectForKey:@"new"];
        NSLog(@"333333~~~~%@",_heartbeatLabel.text);
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    tabBarController *vc = [[tabBarController alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)dealloc {
    
    [self.person removeObserver:self forKeyPath:@"heartbeat"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
