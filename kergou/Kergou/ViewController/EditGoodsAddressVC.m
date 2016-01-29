//
//  EditGoodsAddressVC.m
//  Kergou
//
//  Created by JiaPin on 15/10/12.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "AreaView.h"
#import "EditGoodsAddressVC.h"

@interface EditGoodsAddressVC ()<AreaViewDelegate>
{
    UITabBarController *_tabBarController;
    BOOL _isFirstClick;
}
@property (nonatomic,strong)     AreaView *areaView;
@end

@implementation EditGoodsAddressVC
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

    _isFirstClick = YES;
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    [self initNavagation];
    [self wanShanView];
    
}
-(void)wanShanView
{
    if ([_statuesStr isEqualToString:@"新建"])
    {
        self.navigationItem.title = @"新建收货地址";
        
        
        self.customerName.text = @"";
        self.customerPhoneNum.text = @"";
      
        self.coustomerAddress.text = @"";
   
        
        self.customerName.placeholder = @"姓名";
        self.customerPhoneNum.placeholder = @"请输入手机号码";
        
        self.coustomerAddress.placeholder = @"请输入详细的地址";

    }
    else
    {
        self.navigationItem.title = @"编辑收货地址";
    }
    
    [self.defaultAddressBtn.layer setMasksToBounds:YES];
    [self.defaultAddressBtn.layer setCornerRadius:3];
    [self.defaultAddressBtn setBackgroundColor:UIColorFromOXRGB(0xff542d)];
    
    self.areaView = [[AreaView alloc]initWithFrame:CGRectMake(0, IPHONE_HEIGHT-[PublicMethod PictureViewAdaptHeight:244], IPHONE_WITH, [PublicMethod PictureViewAdaptHeight:244])];
    self.areaView.delegate = self;
    
    
    
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
#pragma mark - AreaViewDelegate
-(void)okBtnClickWithChoseArea:(AreaModel *)areaModel
{
    [self.areaView removeFromSuperview];
    self.arrowIMV.image = [UIImage imageNamed:@"xiajiantou.png"];
    _isFirstClick = YES;
    
    
    NSString *areaStr = [NSString stringWithFormat:@"%@ %@ %@",areaModel.province,areaModel.city,areaModel.district];
    
    [self.customerArea setTitle:areaStr forState:UIControlStateNormal];
    
    
    
}

-(void)areaCancleBtnClick
{
    [self.areaView removeFromSuperview];
    self.arrowIMV.image = [UIImage imageNamed:@"xiajiantou.png"];
    _isFirstClick = YES;
}


- (IBAction)customerAreaClick:(UIButton *)sender
{
    if (_isFirstClick)
    {
        self.arrowIMV.image = [UIImage imageNamed:@"shanglajiantou.png"];
        _isFirstClick = NO;
        [self.view addSubview:_areaView];
    }
    else
    {
        self.arrowIMV.image = [UIImage imageNamed:@"xiajiantou.png"];
        _isFirstClick = YES;
        [self.areaView removeFromSuperview];
    }

    
    
    
    
    
    
    
    
    
    
}

- (IBAction)defaultAddressBtnClick:(UIButton *)sender
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
