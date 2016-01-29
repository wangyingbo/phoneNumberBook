//
//  OderDetailVC.m
//  Kergou
//
//  Created by JiaPin on 15/9/28.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "CheckOutVC.h"
#import "TansportInfoVC.h"
#import "OderDetailBtmView.h"
#import "OderDetailView.h"
#import "GoodInfoPublicCell.h"
#import "OderDetailVC.h"

@interface OderDetailVC ()<OderDetailBtmViewDelegate>
{
    UITabBarController *_tabBarController;
}
@property (weak, nonatomic) IBOutlet UIImageView *headerBtmImgView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLab;
@property (weak, nonatomic) IBOutlet UILabel *fareLab;
@property (weak, nonatomic) IBOutlet UILabel *favourableLab;
@property (weak, nonatomic) IBOutlet UILabel *actualLab;

@end

@implementation OderDetailVC
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
    
   
    
    [self.tableView registerClass:[GoodInfoPublicCell class] forCellReuseIdentifier:@"GoodInfoCell"];
    [self wanShanView];
    [self initNavagation];
    
   
    
   
    
}
-(void)wanShanView
{
    if (_stateNum != 20001)
    {
        self.headerView.frame = CGRectZero;
    }
    else
    {
        self.headerView.frame = CGRectMake(0, 0, IPHONE_WITH, 46);
        self.headerView.backgroundColor = UIColorFromOXRGB(0x27e0c6);
        
    }
    OderDetailBtmView *btmView = [[OderDetailBtmView alloc]initWithFrame:CGRectMake(0, IPHONE_HEIGHT-66, IPHONE_WITH, 66) withStateNum:_stateNum];
    btmView.delegate = self;
    [self.view addSubview:btmView];
    
    
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
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    OderDetailView *vi = [[OderDetailView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, 216)];
  
    return vi;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 115;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 216;
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
#pragma mark - OderDetailBtmViewDelegate
-(void)checkTransportInfoBtnClick
{
     TansportInfoVC *vc = (TansportInfoVC *) [PublicMethod getVCByStoryboardID:@"transportSB" andWithSBName:@"Main"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)oneMoreTimeBuy
{
    CheckOutVC *vi = (CheckOutVC *)[PublicMethod getVCByStoryboardID:@"CheckOutSB" andWithSBName:@"Main"];
    [self.navigationController pushViewController:vi animated:YES];
}
-(void)backBtnClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
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
