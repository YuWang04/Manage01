//
//  myDataManager.m
//  驾照助手
//
//  Created by xtjsb on 17/12/19.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "myDataManager.h"
#import "FMDatabase.h"
#import "TestSelectMode.h"
#import "AnswerModel.h"
@implementation myDataManager
+(NSArray *)getData:(DataType)type{
    static FMDatabase *dataBase;
    NSMutableArray *array = [[NSMutableArray alloc]init];
    if(dataBase==nil){
        NSString *path = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"sqlite"];
        dataBase = [[FMDatabase alloc]initWithPath:path];
        
    }
    if([dataBase open]){
        NSLog(@"open success");
    }else{
        return array;
    }
    switch (type) {
        case chapter:
        {
            NSString *sql = @"select pid,pname,pcount FROM firstlevel";
            FMResultSet *rs = [dataBase executeQuery:sql];
            while ([rs next]) {
                TestSelectMode *model = [[TestSelectMode alloc]init];
                model.pid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pid"]];
                model.pname = [rs stringForColumn:@"pname"];
                model.pcount = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pcount"]];
                [array addObject:model];
            }
        }
            break;
        case answer:
        {
            NSString *sql = @"select mquestion,mdesc,mid,manswer,mimage,pid,pname,sid,sname,mtype FROM leaflevel";
            FMResultSet *rs = [dataBase executeQuery:sql];
            while ([rs next]) {
                AnswerModel *model = [[AnswerModel alloc]init];
                model.mquestion = [rs stringForColumn:@"mquestion"];
                model.mdesc = [rs stringForColumn:@"mdesc"];
                model.mid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"mid"]];
                model.manswer = [rs stringForColumn:@"manswer"];
                model.mimage = [rs stringForColumn:@"mimage"];
                model.pid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"pid"]];
                model.pname = [rs stringForColumn:@"pname"];
                model.sid = [NSString stringWithFormat:@"%d",[rs intForColumn:@"sid"]];
                model.sname = [rs stringForColumn:@"sname"];
                model.mtype = [NSString stringWithFormat:@"%d",[rs intForColumn:@"mtype"]];
                [array addObject:model];
            }
        }
            break;
        default:
            break;
    }
    return  array;
}
@end
