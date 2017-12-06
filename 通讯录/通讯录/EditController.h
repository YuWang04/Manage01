//
//  EditController.h
//  通讯录
//
//  Created by xtjsb on 17/12/1.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JKConModel,EditController;
@protocol EditControllerDelegate <NSObject>

@optional
-(void)editViewController:(EditController*)editVc didSaveContact:(JKConModel*)model;

@end
@interface EditController : UIViewController
@property(nonatomic,strong)JKConModel *model;
@property(nonatomic,assign)id<EditControllerDelegate> delegate;
@end
