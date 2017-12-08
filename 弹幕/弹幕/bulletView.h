//
//  bulletView.h
//  弹幕
//
//  Created by xtjsb on 17/12/7.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,MoveStatus){
    Start,
    Enter,
    End
};
@interface bulletView : UIView
@property(nonatomic,assign)int tarjectroy;//弹道
//block用于回调，可以将其他类的数据或代码，在定义block的类中使用；即在bulletView.m中调用bulletManager.m中的数据。
@property(nonatomic,copy)void(^moveStausblock)(MoveStatus status);//弹幕的状态
//初始化弹幕
-(instancetype)initWithConmment:(NSString*)comment;
//开始动画
-(void)startAnimation;
//结束动画
-(void)stopAnimation;
@end
