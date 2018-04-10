//
//  SXTCategate.m
//  MyApp
//
//  Created by xtjsb on 2018/4/2.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "SXTCategate.h"

@implementation SXTCategate
+(NSArray *)loadData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"categories.plist" ofType:nil];
    NSArray *dataArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *categorList = [NSMutableArray array];
    for(NSDictionary *dict in dataArray){
        SXTCategate *cate = [[SXTCategate alloc]init];
        //字典的快速赋值
        [cate setValuesForKeysWithDictionary:dict];
        [categorList addObject:cate];
        
    }
    return categorList;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
@end
