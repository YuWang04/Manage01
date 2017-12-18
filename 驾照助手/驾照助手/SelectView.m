//
//  SelectView.m
//  驾照助手
//
//  Created by xtjsb on 17/12/18.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "SelectView.h"
#define kScreenWidth self.frame.size.width
#define kScreenHeight self.frame.size.height
@implementation SelectView

-(instancetype)initWithFrame:(CGRect)frame andBtn:(UIButton*)btn{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
        _button = btn;
        [self creatBtn];
    }
    return  self;
}
-(void)creatBtn{
    for(int i = 0;i < 4;i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(kScreenWidth/4*i + kScreenWidth/4/2-30, kScreenHeight-80, 60, 60);
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]];
        [btn setImage:image forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(Click:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
}
-(void)Click:(UIButton *)btn{
    [_button setImage:[btn backgroundImageForState:UIControlStateNormal] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
