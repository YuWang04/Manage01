//
//  Tool.m
//  驾照助手
//
//  Created by xtjsb on 17/12/19.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "Tool.h"

@implementation Tool
+(NSArray *)getAnswerWithString:(NSString *)str{
    NSMutableArray *array = [[NSMutableArray alloc]init];
    NSArray *arr = [str componentsSeparatedByString:@"<BR>"];
    [array addObject:arr[0]];
    for (int i = 0; i < 4; i++) {
        [array addObject:[arr[i+1] substringFromIndex:2]];
    }
    return array;
}
@end
