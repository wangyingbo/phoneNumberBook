//
//  ViewController.m
//  电话本demo
//
//  Created by 王迎博 on 16/1/29.
//  Copyright © 2016年 王迎博. All rights reserved.
//

#import "ViewController.h"
#import "NSString+PinYin.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong) NSMutableArray * dataArr;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)loadView
{
    [super loadView];
    [self initData];
    [self creatTableView];
}

- (void)initData
{
    _dataArr = [[NSMutableArray alloc]init];
    NSArray *dataArr = @[@"阿黄",@"大哥",@"黄一",@"何二",@"光三",@"笨熊",@"孔老二",@"龙傲天",@"妹纸",@"宁六",@"奇七",@"宝贝",@"沙宝亮",@"特么",@"吴囧",@"徐八",@"一范",@"张三",@"赵六",@"阿黄",@"大哥",@"黄一",@"何二",@"光三",@"笨熊",@"孔老二",@"龙傲天",@"妹纸",@"宁六",@"奇七",@"宝贝",@"沙宝亮",@"特么",@"吴囧",@"徐八",@"一范",@"张三",@"赵六"];
    
    for (char i = 'A'; i <= 'Z'; i++)
    {
        NSString * str = [NSString stringWithFormat:@"%c",i];
        NSMutableArray *carMuArr = [[NSMutableArray alloc]init];
        
        for (NSString *name in dataArr)
        {
            if ([[name getFirstLetter] isEqualToString:str])
            {
                [carMuArr addObject:name];
            }
        }
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
        [dic setObject:str forKey:@"Title"];
        [dic setObject:carMuArr forKey:@"Arr"];
        
        [_dataArr addObject:dic];
    }

}


- (void)creatTableView
{
    _tableView = ({
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 20) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView;
    });
    [self.view addSubview:_tableView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary * dic = _dataArr[section];
    NSArray * arr = dic[@"Arr"];
    return arr.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"myCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        NSDictionary *dic = _dataArr[indexPath.section];
        NSArray *arr = dic[@"Arr"];
        cell.textLabel.text = arr[indexPath.row];
    }
     return cell;
}

//设置组名
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSDictionary * dic = _dataArr[section];
    return dic[@"Title"];
}

//设置索引名
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    
    tableView.sectionIndexColor = [UIColor blackColor];
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in _dataArr)
    {
        [arr addObject:dic[@"Title"]];
    }
    return arr;
}



@end
