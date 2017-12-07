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
@property BOOL bStopAnimation;
@end
@implementation bulletManager
-(instancetype)init{
    if(self = [super init]){
        self.bStopAnimation = YES;
    }
    return self;
}
-(void)stop{
    if(_bStopAnimation){
        return;
    }
    self.bStopAnimation = YES;
    [self.bulletViews enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        bulletView *view =obj;
        [view stopAnimation];
        view = nil;
    }];
    [self.bulletViews removeAllObjects];
}
-(void)start{
    if(!_bStopAnimation){
        return;
    }
    self.bStopAnimation = NO;
    [self.bulletComments removeAllObjects];
    [self.bulletComments addObjectsFromArray:self.datasource];
    
    [self initBulletComments];
}
//初始化弹幕，随机分配弹幕轨迹
-(void)initBulletComments{
    NSMutableArray *tarjectroys = [NSMutableArray arrayWithArray:@[@(0),@(1),@(2)]];
    for(int i = 0;i < 3;i++){
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
    if(self.bStopAnimation){
        return;
    }
    bulletView *view = [[bulletView alloc]initWithConmment:comment];
    view.tarjectroy = tarjectroy;
    [self.bulletViews addObject:view];
    __weak typeof (view) weakView = view;
    __weak typeof (self) myself = self;
    view.moveStausblock=^(MoveStatus status){
        if(self.bStopAnimation){
            return;
        }
        switch (status) {
            case Start:{
                //弹幕开始进入屏幕，姜View加入到弹幕管理的变量中bulletviews
                [myself.bulletViews addObject:weakView];
                break;
            }
            case Enter:{
                //弹幕完全进入屏幕，判断是否还有其他内容，若果有则在弹幕轨迹中创建一个弹幕
                NSString *comment = [myself nextComment];
                if(comment){
                    [myself createBulletView:comment tarjectroy:tarjectroy];
                }
                
                break;
            }
            case End:{
                //弹幕完全飞出屏幕后从bulletViews中删除，释放资源
                if([myself.bulletViews containsObject:weakView]){
                    [weakView stopAnimation];
                    [myself.bulletViews removeObject:weakView];
                }
                if(myself.bulletViews.count ==0){
                    //说明屏幕上没有弹幕，开始循环滚动
                    self.bStopAnimation = YES;
                    [myself start];
                }
                break;
            }
            default:
                break;
        }
//        //移出屏幕后销毁弹幕并释放资源
//        [weakView stopAnimation];
//        [myself.bulletViews removeObject:weakView];
    };
    if(self.generteViewBlock){
        self.generteViewBlock(view);
    }
    
}
-(NSString*)nextComment{
    if(self.bulletComments.count == 0){
        return nil;
    }
    NSString *comment = [self.bulletComments firstObject];
    if(comment){
        [self.bulletComments removeObjectAtIndex:0];
    }
    return comment;
}
-(NSMutableArray*)datasource{
    if(!_datasource){
        _datasource = [NSMutableArray arrayWithArray:@[@"弹幕1~~~~~",
                                                       @"弹幕2~~~~~~~~~~~~~~~~~~~~~~~~",
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
