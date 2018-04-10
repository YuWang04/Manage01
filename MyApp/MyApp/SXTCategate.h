//
//  SXTCategate.h
//  MyApp
//
//  Created by xtjsb on 2018/4/2.
//  Copyright © 2018年 wy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXTCategate : NSObject
@property(nonatomic,copy)NSString *name;
@property(nonatomic,strong)NSArray *subcategories;
@property(nonatomic,copy)NSString *age;

+(NSArray *)loadData;
-(void)setValue:(id)value forUndefinedKey:(NSString *)key;
@end
