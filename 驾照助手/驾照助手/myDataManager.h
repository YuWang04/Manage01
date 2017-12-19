//
//  myDataManager.h
//  驾照助手
//
//  Created by xtjsb on 17/12/19.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    chapter,//章节练习
    answer,//答题数据
}DataType;
@interface myDataManager : NSObject
+(NSArray *)getData:(DataType)type;
@end
