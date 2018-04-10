//
//  CalendarVC.m
//  MyApp
//
//  Created by xtjsb on 2018/4/10.
//  Copyright © 2018年 wy. All rights reserved.
//

#import "CalendarVC.h"
#import "CalendarView.h"
#import "PrefixHeader.h"
@interface CalendarVC ()
@property(nonatomic,strong)CalendarView *calendar;
@end

@implementation CalendarVC
- (CalendarView *)calendar {
    if (!_calendar) {
        
        _calendar = [[CalendarView alloc] initWithFrame:CGRectMake(10, 80, ScreenWidth - 20, 300)];
        
    }
    return _calendar;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _calendar = [[CalendarView alloc] initWithFrame:CGRectMake(10, 80, ScreenWidth - 20, 300)];
    [self.view addSubview:_calendar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
