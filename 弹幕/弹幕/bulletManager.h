//
//  bulletManager.h
//  弹幕
//
//  Created by xtjsb on 17/12/7.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import <Foundation/Foundation.h>
@class bulletView;
@interface bulletManager : NSObject
//回调
@property(nonatomic,copy)void(^generteViewBlock)(bulletView *view);
//弹幕开始执行
-(void)start;
//弹幕停止执行
-(void)stop;


@end
