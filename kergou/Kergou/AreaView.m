//
//  AreaView.m
//  Kergou
//
//  Created by JiaPin on 15/10/9.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "AreaView.h"

#define PROVINCE_COMPONENT  0
#define CITY_COMPONENT      1
#define DISTRICT_COMPONENT  2

@interface AreaView()<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSString *selectedProvinceStr;
}
@property (strong,nonatomic) NSDictionary *areaDic;
@property (strong,nonatomic) NSArray      *provinceArr;
@property (strong,nonatomic) NSArray      *cityArr;
@property (strong,nonatomic) NSArray      *districtArr;
@property (strong,nonatomic) UIPickerView *picker;
@end
@implementation AreaView
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        [self initAreaView];
        
    }
    return self;
}
-(void)initAreaView
{
   
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *plistPath = [bundle pathForResource:@"area" ofType:@"plist"];
    self.areaDic = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    
    
    NSArray *components = [_areaDic allKeys];
    NSArray *sortedArray = [components sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        if ([obj1 integerValue]>[obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedDescending;
        }
        if ([obj1 integerValue]<[obj2 integerValue])
        {
            return (NSComparisonResult)NSOrderedAscending;
        }
        return (NSComparisonResult)NSOrderedSame;
        
    }];
    
    NSMutableArray *provinceTmp = [[NSMutableArray alloc]init];
    for (int i = 0; i<[sortedArray count]; i++)
    {
        NSString *index = [sortedArray objectAtIndex:i];
        NSArray *tmp = [[_areaDic objectForKey:index] allKeys];
        [provinceTmp addObject:[tmp objectAtIndex:0]];
    }
    self.provinceArr = [[NSArray alloc]initWithArray:provinceTmp];
    
    
    NSString *index = [sortedArray objectAtIndex:0];
    NSString *selected = [_provinceArr objectAtIndex:0];
    
    NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[[_areaDic objectForKey:index]objectForKey:selected]];
    
    NSArray *cityArray = [dic allKeys];
    NSDictionary *citydic = [NSDictionary dictionaryWithDictionary:[dic objectForKey:[cityArray objectAtIndex:0]]];
    self.cityArr = [[NSArray alloc]initWithArray:[citydic allKeys]];
    
    NSString *selectedCity = [_cityArr objectAtIndex:0];
    
    self.districtArr = [[NSArray alloc]initWithArray:[citydic objectForKey:selectedCity]];
    
    [self initPickerView];
    
    
    
    
    
    
    
}

