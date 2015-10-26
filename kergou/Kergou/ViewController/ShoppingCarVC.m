//
//  ShoppingCarVC.m
//  Kergou
//
//  Created by JiaPin on 15/9/23.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "CheckOutVC.h"
#import "IndexPageVC.h"
#import "LogInVC.h"
#import "AreaView.h"
#import "ShoppingCarCell.h"
#import "ShoppingCarVC.h"
#import "GoodsdetailVC.h"
#define  SHOP_CAR_URL @"/app/CartList"
@interface ShoppingCarVC ()
{
    BOOL     _isFirstClick;
    
}
@property (strong, nonatomic) IBOutlet UIView *controllerView;
@property (strong,nonatomic)           NSMutableArray *dataArr;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic)           UIButton *selectAllBtn;
@property (strong,nonatomic)           NSMutableArray *indexPathArr;
@end

@implementation ShoppingCarVC
-(void)configureViewController
{
    [self initNavagation];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self getDataFromInternate];
    
    if (YES)
    {
//         [self initNoGoodsView];
    }
    else
    {
        
    }
   

    
    
}
-(void)getDataFromInternate
{
    NSMutableDictionary *dataMdic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    [dataMdic setObject:@"52" forKey:@"user_id"];
    
    [NetWorkRequest PostDataViewController:self BaseUrl:BASEURL_GOODS Funtioname:SHOP_CAR_URL Parameter:dataMdic Success:^(id responseObject)
    {
        self.dataArr = [[(NSDictionary *)responseObject objectForKey:@"data"] objectForKey:@"cartitems"];
        [self.tableView reloadData];
        [self initCheckOutBarViewWithCartPrice:[[(NSDictionary *)responseObject objectForKey:@"data"]objectForKey:@"cartprice"]];
        
    } LoadFailed:^(NSError *error)
    {
        
    } haveNONetWork:^{
        
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _isFirstClick = YES;
    
    self.indexPathArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    
    
    
  
}
-(void)initNavagation
{
    self.navigationController.navigationBar.barTintColor = UIColorFromOXRGB(0xf8f8f8);
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

-(void)initNoGoodsView
{
    UIView *BgVi = [[UIView alloc]initWithFrame:CGRectMake(0, 64, IPHONE_WITH, IPHONE_HEIGHT-64-49)];
    BgVi.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    
 
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, 50)];
    topView.backgroundColor = UIColorFromOXRGB(0xf8f5e2);
    
    
    UIView *lineView = [PublicMethod getLineViewWithFrame:CGRectMake(0,49.5, IPHONE_WITH, 0.5)];
    [topView addSubview:lineView];
    UILabel *tipsLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, IPHONE_WITH-10, 54)];
    tipsLab.text = @"温馨提示：现在                    您可以同步电脑与手机购物车中的商品。";
    tipsLab.numberOfLines = 2;
    tipsLab.lineBreakMode = NSLineBreakByWordWrapping;
    tipsLab.font = [UIFont fontWithName:nil size:14];
    
    
    UIButton *LogInBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    LogInBtn.frame = CGRectMake(114, 6, 65, 22);
    LogInBtn.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    [LogInBtn setTitle:@"登录" forState:UIControlStateNormal];
    LogInBtn.titleLabel.font = [UIFont fontWithName:nil size:14];
    [LogInBtn setTitleColor:UIColorFromOXRGB(0x7c7c7c) forState:UIControlStateNormal];
    [LogInBtn.layer setMasksToBounds:YES];
    [LogInBtn.layer setCornerRadius:4.0];
    [LogInBtn.layer setBorderWidth:1.0];
    LogInBtn.layer.borderColor = UIColorFromOXRGB(0x7c7c7c).CGColor;
    [LogInBtn addTarget:self action:@selector(LogInbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIImageView *shopCarImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"gouwucheweikong.png"]];
    
    shopCarImgView.frame = CGRectMake(self.view.center.x-93/2,[PublicMethod PictureViewAdaptHeightChange:180], 93, 90);
 
    
   
    UIImageView *textImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wenzi.png"]];
    textImgView.frame = CGRectMake(self.view.center.x-219/2,[PublicMethod PictureViewAdaptHeightChange:180]+95, 219, 17);
  
    
    UIButton *GotoSeeSeeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    GotoSeeSeeBtn.frame = CGRectMake(self.view.center.x-45,[PublicMethod PictureViewAdaptHeightChange:180]+90+51, 93, 37);
    GotoSeeSeeBtn.backgroundColor = UIColorFromOXRGB(0xef703d);
    [GotoSeeSeeBtn setTitle:@"去逛逛" forState:UIControlStateNormal];
    [GotoSeeSeeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    GotoSeeSeeBtn.titleLabel.font = [UIFont fontWithName:nil size:14];
    [GotoSeeSeeBtn.layer setMasksToBounds:YES];
    [GotoSeeSeeBtn.layer setCornerRadius:1];
    [GotoSeeSeeBtn addTarget:self action:@selector(gotoSeeSeeBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [topView addSubview:LogInBtn];
    [topView addSubview:tipsLab];
    [BgVi addSubview:topView];
    [BgVi addSubview:shopCarImgView];
    [BgVi addSubview:textImgView];
    [BgVi addSubview:GotoSeeSeeBtn];
    [self.view addSubview:BgVi];
    
}
-(void)initCheckOutBarViewWithCartPrice:(NSString *)totalPrice
{
   
    UIView *vi  = [[UIView alloc]initWithFrame:CGRectMake(0, IPHONE_HEIGHT-49-50, IPHONE_WITH, 50)];
    vi.backgroundColor = [UIColor whiteColor];
    
    
    
    
    self.selectAllBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.selectAllBtn.frame = CGRectMake([PublicMethod PictureViewAdaptHeight:12], 15, 18, 18);
    [self.selectAllBtn setImage:[UIImage imageNamed:@"weixuanzhonggouwuche.png"] forState:UIControlStateNormal];
    
    
    [self.selectAllBtn addTarget:self action:@selector(selectallBtnClick:) forControlEvents:UIControlEventTouchUpInside];
   
    
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(_selectAllBtn.frame.origin.x+_selectAllBtn.frame.size.width+5, 15, 50, 20)];
    lab.font = [UIFont fontWithName:nil size:14];
    lab.text = @"全选" ;
   
    
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(IPHONE_WITH-[PublicMethod PictureViewAdaptHeight:93]-10,7, [PublicMethod PictureViewAdaptHeight:93],36);
    [btn setTitle:@"结算" forState:UIControlStateNormal];
    [btn setBackgroundColor:UIColorFromOXRGB(0xef703d)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(gotoCheckOut:) forControlEvents:UIControlEventTouchUpInside];
    
    
  
    UILabel *moneyLab = [[UILabel alloc]initWithFrame:CGRectMake(IPHONE_WITH-[PublicMethod PictureViewAdaptHeight:93]-10-[PublicMethod PictureViewAdaptHeight:180]-4, 15, [PublicMethod PictureViewAdaptHeight:180], 20)];
    //    moneyLab.backgroundColor = [UIColor redColor];
    moneyLab.textAlignment = NSTextAlignmentRight;
    moneyLab.font = [UIFont fontWithName:nil size:14];
    
    moneyLab.text = [NSString stringWithFormat:@"合计:¥%@(不含运费)",totalPrice] ;
    
    
    UIView *lineView = [PublicMethod getLineViewWithFrame:CGRectMake(0, 0.5, IPHONE_WITH, 0.5)];
    [vi addSubview:lineView];
    [vi addSubview:lab];
    [vi addSubview:btn];
    [vi addSubview:moneyLab];
    [vi addSubview:_selectAllBtn];
    [self.view addSubview:vi];
    
    
}
-(void)gotoCheckOut:(UIButton *)sender
{
    CheckOutVC *vi = (CheckOutVC *)[PublicMethod getVCByStoryboardID:@"CheckOutSB" andWithSBName:@"Main"];
    [self.navigationController pushViewController:vi animated:YES];

}
-(void)LogInbtnClick:(UIButton *)sender
{
    LogInVC *vc = (LogInVC *)[PublicMethod getVCByStoryboardID:@"loginSB" andWithSBName:@"Main"];
    [self presentViewController:vc animated:YES completion:nil];
}
-(void)gotoSeeSeeBtnClick:(UIButton *)sender
{
    UIWindow *win = [UIApplication sharedApplication].windows[0];
    UITabBarController *tabBarContr = (UITabBarController *)win.rootViewController;
    [tabBarContr setSelectedIndex:0];
    
}

#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.indexPathArr addObject:indexPath];
    
    return 138.0f;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    return 1;
}
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"我的收藏";
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsdetailVC *vc = (GoodsdetailVC *)[PublicMethod getVCByStoryboardID:@"goodsdetailSB" andWithSBName:@"Main"];
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    
    return _dataArr.count;
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
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static  NSString *IDStr = @"shoppingCar";
    ShoppingCarCell *cell = [tableView dequeueReusableCellWithIdentifier:IDStr forIndexPath:indexPath];
    if (!cell) {
        cell = [[ShoppingCarCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDStr];
    }
    ShopCarListModel *model = [[ShopCarListModel alloc]initWithDictionary:[_dataArr objectAtIndex:indexPath.row]];
    [cell configureCellWithModel:model];
    
    return cell;
}
-(void)selectallBtnClick:(UIButton *)sender
{
    ShoppingCarCell *cell ;
    for (NSIndexPath *indexP in _indexPathArr)
    {
        cell = (ShoppingCarCell *)[self.tableView cellForRowAtIndexPath:indexP];
            }
    if (_isFirstClick)
    {
        [_selectAllBtn setImage:[UIImage imageNamed:@"xuanzhong.png"] forState:UIControlStateNormal];
        _isFirstClick = NO;
        cell.headerIMV.image = [UIImage imageNamed:@"xuanzhong.png"];

        
    }
    else
    {
        [_selectAllBtn setImage:[UIImage imageNamed:@"weixuanzhonggouwuche.png"] forState:UIControlStateNormal];
        cell.headerIMV.image = [UIImage imageNamed:@"weixuanzhonggouwuche.png"];

        _isFirstClick = YES;
        
    }
    
   
    
    
    
    
    
    
    
    
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
