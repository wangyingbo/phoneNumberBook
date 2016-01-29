//
//  CheckOutVC.m
//  Kergou
//
//  Created by JiaPin on 15/10/10.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "CheckOutTipsView.h"
#import "SelectPayWayVC.h"
#import "CheckOutView.h"
#import "CheckOutGoodsCell.h"
#import "CheckOutVC.h"

@interface CheckOutVC ()<CheckOutViewDelegate,CheckOutTipsViewDelegate>
{
    UITabBarController *_tabbarcontroller;
}
@property (weak, nonatomic) IBOutlet UIView *addressView;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *addInfoView;
@property (weak, nonatomic) IBOutlet UIImageView *btmLineImgView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong,nonatomic)CheckOutTipsView *tipsView;
@end

@implementation CheckOutVC
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
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self wanShanView];
    [self addLineView];
    [self addBottomView];
    // Do any additional setup after loading the view.
    [self initNavagation];
    if (/* DISABLES CODE */ (1))
    {
        self.addInfoView.hidden = YES;
        

    }
    else
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(AddInfoClick)];
        [self.addInfoView addGestureRecognizer:tap];
    }
    
    self.headerView.frame = CGRectMake(0, 0, IPHONE_WITH, 207/2);
   
    
}
-(void)addBottomView
{
    CheckOutView *bottomVi = [[CheckOutView alloc]initWithFrame:CGRectMake(0, IPHONE_HEIGHT-50, IPHONE_WITH, 50)];
    bottomVi.delegate = self;
    [self.view addSubview:bottomVi];
}
-(void)addLineView
{
    for (int i = 0 ; i<3; i++)
    {
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(9, i*45, IPHONE_WITH, 0.5)];
        lineView.backgroundColor = [UIColor lightGrayColor];
        
        [self.bottomView addSubview:lineView];
    }
}
-(void)wanShanView
{
    self.headerView.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    self.addressView.backgroundColor = UIColorFromOXRGB(0xf8f5e2);
    self.btmLineImgView.image = [UIImage imageNamed:@"dian.png"];
    
    
    
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

-(void)AddInfoClick
{
    self.addInfoView.hidden = YES;
    self.addressView.hidden = NO;
    self.headerView.frame = CGRectMake(0, 0, IPHONE_WITH, 104);
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        return 150;
   
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
        return 3;
   
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    CheckOutGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[CheckOutGoodsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
}
-(void)sendOrderBtnClick
{
    
    _tipsView = [[CheckOutTipsView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, IPHONE_HEIGHT)];
    _tipsView.delegate = self;
    [self.view addSubview:_tipsView];
    
    
    
    
    
}
-(void)gotoCheckOut
{
         SelectPayWayVC  *vc = (SelectPayWayVC *)[PublicMethod getVCByStoryboardID:@"selectPayWaySB" andWithSBName:@"Main"];
        [self.navigationController pushViewController:vc animated:YES];
    [_tipsView removeFromSuperview];
 
}
-(void)backShopCar
{
    [_tipsView removeFromSuperview];
}
-(void)TapClickToCancleView
{
    [_tipsView removeFromSuperview];

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
