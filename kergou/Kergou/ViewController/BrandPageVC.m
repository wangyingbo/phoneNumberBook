//
//  BrandPageVC.m
//  Kergou
//
//  Created by JiaPin on 15/9/23.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "GoodsdetailVC.h"
#import "BrandPageCell.h"
#import "BrandPageVC.h"

@interface BrandPageVC ()<BrandPageCellDelegate>
{
    UITabBarController *_tabBarController;
}
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *headerBtmBgView;

@property (weak, nonatomic) IBOutlet UITableView *tablView;

@end

@implementation BrandPageVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _tabBarController= [PublicMethod getTabBarController];
    _tabBarController.tabBar.hidden = YES;
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    _tabBarController.tabBar.hidden = NO;
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavagation];
    [self wanShanView];
    
}
-(void)wanShanView
{
    self.headerView.frame = CGRectMake(0, 0, IPHONE_WITH, [PublicMethod PictureViewAdaptHeight:256.0f]);
    self.headerView.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    self.tablView.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    [self.headerBtmBgView.layer setBorderWidth:0.5];
    [self.headerBtmBgView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
}
-(void)initNavagation
{
    [self.navigationItem.backBarButtonItem setTitle:@""];
    [self.navigationItem setHidesBackButton:YES];
   

    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"zuojiantou.png"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0,0, 38, 38);
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[[UIImage imageNamed:@"zhuanfa.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0,0, 38, 38);
    [searchBtn addTarget:self action:@selector(carBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchBar = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    
    self.navigationItem.leftBarButtonItem = barBtn;
    self.navigationItem.rightBarButtonItem = searchBar;
}

-(void)backBtnClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)carBtnClick:(UIButton *)sender
{
    
    
    
}
#pragma mark - BrandPageCellDelegate
-(void)gotoGoodsDetailVC
{
    GoodsdetailVC *vc = (GoodsdetailVC *)[PublicMethod getVCByStoryboardID:@"goodsdetailSB" andWithSBName:@"Main"];
    [self.navigationController pushViewController:vc animated:YES];
    
}
#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PublicMethod PictureViewAdaptHeight:264.0f];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IDStr = @"brandCell";
    BrandPageCell *cell = [tableView dequeueReusableCellWithIdentifier:IDStr forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[BrandPageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDStr];
    }
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
