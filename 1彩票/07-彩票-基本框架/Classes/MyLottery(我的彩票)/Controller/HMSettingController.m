//
//  HMSettingController.m
//  07-彩票-基本框架
//
//  Created by Romeo on 15/12/16.
//  Copyright © 2015年 heima. All rights reserved.
//

#import "HMSettingController.h"
#import "HMRedeemController.h"
#import "HMSettingCell.h"

@interface HMSettingController ()

@property (nonatomic, strong) NSArray* groups;

@end

@implementation HMSettingController

- (instancetype)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (NSArray*)groups
{
    if (!_groups) {
        // 获取路径
        NSString* path = [[NSBundle mainBundle] pathForResource:self.plistName ofType:@"plist"];

        // 解析成数组
        _groups = [NSArray arrayWithContentsOfFile:path];
    }
    return _groups;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 创建返回按钮
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"NavBack"] style:UIBarButtonItemStylePlain target:self action:@selector(backClick)];

    // 设置 leftbaritem
    self.navigationItem.leftBarButtonItem = item;

    // ------------
}

// 点击 cell 调用
- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{

    // 获取组
    NSDictionary* group = self.groups[indexPath.section];
    // 获取所有的 cell
    NSArray* items = group[@"items"];
    // 获取当前的 cell 信息
    NSDictionary* item = items[indexPath.row];

    if (item[@"targetVC"] && [item[@"targetVC"] length] > 0) {
        NSString* targetVC = item[@"targetVC"]; // @"HMRedeemController"
        Class Clz = NSClassFromString(targetVC); // HMRedeemController
        UIViewController* vc = [[Clz alloc] init]; // HMRedeemController类型的对象

        if ([vc isKindOfClass:[HMSettingController class]]) {
            // 如果 setting 类型的 需要传入一个 plistname
            HMSettingController* setting = (HMSettingController*)vc;
            setting.plistName = item[@"plistName"];
        }

        vc.navigationItem.title = item[@"title"]; // 设置 title

        // 跳转
        [self.navigationController pushViewController:vc animated:YES];
    }
}

// 有多杀组
- (NSInteger)numberOfSectionsInTableView:(UITableView*)tableView
{
    return self.groups.count;
}

// 某一组有多少行
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section
{
    // 获取组
    NSDictionary* group = self.groups[section];
    // 获取当前组 所有的 cell 信息
    NSArray* items = group[@"items"];
    return items.count;
}

// cell长什么样
- (UITableViewCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(NSIndexPath*)indexPath
{
    // 获取当前 cell 的信息 ----
    // 1.获取组
    NSDictionary* group = self.groups[indexPath.section];
    // 2.获取当前组的所有的 cell 信息
    NSArray* items = group[@"items"];
    // 3.当前 cell 的信息
    NSDictionary* item = items[indexPath.row];

    // 创建cell
    HMSettingCell* cell = [HMSettingCell settingCellWithTableView:tableView andItem:item];

    // 把数据传给 cell
//    cell.item = item;

    return cell;
}

// header 信息
- (NSString*)tableView:(UITableView*)tableView titleForHeaderInSection:(NSInteger)section
{
    // 获取需要展示 header 的组
    NSDictionary* group = self.groups[section];

    return group[@"header"];
}

// footer 信息
- (NSString*)tableView:(UITableView*)tableView titleForFooterInSection:(NSInteger)section
{
    // 获取需要展示 header 的组
    NSDictionary* group = self.groups[section];

    return group[@"footer"];
}

- (void)backClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
