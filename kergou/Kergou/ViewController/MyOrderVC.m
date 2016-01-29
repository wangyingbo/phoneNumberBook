//
//  MyOrderVC.m
//  Kergou
//
//  Created by JiaPin on 15/9/28.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "GoodsdetailVC.h"
#import "CheckOutVC.h"
#import "cancleOrderView.h"
#import "GoodInfoPublicCell.h"
#import "MyOrderVC.h"
#import "CheckOutCell.h"

@interface MyOrderVC ()<CheckOutCellDelegate>
{
    UIView *_lineView;
    float  _tagValue;
    UITabBarController *_tabBarcontroller;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *BtnMArr;
@end

@implementation MyOrderVC

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _tabBarcontroller = [PublicMethod getTabBarController];
    _tabBarcontroller.tabBar.hidden = YES;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _tabBarcontroller.tabBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.BtnMArr = [[NSMutableArray alloc]initWithCapacity:0];
    

    
    
    [self initNavagation];
    [self initHeaderView];
    [self.tableView registerClass:[CheckOutCell class] forCellReuseIdentifier:@"checkOutID"];
    [self.tableView registerClass:[GoodInfoPublicCell class] forCellReuseIdentifier:@"GoodInfoCell"];
    

    

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
    self.navigationItem.leftBarButtonItem = barBtn;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"5951.png"] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(0,0, 38, 38);
    [rightBtn addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightBarBtn;

}
-(void)initHeaderView
{
    NSArray *nameArr = @[@"全部",@"待付款",@"待收货",@"已完成"];
    
    for (int i = 0; i< nameArr.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(((IPHONE_WITH-51*4)/5*(i+1)+51*i), 14, 51, 15);
        btn.titleLabel.font = [UIFont fontWithName:nil size:14];
        
        btn.tag = 2000+i;
        if (i==0)
        {
            btn.selected = YES;
        }
        
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromOXRGB(0x22c1ab) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(MyOrderSelectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:nameArr[i] forState:UIControlStateNormal];
        [self.headerView addSubview:btn];
        [self.BtnMArr addObject:btn];
        
    }
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(((IPHONE_WITH-51*4)/5*(0+1)+51*0),42, 51, 3)];
    _lineView.backgroundColor = UIColorFromOXRGB(0x22c1ab);
    [self.headerView addSubview:_lineView];
    
        
 
}
-(void)MyOrderSelectBtn:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 animations:^{
        _lineView.frame = CGRectMake(((IPHONE_WITH-51*4)/5*(sender.tag-2000+1)+51*(sender.tag-2000)),42, 51, 3);
    }];
    
    for (UIButton *btn in _BtnMArr)
    {
        btn.selected = NO;
    }
    sender.selected = YES;
}
-(void)backBtnClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)rightBtnClick:(UIButton *)sender
{
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, 62)];
    sectionView.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    UIView *lineView = [PublicMethod getLineViewWithFrame:CGRectMake(0,17, IPHONE_WITH, 0.5)];
    
    UIView *btmLineView = [PublicMethod getLineViewWithFrame:CGRectMake(17, 17+45, IPHONE_WITH, 0.5)];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 18, IPHONE_WITH, 45)];
    bgView.backgroundColor = [UIColor whiteColor];
    
    UILabel *orderNumlab = [[UILabel alloc]initWithFrame:CGRectMake(14, 15, 250, 20)];
    orderNumlab.textAlignment = NSTextAlignmentLeft;
    orderNumlab.font = [UIFont fontWithName:nil size:14];
    orderNumlab.text = @"订单号:90000000";
    [bgView addSubview:orderNumlab];
    
    UILabel *stateLab = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WITH-60, 15,150, 20)];
    stateLab.textAlignment = NSTextAlignmentLeft;
    stateLab.font = [UIFont fontWithName:nil size:14];
    stateLab.textColor = UIColorFromOXRGB(0xff542d);
    stateLab.text = @"已取消";
    [bgView addSubview:stateLab];
    
    
    
   
    [sectionView addSubview:bgView];
    [sectionView addSubview:lineView];
     [sectionView addSubview:btmLineView];
    
    
    return sectionView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 62;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    if (indexPath.row == 2)
    {
        return 91;
    }
    else
    {
      return 115;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 3;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 2)
    {
        GoodsdetailVC *vc = (GoodsdetailVC *)[PublicMethod getVCByStoryboardID:@"goodsdetailSB" andWithSBName:@"Main"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != 2)
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
    else
    {
        
       static NSString *IDStr = @"checkOutID";
        CheckOutCell *cell = [tableView dequeueReusableCellWithIdentifier:IDStr forIndexPath:indexPath];
        
        if (!cell)
        {
            cell = [[CheckOutCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDStr];

        }
        [cell configureViewWithBtnStatuesStr:@"2"];
        cell.delegate = self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
 
        
        return cell;
    }
   
}
#pragma mark - CheckOutCellDelegate
-(void)rightBtnPayClick
{
    CheckOutVC *vc =  (CheckOutVC *) [PublicMethod getVCByStoryboardID:@"CheckOutSB" andWithSBName:@"Main"];
    [self.navigationController pushViewController:vc animated:YES];
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
