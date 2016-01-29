//
//  TansportInfoVC.m
//  Kergou
//
//  Created by JiaPin on 15/9/29.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "TransportView.h"
#import "GoodInfoPublicCell.h"
#import "TansportInfoVC.h"

@interface TansportInfoVC ()
{
    UITabBarController *_tabBarController;
}
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIImageView *headerBtmView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation TansportInfoVC
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
    [self wanShanView];
    [self initFooterView];
    [self initNavagation];
}
-(void)wanShanView
{
    self.headerView.backgroundColor = UIColorFromOXRGB(0x27e0c6);
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

-(void)initFooterView
{
    NSArray *transportinfoTextArr = @[@"订单已完成",@"您的包裹已发货，正在发往北京",@"订单已提交，等待确认"];
    [self.tableView registerClass:[GoodInfoPublicCell class] forCellReuseIdentifier:@"GoodInfoCell"];
    
    TransportView *transportInfoLineView = [[TransportView alloc]initWithFrame:CGRectMake(0,0,IPHONE_WITH, 200)andWithArr:transportinfoTextArr];
    
    
    [self.footerView addSubview:transportInfoLineView];

    
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, 45)];
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(13, 14, 60, 20)];
    lab.text = @"商品信息";
    lab.font = [UIFont fontWithName:@"Helvetica-BoldOblique" size:15];
   
    [vi addSubview:lab];
    
    return vi;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IDStr = @"GoodInfoCell";
    GoodInfoPublicCell *cell = [tableView dequeueReusableCellWithIdentifier:IDStr forIndexPath:indexPath];
    
    if (!cell)
    {
        cell = [[GoodInfoPublicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDStr];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
    
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
