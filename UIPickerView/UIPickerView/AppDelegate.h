//
//  AppDelegate.h
//  UIPickerView
//
//  Created by xtjsb on 2018/3/19.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

