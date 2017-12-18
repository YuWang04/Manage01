//
//  AppDelegate.h
//  驾照助手
//
//  Created by xtjsb on 17/12/18.
//  Copyright © 2017年 xgf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

