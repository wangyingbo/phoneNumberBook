//
//  SelectVC.m
//  Kergou
//
//  Created by JiaPin on 15/9/29.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "SelectCell.h"
#import "SelectVC.h"

@interface SelectVC ()
{
    UITabBarController *_tabBarController;
}
@property (strong,nonatomic)           NSMutableArray *dataArr;
@end

@implementation SelectVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _tabBarController = [PublicMethod getTabBarController];
    _tabBarController.tabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _tabBarController.tabBar.hidden = NO;
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc]initWithObjects:@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1", nil];
     [self initNavagation];
}
-(void)initNavagation
{
    [self.navigationItem.backBarButtonItem setTitle:@""];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.backgroundColor = UIColorFromOXRGB(0xf1f1f1);
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"zuojiantou.png"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0,0, 38, 38);
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = barBtn;
    
    
}
-(void)backBtnClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return _dataArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IDStr = @"SelectID";
    SelectCell *cell = [tableView dequeueReusableCellWithIdentifier:IDStr forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[SelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDStr];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"取消收藏";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
      [_dataArr removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
    }
    
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}




@end
