//
//  bulletManager.m
//  弹幕
//
//  Created by xtjsb on 17/12/7.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "bulletManager.h"
#import "bulletView.h"
@interface bulletManager()
//弹幕的数据来源
@property(nonatomic,strong)NSMutableArray *datasource;
//弹幕使用过程中的数组变量
@property(nonatomic,strong)NSMutableArray *bulletComments;
//存储弹幕view的数组变量
@property(nonatomic,strong)NSMutableArray *bulletViews;
@end
@implementation bulletManager
-(void)stop{
    
}
-(void)start{
    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.datasource];
    
    [self initBulletComments];
}
//初始化弹幕，随机分配弹幕轨迹
-(void)initBulletComments{
    NSMutableArray *tarjectroys = [NSMutableArray arrayWithArray:@[@(0),@(1),@(2),@(3),@(4),@(5),@(6),@(7),@(8),@(9)]];
    for(int i = 0;i < 9;i++){
        if(self.bulletComments.count > 0){
        //通过随机数获取弹幕
        NSInteger index = arc4random()%tarjectroys.count;
        int tarjectroy = [[tarjectroys objectAtIndex:index] intValue];
        [tarjectroys removeObjectAtIndex:index];
        //从弹幕数组中逐一取出弹幕
        NSString *comment = [self.bulletComments firstObject];
        [self.bulletComments removeObjectAtIndex:0];
        //创建弹幕view
        [self createBulletView:comment tarjectroy:tarjectroy];
      }
    }
}
-(void)createBulletView:(NSString*)comment tarjectroy:(int) tarjectroy{
    bulletView *view = [[bulletView alloc]initWithConmment:comment];
    view.tarjectroy = tarjectroy;
    [self.bulletViews addObject:view];
    __weak typeof (view) weakView = view;
    __weak typeof (self) myself = self;
    view.moveStausblock=^{
        //移出屏幕后销毁弹幕并释放资源
        [weakView stopAnimation];
        [myself.bulletViews removeObject:weakView];
    };
    if(self.generteViewBlock){
        self.generteViewBlock(view);
    }
    
}
-(NSMutableArray*)datasource{
    if(!_datasource){
        _datasource = [NSMutableArray arrayWithArray:@[@"弹幕1。。。。。",
                                                       @"弹幕2。。。",
                                                       @"弹幕3~~~~~~~~~~~~~~~~~",
                                                       @"弹幕4——————————————",
                                                       @"弹幕5~~~~~~~~~~~",
                                                       @"弹幕6~~~~~~~~~~~~~~~~~",
                                                       @"弹幕7~~~~~~",
                                                       @"弹幕8~~~~~~~~~~~~~~",
                                                       @"弹幕9~~~~~~~~~~"
                                                       ]];
    }
    return _datasource;
}

-(NSMutableArray*)bulletComments{
    if(!_bulletComments){
        _bulletComments = [NSMutableArray array];
    }
    return _bulletComments;
}

-(NSMutableArray*)bulletViews{
    if(!_bulletViews){
        _bulletViews = [NSMutableArray array];
    }
    return _bulletViews;
}
@end
