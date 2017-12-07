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
@property(nonatomic,copy)void(^generteViewBlock)(bulletView *view);
-(void)start;
//弹幕停止执行
-(void)stop;


@end
