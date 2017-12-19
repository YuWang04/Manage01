//
//  AnswerScrollView.h
//  驾照助手
//
//  Created by xtjsb on 17/12/19.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnswerScrollView : UIView
-(instancetype)initWithFrame:(CGRect)frame withDataArray:(NSArray *)array;
@property(nonatomic,assign,readonly)int currentPage;
@end
