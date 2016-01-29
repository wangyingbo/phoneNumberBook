//
//  YBAftersalesVC.m
//  Kergou
//
//  Created by 王迎博 on 15/10/9.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBAftersalesVC.h"
#import "AFHTTPRequestOperationManager.h"
#import "YBAfterSalesModel.h"
#import "YBAftersalesCellVC.h"
#import "NSMutableDictionary+defaultDic.h"


@interface YBAftersalesVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)NSArray *cellModel;
@property (weak, nonatomic) IBOutlet UITableView *tableVIew;

@end

@implementation YBAftersalesVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self loadData];
    //测试数据
    self.cellModel = @[@[@"test"], @[@"test", @"test"], @[@"test", @"test"], @[@"test"], @[@"test"], @[@"test"]];
}





//- (void)loadData
//{
//    NSMutableDictionary *parameter = [NSMutableDictionary defaultDicWithAdr:@"catType"];
//    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
//    [manager POST:kBaseURL parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        JPLog(@"%@",responseObject);
//        
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        JPLog(@"%@",operation.responseString);
//    }];
//}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellModel.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.cellModel[section] count];
}


//cell的高度
- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 160.0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //去掉底部多余的表格线。
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    static NSString *CellIdentifier = @"cell";
    YBAftersalesCellVC *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[YBAftersalesCellVC alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
    //cell被选中时的颜色。
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    return cell;
}



/*
 
***********自定义section之间的间距***********
或者在storyboard里把tableview的Style属性由Plain改为Groups
//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 1;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
//section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
*/

@end
