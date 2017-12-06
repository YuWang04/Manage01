//
//  JKConModel.m
//  通讯录
//
//  Created by xtjsb on 17/12/1.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import "JKConModel.h"

@implementation JKConModel
//将某个对象写入文件时调用
//在这个方法中要说明哪个属性需要存储
-(void)encodeWithCoder:(NSCoder*)encoder{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.phone forKey:@"phone"];
}
//解析对象的时候调用
//需要解析哪些属性
-(id)initWithCoder:(NSCoder*)dencoder{
    if([super init]){
        self.name = [dencoder decodeObjectForKey:@"name"];
        self.phone = [dencoder decodeObjectForKey:@"phone"];
    }
    return self;
}
@end
