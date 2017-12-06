//
//  AddController.h
//  通讯录
//
//  Created by xtjsb on 17/12/1.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddController,JKConModel;
@protocol AddControllerDelegate <NSObject>

@optional
-(void)addContact:(AddController *)addVc didAddContact:(JKConModel *)contact;

@end
@interface AddController : UIViewController
@property(nonatomic,assign)id<AddControllerDelegate> delegate;
@end
