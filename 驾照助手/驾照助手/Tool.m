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
        //返回一个字符串，这个字符串截取接受对象字符串范围是给定索引index到这个字符串的结尾
        [array addObject:[arr[i+1] substringFromIndex:2]];
    }
    return array;
}

+(CGSize)getSizeWithString:(NSString *)str With:(UIFont *)font WithSize:(CGSize)size{
    CGSize newSize = [str sizeWithFont:font constrainedToSize:size];
    return newSize;
}
@end