-(void)initPickerView
{
    
    self.picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0,45, IPHONE_WITH, 200)];
    self.picker.dataSource = self;
    self.picker.delegate = self;
    self.picker.showsSelectionIndicator = YES;
    [self.picker selectRow:0 inComponent:0 animated:YES];
    [self addSubview:_picker];
    
    selectedProvinceStr = [_provinceArr objectAtIndex:0];
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0,0, IPHONE_WITH,45)];
    topView.backgroundColor = UIColorFromOXRGB(0xf1f1f1);
    
    UIButton *cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cancleBtn.frame = CGRectMake(41, 12, 40, 20);
    [cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(cancleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *okBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    okBtn.frame = CGRectMake(IPHONE_WITH-81, 12, 40, 20);
    [okBtn setTitle:@"确定" forState:UIControlStateNormal];
    [okBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [okBtn addTarget:self action:@selector(okBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    

    
    [topView addSubview:okBtn];
    [topView addSubview:cancleBtn];
    [self addSubview:topView];
    
    
    
}

-(void)cancleBtnClick:(UIButton *)sender
{
    
    if (_delegate&&[_delegate respondsToSelector:@selector(areaCancleBtnClick)]) {
        [self.delegate areaCancleBtnClick];
    }

    
}
-(void)okBtnClick:(UIButton *)sender
{
    NSInteger  provinceIndex = [_picker selectedRowInComponent:PROVINCE_COMPONENT];
    NSInteger  cityIndex = [_picker selectedRowInComponent:CITY_COMPONENT];
    NSInteger  districIndex = [_picker selectedRowInComponent:DISTRICT_COMPONENT];
    
    NSString *provinceStr = [_provinceArr objectAtIndex:provinceIndex];
    NSString *cityStr = [_cityArr objectAtIndex:cityIndex];
    NSString *districtStr = [_districtArr objectAtIndex:districIndex];
    
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:provinceStr,@"province",cityStr,@"city",districtStr,@"district", nil];
    AreaModel *model = [[AreaModel alloc]initWithDictionary:dic];
    
    if (_delegate&&[_delegate respondsToSelector:@selector(okBtnClickWithChoseArea:)]) {
        [self.delegate okBtnClickWithChoseArea:model];
    }
    
}

#pragma mark - PickerDataSource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT)
    {
        return [_provinceArr count];
        
    }
    else if (component ==CITY_COMPONENT)
    {
        return [_cityArr count];
    }
    else
    {
        return [_districtArr count];
    }


}
#pragma mark- Picker Delegate Methods
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return [_provinceArr objectAtIndex:row];
    }
    else if (component ==CITY_COMPONENT)
    {
        return [_cityArr objectAtIndex:row];
    }
    else
    {
        return [_districtArr objectAtIndex:row];
    }

    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT)
    {
        selectedProvinceStr = [_provinceArr objectAtIndex:row];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary:[_areaDic objectForKey:[NSString stringWithFormat:@"%d",row]]];
        
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary:[tmp objectForKey:selectedProvinceStr]];
        
        NSArray *cityArray = [dic allKeys];
        NSArray *sortedArray = [cityArray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;//递减
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;//上升
            }
            return (NSComparisonResult)NSOrderedSame;

        }];

        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (int i=0; i<[sortedArray count]; i++)
        {
            NSString *index = [sortedArray objectAtIndex:i];
            NSArray *temp = [[dic objectForKey: index] allKeys];
            [array addObject: [temp objectAtIndex:0]];
        }
        self.cityArr = [[NSArray alloc] initWithArray: array];
     
        
     
        NSDictionary *cityDic = [dic objectForKey: [sortedArray objectAtIndex: 0]];
        self.districtArr = [[NSArray alloc] initWithArray: [cityDic objectForKey: [_cityArr objectAtIndex: 0]]];
        [_picker reloadComponent: CITY_COMPONENT];
        [_picker reloadComponent: DISTRICT_COMPONENT];
        
    }
    
    else if (component == CITY_COMPONENT)
    {
        NSString *provinceIndex = [NSString stringWithFormat: @"%d", [_provinceArr indexOfObject: selectedProvinceStr]];
        NSDictionary *tmp = [NSDictionary dictionaryWithDictionary: [_areaDic objectForKey: provinceIndex]];
        NSDictionary *dic = [NSDictionary dictionaryWithDictionary: [tmp objectForKey: selectedProvinceStr]];
        NSArray *dicKeyArray = [dic allKeys];
        NSArray *sortedArray = [dicKeyArray sortedArrayUsingComparator: ^(id obj1, id obj2) {
            
            if ([obj1 integerValue] > [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedDescending;
            }
            
            if ([obj1 integerValue] < [obj2 integerValue]) {
                return (NSComparisonResult)NSOrderedAscending;
            }
            return (NSComparisonResult)NSOrderedSame;
        }];
        
        NSDictionary *cityDic = [NSDictionary dictionaryWithDictionary: [dic objectForKey: [sortedArray objectAtIndex: row]]];
        NSArray *cityKeyArray = [cityDic allKeys];
        
   
        self.districtArr = [[NSArray alloc] initWithArray: [cityDic objectForKey: [cityKeyArray objectAtIndex:0]]];
        [_picker reloadComponent: DISTRICT_COMPONENT];

    }
    
    
}
-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (component == PROVINCE_COMPONENT) {
        return 80;
    }
    else if (component == CITY_COMPONENT) {
        return 100;
    }
    else {
        return 115;
    }
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *myView = nil;
    
    if (component == PROVINCE_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 78, 30)] ;
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [_provinceArr objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else if (component == CITY_COMPONENT) {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 95, 30)];
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [_cityArr objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    else {
        myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 110, 30)] ;
        myView.textAlignment = NSTextAlignmentCenter;
        myView.text = [_districtArr objectAtIndex:row];
        myView.font = [UIFont systemFontOfSize:14];
        myView.backgroundColor = [UIColor clearColor];
    }
    
    return myView;
}


@end
