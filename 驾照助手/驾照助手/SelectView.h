//
//  SelectView.h
//  驾照助手
//
//  Created by xtjsb on 17/12/18.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectView : UIView
@property (weak, nonatomic)  UIButton *button;
-(instancetype)initWithFrame:(CGRect)frame andBtn:(UIButton*)btn;
@end
