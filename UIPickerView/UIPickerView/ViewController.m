//
//  ViewController.m
//  UIPickerView
//
//  Created by xtjsb on 2018/3/19.
//  Copyright © 2018年 xgf. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, strong) NSDictionary *sourceDict;
@property (nonatomic, strong) NSString *rowTitleFirst;
@property (nonatomic, strong) NSString *rowTitleSecond;
@property (nonatomic, strong) NSString *rowTitleThird;

@property (nonatomic, strong) UITextField *textfield;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIPickerView *pickerView = [[UIPickerView alloc] init];
    pickerView.backgroundColor = [UIColor orangeColor];
    
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self setdata];
    self.rowTitleFirst = @"广东省";
    self.rowTitleSecond = @"深圳市";
    [pickerView selectRow:0 inComponent:0 animated:NO];
    [pickerView selectRow:0 inComponent:1 animated:NO];
    [pickerView selectRow:3 inComponent:2 animated:NO];
    [pickerView reloadAllComponents];
    
    // 通过textfield来使用
    self.textfield = [[UITextField alloc] initWithFrame:CGRectMake(10.0, 50.0, (CGRectGetWidth(self.view.bounds) - 10.0 * 2), 40.0)];
    [self.view addSubview:self.textfield];
    self.textfield.backgroundColor = [UIColor yellowColor];
    self.textfield.textColor = [UIColor redColor];
    self.textfield.placeholder = @"请选择地址（省市区）";
    // 添加键盘上方的子视图
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.bounds), 40.0);
    button.backgroundColor = [UIColor greenColor];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button setTitle:@"隐藏键盘" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(hiddenKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    self.textfield.inputAccessoryView = button;
    //输入源改成地址选择视图
    self.textfield.inputView = pickerView;
}
- (void)setdata{
    NSArray *meizhouArray = @[@"梅县", @"五华县", @"丰顺县", @"大埔县", @"蕉岭县", @"兴宁市", @"梅江区"];
    NSArray *guangzhouArray = @[@"天河区", @"白云区", @"荔湾区", @"番禺区", @"海珠区", @"花都区", @"从化区", @"增城区"];
    NSArray *shenzhenArray = @[@"龙华新区", @"大鹏新区", @"福田区", @"罗湖区", @"宝安区", @"龙岗区", @"南山区"];
    NSDictionary *guangdongCityDict = [NSDictionary dictionaryWithObjectsAndKeys:shenzhenArray, @"深圳市", guangzhouArray, @"广州市", meizhouArray, @"梅州市", nil ];
    NSDictionary *guangxiCityDict = [NSDictionary dictionaryWithObjectsAndKeys:@[], @"柳州市", @[], @"桂林市", nil ];
    self.sourceDict = [NSDictionary dictionaryWithObjectsAndKeys:guangdongCityDict, @"广东省", guangxiCityDict, @"广西省", nil];
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return 100;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (component == 0) {
        NSArray *keyArray = self.sourceDict.allKeys;
        NSString *title = keyArray[row];
        return title;
    }else
    if (component == 1) {
        NSDictionary *cityDict = self.sourceDict[self.rowTitleFirst];
        NSArray *cityArray = cityDict.allKeys;
        NSString *title = cityArray[row];
        return title;
    }else
    if (component == 2) {
        NSDictionary *cityDict = self.sourceDict[self.rowTitleFirst];
        NSArray *cityArray = cityDict[self.rowTitleSecond];
        NSString *title = cityArray[row];
        return title;
    }
    return nil;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    // 设置每列的实际行数
    NSArray *keyArray = self.sourceDict.allKeys;
    if (0 == component)
    {
        return keyArray.count;
    }
    else if (1 ==component)
    {
        NSDictionary *cityDict = self.sourceDict[self.rowTitleFirst];
        NSArray *cityArray = cityDict.allKeys;
        return cityArray.count;
    }
    else if (2 == component)
    {
        NSDictionary *areaDict = self.sourceDict[self.rowTitleFirst];
        NSArray *areaArray = areaDict[self.rowTitleSecond];
        return areaArray.count;
    }
    
    return 0;
}
- (void)hiddenKeyboard:(UIButton *)button
{
    [self.view endEditing:YES];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSArray *keyArray = self.sourceDict.allKeys;
    if (component == 0) {
        NSString *keyFirst = keyArray[row];
        self.rowTitleFirst = keyFirst;
        // 当第一列改变时，第二列的值应该跟着改变，即key2，设置为默认第二列的第一个值
        NSDictionary *cityDict = self.sourceDict[self.rowTitleFirst];
        NSArray *cityArray = cityDict.allKeys;
        if (cityArray && cityArray.count > 0) {
            NSString *keySecond = cityArray[0];
            self.rowTitleSecond = keySecond;
        }
        // 设置第三个标题，当第二列改变时，第三wfhr值路着改变
        NSArray *areaArray = cityDict[self.rowTitleSecond];
        if (areaArray && areaArray.count > 0) {
            NSString *keyThird = areaArray[0];
            self.rowTitleThird = keyThird;
        }
        else{
            self.rowTitleThird = nil;
        }
        // 重新刷新第2列的数据，且设置显示为第一行
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        // 重新刷新第3列的数据，且设置显示为第一行
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    else if (component == 1){
        NSDictionary *cityDict = self.sourceDict[self.rowTitleFirst];
        NSArray *cityArray = cityDict.allKeys;
        NSString *keySecond = cityArray[row];
        self.rowTitleSecond = keySecond;
        // 设置第三个标题，默认第一行
        NSArray *areaArray = cityDict[self.rowTitleSecond];
        if (areaArray && areaArray.count > 0) {
            NSString *keyThird = areaArray[0];
            self.rowTitleThird = keyThird;
        }
        // 重新刷新第3列的数据，且设置显示为第一行
        [pickerView reloadComponent:2];
        [pickerView selectRow:0 inComponent:2 animated:YES];
    }
    else if (component == 2){
        NSDictionary *cityDict = self.sourceDict[self.rowTitleFirst];
        NSArray *areaArray = cityDict[self.rowTitleSecond];
        if (areaArray && areaArray > 0) {
            NSString *keyThird = areaArray[row];
            self.rowTitleThird = keyThird;
        }
    }
    NSString *text = [NSString stringWithFormat:@"%@%@%@",self.rowTitleFirst,self.rowTitleSecond,self.rowTitleThird];
    self.textfield.text = text;
}
@end
