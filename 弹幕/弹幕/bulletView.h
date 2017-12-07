//
//  bulletView.h
//  弹幕
//
//  Created by xtjsb on 17/12/7.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bulletView : UIView
@property(nonatomic,assign)int tarjectroy;//弹道
@property(nonatomic,copy)void(^moveStausblock)();//弹幕的状态
//初始化弹幕
-(instancetype)initWithConmment:(NSString*)comment;
//开始动画
-(void)startAnimation;
//结束动画
-(void)stopAnimation;
@end
