//
//  bulletView.m
//  弹幕
//
//  Created by xtjsb on 17/12/7.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "bulletView.h"
#define Padding  10 //间距
#define PhotoH 30
@interface bulletView()
@property(nonatomic,strong)UILabel* lbComment;//弹幕label
@property(nonatomic,strong)UIImageView* photoIgv;
@end


@implementation bulletView

//初始化弹幕
-(instancetype)initWithConmment:(NSString*)comment{
    if(self = [super init]){
        //self.backgroundColor = [UIColor redColor];
        self.layer.borderWidth = 15;
        //设置弹幕的圆角
        self.layer.cornerRadius = 10;
        //根据传入的comment计算弹幕实际宽度
        NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
        CGFloat width = [comment sizeWithAttributes:attr].width;
        //弹幕View的bounds
        self.bounds = CGRectMake(0, 0, width + 2 * Padding+PhotoH, 30);
        self.lbComment.text = comment;
        //弹幕中label的位置（相对于弹幕view）
        self.lbComment.frame = CGRectMake(Padding+PhotoH, 0, width, 30);
        //图片的位置（相对于弹幕view）
        self.photoIgv.frame = CGRectMake(-Padding, -Padding , Padding+PhotoH, Padding+PhotoH);
        //设置图片圆角
        self.photoIgv.layer.cornerRadius = (Padding+PhotoH)/2;
        //设置边框的颜色
        self.layer.borderColor = [UIColor yellowColor].CGColor;
        //设置边框的宽度
        self.layer.borderWidth = 0.5;
        self.photoIgv.image = [UIImage imageNamed:@"0_13.jpg"];
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
   
    //在弹幕进入屏幕之后，执行enterScreen方法
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
        //结束后从屏幕上移除
        [self removeFromSuperview];
        //回调
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
    //取消performSelector方法的执行
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
//弹幕图片初始化
-(UIImageView*)photoIgv{
    if(!_photoIgv){
        _photoIgv = [UIImageView new];
        _photoIgv.clipsToBounds = YES;
        _photoIgv.contentMode = UIViewContentModeScaleAspectFill;
        [self addSubview:_photoIgv];
    }
    return _photoIgv;
}

@end
