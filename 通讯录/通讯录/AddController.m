//
//  AddController.m
//  通讯录
//
//  Created by xtjsb on 17/12/1.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "AddController.h"
#import "JKConModel.h"
@interface AddController ()
- (IBAction)backAction:(UIBarButtonItem *)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameF;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
- (IBAction)addClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;


@end

@implementation AddController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.nameF];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange) name:UITextFieldTextDidChangeNotification object:self.phoneField];
}
-(void)textChange{
    if(self.nameF.text.length&&self.phoneField.text.length){
        self.addBtn.enabled = YES;
    }else{
        self.addBtn.enabled = NO;
    }
}

-(void)viewDidAppear:(BOOL)animated{
    [super  viewDidAppear:animated];
    //nameF成为第一响应者
    [self.nameF becomeFirstResponder];
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

- (IBAction)backAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)addClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
    if([self.delegate respondsToSelector:@selector(addContact:didAddContact:)]){
        JKConModel *contactModel = [[JKConModel alloc]init];
        contactModel.name = self.nameF.text;
        contactModel.phone = self.phoneField.text;
        [self.delegate addContact:self didAddContact:contactModel];
    }
}
@end
