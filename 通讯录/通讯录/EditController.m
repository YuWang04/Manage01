//
//  EditController.m
//  通讯录
//
//  Created by xtjsb on 17/12/1.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "EditController.h"
#import "JKConModel.h"
@interface EditController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
- (IBAction)SaveAction:(UIButton *)sender;
- (IBAction)EditAction:(UIBarButtonItem *)sender;


@end

@implementation EditController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.nameField.text = self.model.name;
    self.phoneField.text = self.model.phone;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameField];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
}
-(void)textChange{
    if(self.nameField.text.length&&self.phoneField.text.length){
        self.saveBtn.enabled = YES;
    }else{
        self.saveBtn.enabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)SaveAction:(UIButton *)sender {
    //关闭当前页码
    [self.navigationController popViewControllerAnimated:YES];
    //通知代理
    if([self.delegate respondsToSelector:@selector(editViewController:didSaveContact:)]){
        //更新数据模型
        self.model.name = self.nameField.text;
        self.model.phone = self.phoneField.text;
        [self.delegate editViewController:self didSaveContact:self.model];
    }
}



- (IBAction)EditAction:(UIBarButtonItem *)sender {
    if(self .nameField.enabled){
        self.nameField.enabled = NO;
        self.phoneField.enabled = NO;
        [self.view endEditing:YES];
        self.saveBtn.hidden = YES;
        sender.title = @"编辑";
        //还原原来的数据
        self.nameField.text = self.model.name;
        self.phoneField.text = self.model.phone;
    }else{
        self.nameField.enabled = YES;
        self.phoneField.enabled = YES;
        [self.view endEditing:YES];
        self.saveBtn.hidden = NO;
        sender.title = @"取消";
    }
}
@end
