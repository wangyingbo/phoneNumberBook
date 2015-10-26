//
//  AddressManage.m
//  Kergou
//
//  Created by JiaPin on 15/10/12.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "EditGoodsAddressVC.h"
#import "AddressManageCell.h"
#import "AddressManage.h"

@interface AddressManage ()<AddressManageCellDelegate>
{
    UITabBarController *_tabBarController;
}
@property (weak, nonatomic) IBOutlet UIView *addNewAdView;

@end

@implementation AddressManage
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
    [self initNavagation];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addNewADTap:)];
    [self.addNewAdView addGestureRecognizer:tap];
    
    
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

-(void)wanShanView
{
    self.addNewAdView.backgroundColor = UIColorFromOXRGB(0x27e0c6);
}
-(void)addNewADTap:(UITapGestureRecognizer *)tap
{
    EditGoodsAddressVC *vc = (EditGoodsAddressVC *)[PublicMethod getVCByStoryboardID:@"EditAddressSB" andWithSBName:@"Main"];
    vc.statuesStr = @"新建";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)backBtnClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - AddressManageCellDelegate
-(void)editBtnClickToEditAddress
{
    EditGoodsAddressVC *vc = (EditGoodsAddressVC *)[PublicMethod getVCByStoryboardID:@"EditAddressSB" andWithSBName:@"Main"];
    
    vc.statuesStr = @"编辑";
    vc.customerName.text = @"张帅";
    vc.customerPhoneNum.text = @"18736101929";
    vc.coustomerAddress.text = @"八里塔";
    
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Table view data source



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 234/2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static   NSString *cellID = @"addressmanage";
    AddressManageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[AddressManageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    if (indexPath.row == 0)
    {
         cell.backgroundColor = UIColorFromOXRGB(0xfffacd);
    }
    [cell configureViewWithBtnStatuesStr:@"2"];
    cell.delegate = self;
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
