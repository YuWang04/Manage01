//
//  HMSettingCell.m
//  07-彩票-基本框架
//
//  Created by Romeo on 15/12/16.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMSettingCell.h"

@implementation HMSettingCell

+ (instancetype)settingCellWithTableView:(UITableView*)tableView andItem:(NSDictionary*)item
{

    static NSString* cellid = @"setting_cell";

    // 缓存池找
    HMSettingCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[HMSettingCell alloc] initWithStyle:[self loadCellStyleWithItem:item] reuseIdentifier:cellid];
    }
    
    cell.item = item;

    return cell;
}

- (void)setItem:(NSDictionary*)item
{
    _item = item;

    // 把数据放到 cell 上

    // 赋值
    if (item[@"icon"] && [item[@"icon"] length] > 0) {
        self.imageView.image = [UIImage imageNamed:item[@"icon"]]; // ---设置图片
    }

    self.textLabel.text = item[@"title"]; // ---设置标题

    self.detailTextLabel.text = item[@"subTitle"]; // ---设置子标题

    // 根据字符创生成对象======
    NSString* accessoryType = item[@"accessoryType"]; // 获取到 UISwith的字符串   @"UISwitch"
    Class Clz = NSClassFromString(accessoryType); // 获取 UISwitch的类型 UISwitch
    UIView* obj = [[Clz alloc] init]; // 获取 UISwitch类型的对象

    // 判断 obj 真实的类型
    if ([obj isKindOfClass:[UIImageView class]]) {
        // 设置 frame,图片
        UIImageView* imageView = (UIImageView*)obj;
        imageView.image = [UIImage imageNamed:item[@"accessoryContent"]];
        [imageView sizeToFit];
    }

    self.accessoryView = obj; // ---设置accessoryView
}

// 根据传入的 cell 的类型 返回需要创建的 cell 的类型
+ (UITableViewCellStyle)loadCellStyleWithItem:(NSDictionary*)item
{

    if ([item[@"cellType"] isEqualToString:@"UITableViewCellStyleSubtitle"]) {
        return UITableViewCellStyleSubtitle;
    }
    else if ([item[@"cellType"] isEqualToString:@"UITableViewCellStyleValue1"]) {
        return UITableViewCellStyleValue1;
    }
    else if ([item[@"cellType"] isEqualToString:@"UITableViewCellStyleValue2"]) {
        return UITableViewCellStyleValue2;
    }
    else {
        return UITableViewCellStyleDefault;
    }
}

@end
