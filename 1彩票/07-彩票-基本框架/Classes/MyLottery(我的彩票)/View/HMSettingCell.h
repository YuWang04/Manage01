//
//  HMSettingCell.h
//  07-彩票-基本框架
//
//  Created by Romeo on 15/12/16.
//  Copyright © 2015年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HMSettingCell : UITableViewCell

@property (nonatomic, strong) NSDictionary* item;

+ (instancetype)settingCellWithTableView:(UITableView*)tableView andItem:(NSDictionary*)item;

@end
