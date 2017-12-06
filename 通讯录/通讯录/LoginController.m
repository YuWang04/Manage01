//
//  LoginController.m
//  通讯录
//
//  Created by xtjsb on 17/12/1.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "LoginController.h"
#import "MBProgressHUD.h"
#import "contactController.h"
#define UserNameKey @"name"
#define PwdKey @"pwd"
#define RmbPwd @"rmb_pwd"
@interface LoginController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UISwitch *rembSwitch;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;


@end

@implementation LoginController
//登录账号密码判断
- (IBAction)loginClick:(UIButton *)sender {
    if(![self.nameField.text isEqualToString:@"王宇"]){
        //NSLog(@"账号错误");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"账号错误" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"账号错误" message:@"请重新输入" preferredStyle:UIAlertControllerStyleActionSheet];
//        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
//        [self presentViewController:alert animated:YES completion:NULL];
        return;
    }
    if(![self.passwordField.text isEqualToString:@"123"]){
        //NSLog(@"密码错误");
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"密码错误" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self performSegueWithIdentifier:@"loginToContact" sender:nil];
        
    });
    //数据存储
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:self.nameField.text forKey:UserNameKey];
    [defaults setObject:self.passwordField.text forKey:PwdKey];
    [defaults setBool:self.rembSwitch.isOn forKey:RmbPwd];
    //设置同步
    [defaults synchronize];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    // Do any additional setup after loading the view.
    //设置观察者
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.passwordField];
    //读取上次配置
    //若Switch状态是on，则记住账号密码，登录按钮可点击
    //若Switch状态不是on，则只记住账号，登录按钮不可点击
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    self.nameField.text = [defaults valueForKey:UserNameKey];
//    self.passwordField.text = [defaults valueForKey:PwdKey];
    self.rembSwitch.on = [defaults boolForKey:RmbPwd];
    if(self.rembSwitch.isOn){
        self.nameField.text = [defaults valueForKey:UserNameKey];
        self.passwordField.text = [defaults valueForKey:PwdKey];
        self.loginBtn.enabled = YES;
    }else{
        self.nameField.text = [defaults valueForKey:UserNameKey];
    }
}
//账号密码都不为空时，按钮可点击
-(void)textChange{
    if(self.nameField.text.length&&self.passwordField.text.length){
        self.loginBtn.enabled = YES;
    }else{
        self.loginBtn.enabled = NO;
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//跳转到目的控制器
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *contactVC = segue.destinationViewController;
    contactVC.title = [NSString stringWithFormat:@"%@的联系人列表",self.nameField.text];
}


@end
