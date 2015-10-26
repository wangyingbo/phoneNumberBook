//
//  SelectPayWayVC.m
//  Kergou
//
//  Created by JiaPin on 15/10/10.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "SelectPayWayCell.h"
#import "SelectPayWayVC.h"

@interface SelectPayWayVC ()
{
    UITabBarController *_tabbarcontroller;
    NSArray *_payWayLabArr;
    NSArray *_paywayImgArr;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leading;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bottomLineView;

@end

@implementation SelectPayWayVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _tabbarcontroller = [PublicMethod getTabBarController];
    _tabbarcontroller.tabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _tabbarcontroller.tabBar.hidden = NO;
    
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavagation];
    [self wanShanView];
    _payWayLabArr = @[@"支付宝支付",@"微信支付（暂缓开通）"];
    _paywayImgArr = @[@"zhi.png",@"weibo.png"];
    
    
}
-(void)wanShanView
{
    self.leading.constant = [PublicMethod PictureViewAdaptHeight:148];
    self.headerView.backgroundColor = UIColorFromOXRGB(0xf8f5e2);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    UIView *lineView = [PublicMethod getLineViewWithFrame:CGRectMake(0, 11.0, IPHONE_WITH, 0.5)];
    self.bottomLineView.backgroundColor = [UIColor whiteColor];
    [self.bottomLineView addSubview:lineView];
    
    
    
}
-(void)initNavagation
{
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationItem.backBarButtonItem setTitle:@""];
    [self.navigationItem setHidesBackButton:YES];
    
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 42;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, 32)];
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(9, 10,100, 15)];
    lab.text = @"支付方式:";
    lab.font = [UIFont fontWithName:nil size:14];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 31.5, IPHONE_WITH, 0.5)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [vi addSubview:lineView];
    
    [vi addSubview:lab];
    
    return vi;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"selectPayWay";
    SelectPayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[SelectPayWayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.payWayImgView.image = [UIImage imageNamed:_paywayImgArr[indexPath.row]];
    cell.payWayLab.text = _payWayLabArr[indexPath.row];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
