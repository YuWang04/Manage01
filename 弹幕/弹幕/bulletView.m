//
//  bulletView.m
//  弹幕
//
//  Created by xtjsb on 17/12/7.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "bulletView.h"
#define Padding  10 //间距
@interface bulletView()
@property(nonatomic,strong)UILabel* lbComment;//弹幕label
@end


@implementation bulletView

//初始化弹幕
-(instancetype)initWithConmment:(NSString*)comment{
    if(self = [super init]){
        self.backgroundColor = [UIColor redColor];
        //根据传入的comment计算弹幕实际宽度
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGFloat width = [comment sizeWithAttributes:attr].width;
        self.bounds = CGRectMake(0, 0, width + 2 * Padding, 30);
        self.lbComment.text = comment;
        self.lbComment.frame = CGRectMake(Padding, 0, width, 30);
    }
    return self;
}
//开始动画
-(void)startAnimation{
    //根据弹幕的长度执行动画效果
    //根据v=st
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat duration = 4.0;
    CGFloat wholeWidth = screenWidth + CGRectGetWidth(self.bounds);
    //弹幕开始
    if(self.moveStausblock){
        self.moveStausblock(Start);
    }
    //t=s/v
     CGFloat speed = wholeWidth/duration;
    CGFloat enterDuration = CGRectGetWidth(self.bounds)/speed;
   
    [self performSelector:@selector(enterScreen) withObject:nil afterDelay:enterDuration];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(enterDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        if(self.moveStausblock){
//            self.moveStausblock(Enter);
//        }
//    });
    __block CGRect frame = self.frame;
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveLinear  animations:^{
        frame.origin.x -= wholeWidth;
        self.frame = frame;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        if(self.moveStausblock){
            self.moveStausblock(End);
        }
    }];
}
-(void)enterScreen{
    if(self.moveStausblock){
        self.moveStausblock(Enter);
    }
}
//结束动画
-(void)stopAnimation{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.layer removeAllAnimations];
    [self removeFromSuperview];
    
}
//弹幕label初始化
-(UILabel*)lbComment{
    if(!_lbComment){
        _lbComment = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbComment.font = [UIFont systemFontOfSize:14];
        _lbComment.textColor = [UIColor whiteColor];
        _lbComment.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbComment];
    }
    return _lbComment;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
