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
    //遍历
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
    //先将临时存储的数据变量去除
    [self.bulletComments removeAllObjects];
    //添加新的数据
    [self.bulletComments addObjectsFromArray:self.datasource];
    //初始化弹幕，随机分配弹幕轨迹
    [self initBulletComments];
}
//初始化弹幕，随机分配弹幕轨迹
-(void)initBulletComments{
    //创建弹幕轨道数组
    NSMutableArray *tarjectroys = [NSMutableArray arrayWithArray:@[@(0),@(1),@(2),@(3),@(4),@(5)]];
    for(int i = 0;i < 6;i++){
        if(self.bulletComments.count > 0){
        //通过随机数获取弹幕
        NSInteger index = arc4random()%tarjectroys.count;
        int tarjectroy = [[tarjectroys objectAtIndex:index] intValue];
        //把取过的删除
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
    //block调用
    view.moveStausblock=^(MoveStatus status){
        if(self.bStopAnimation){
            return;
        }
        switch (status) {
            case Start:{
                //弹幕开始进入屏幕，将View加入到弹幕管理的变量中bulletviews
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
                //判断是否包含当前的veiw
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
//从数据源中取下一个弹幕
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
        _datasource = [NSMutableArray arrayWithArray:@[@"大江东去，",
                                                       @"浪淘尽，",
                                                       @"千古风流人物。",
                                                       @"故垒西边，",
                                                       @"人道是，",
                                                       @"三国周郎赤壁。",
                                                       @"乱石穿空，",
                                                       @"惊涛拍岸，卷起千堆雪。",
                                                       @"江山如画，一时多少豪杰。",
                                                       @"遥想公瑾当年，",
                                                       @"小乔初嫁了，雄姿英发。",
                                                       @"羽扇纶巾，",
                                                       @"谈笑间，",
                                                       @"樯橹灰飞烟灭。(樯橹 一作：强掳)",
                                                       @"故国神游，",
                                                       @"多情应笑我，",
                                                       @"早生华发。",
                                                       @"人生如梦，",
                                                       @"一尊还酹江月。(人生 一作：人间；尊 通：樽)"
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
