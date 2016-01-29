//
//  SearchConfirmVC.m
//  Kergou
//
//  Created by JiaPin on 15/9/23.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "filterVC.h"

#import "LogoModel.h"
#import "SelectVC.h"
#import "SearchConfirmModel.h"
#import "SearchConfirmView.h"
#import "PublicMethod.h"
#import "ConfirmSearchCell.h"
#import "SearchConfirmVC.h"
#import "GoodsdetailVC.h"
#define SEARCH_CONFIRM_URL @"/search/appGoods"
#define SEARCH_ALL_LOGO_URL @"/app/brand"
#define SEARCH_CONFIRM_CEACHE_KEY @"searchConfirmKey"
#define SEARCH_LOGO_CEACHE_KEY @"logoCacheKey"


@interface SearchConfirmVC ()<UITextFieldDelegate,SearchConfirmViewDelegate,ConfirmSearchCellDelegate,filterVCDelegate>
{
    UITabBarController *_tabbarcontroller;
    SearchConfirmView  *_SearchConfirmVi;
    BOOL               _isFirstClick1;
    BOOL               _isFirstClick2;
    BOOL               _isFirstClick3;
    BOOL               _isExist;
    NSInteger          _count;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray      *btnMArr;
@property (strong,nonatomic) NSMutableArray      *arrowImgMArr;
@property (strong,nonatomic) NSMutableDictionary *dataMDic;
@property (strong,nonatomic) NSMutableDictionary *logoDataMDic;
@property (strong,nonatomic) NSMutableArray      *logoDataArr;
@property (strong,nonatomic) NSArray             *dataArr;
@property (nonatomic,strong) NSMutableDictionary *searchDict;


@end

@implementation SearchConfirmVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getSearchConfirmData];
    _isFirstClick1 = YES;
    _isFirstClick2 = YES;
    _isFirstClick3 = YES;
    _isExist = NO;
    _tabbarcontroller = [PublicMethod getTabBarController];
    _tabbarcontroller.tabBar.hidden = YES;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dataMDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    self.logoDataMDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    self.logoDataArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.dataArr = [[NSArray alloc]init];
    self.searchDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    _count= 0;
    // Do any additional setup after loading the view.
    
    

    
    
    [self initNavagation];
    
    [self wanShanView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiisKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _tabbarcontroller.tabBar.hidden = NO;
    
    //~~~~~~~~~~~~
    
    
    
    
    
    
}
-(void)getSearchConfirmData
{
    
    [self.searchDict setObject:SEARCH_CONFIRM_CEACHE_KEY forKey:CACHE_KEY];
    
    [self.searchDict setObject:@"a" forKey:@"keyword"];
    
    [NetWorkRequest PostDataViewController:self BaseUrl:BASEURL_GOODS Funtioname:SEARCH_CONFIRM_URL Parameter:_searchDict Success:^(id responseObject)
     {
         
         [self updateDataSourceWithIDString:@"搜索" result:responseObject];
         [self.tableView reloadData];
     } LoadFailed:^(NSError *error) {
         
     } haveNONetWork:^{
         
     }];
    NSMutableDictionary *logoDict = [[NSMutableDictionary alloc]initWithCapacity:0];
    [logoDict setObject:SEARCH_LOGO_CEACHE_KEY forKey:CACHE_KEY];
    [NetWorkRequest GETDataViewController:self BaseUrl:BASEURL_GOODS FunctioName:SEARCH_ALL_LOGO_URL Parameter:logoDict success:^(id responseObject)
     {
         [self updateDataSourceWithIDString:@"品牌" result:responseObject];
         
         
     } loadFail:^(NSError *error) {
         
     } haveNoNetWork:^{
         
     }];
    
}

-(void)updateDataSourceWithIDString:(NSString *)idStr result:(id)responseObject
{
    
    
    if ([idStr isEqualToString:@"搜索"])
    {
//        self.dataArr = nil;
        if ([(NSDictionary *)responseObject count]>0)
        {
            [self.dataMDic setDictionary:(NSDictionary *)responseObject];
            NSArray *arr = [[_dataMDic objectForKey:@"data"]objectForKey:@"list"];
            
            self.dataArr = arr;
            
        }
    }
    if ([idStr isEqualToString:@"品牌"])
    {
        [self.logoDataMDic setDictionary:(NSDictionary *)responseObject];
        NSArray *arr = [_logoDataMDic objectForKey:@"data"];
        
        [_logoDataArr removeAllObjects];
        
        for (NSDictionary *dic in arr)
        {
            LogoModel *model = [[LogoModel alloc]initWithDictionary:dic];
            [self.logoDataArr addObject:model];
        }
        
    }
    
    
    
}


-(void)wanShanView
{
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
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
    
    
    self.searchTextFile.delegate = self;
    self.searchTextFile.backgroundColor = UIColorFromOXRGB(0xe8e8e8);
    self.searchTextFile.returnKeyType = UIReturnKeyGoogle;
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sousuoxibing.png"]];
    imageView.frame = CGRectMake(114, 10, 16, 16);
    
    self.searchTextFile.leftView = imageView;
    self.searchTextFile.leftViewMode = UITextFieldViewModeAlways;
    
    
    
}
-(void)dismiisKeyboard
{
    [self.searchTextFile resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    
    return YES;
}


-(void)backBtnClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)selectBtnClick:(UIButton *)sender
{
    
    NSInteger i = sender.tag - 2000;
    UIButton *btn = (UIButton *) _btnMArr[i];
    for (UIButton *allBtn in _btnMArr)
    {
        allBtn.selected = NO;
    }
    btn.selected = YES;
    
    UIImageView *imageView;
    if (i!=0)
    {
        imageView = (UIImageView *)[_arrowImgMArr objectAtIndex:i-1];
        for (UIImageView *im in _arrowImgMArr)
        {
            im.image = [UIImage imageNamed:@"xiangxiasanjiao.png"];
            
        }
        imageView.image = [UIImage imageNamed:@"chengsexiangshang.png"];
    }
    
    
    if (sender.tag == 2000)
    {
        for (UIImageView *im in _arrowImgMArr)
        {
            im.image = [UIImage imageNamed:@"xiangxiasanjiao.png"];
            
        }
        _isFirstClick1 = YES;
        _isFirstClick2 = YES;
        _isFirstClick3 = YES;
        
    }
    
    
    
    if (sender.tag == 2001)
    {
        
        if (_isFirstClick1)
        {
            imageView.image = [UIImage imageNamed:@"chengsexiangshang.png"];
            _SearchConfirmVi = [[SearchConfirmView alloc]initWithFrame:CGRectMake(0, 108, IPHONE_WITH, IPHONE_HEIGHT)];
            _SearchConfirmVi.delegate = self;
            
            [_SearchConfirmVi configureDataWithArr:_dataArr];
//            _SearchConfirmVi.countryModelArr = _dataArr;

            
            
           [self.view addSubview:_SearchConfirmVi];
            
            _isExist = YES;
            _isFirstClick1 = NO;
            _isFirstClick2 = YES;
            _isFirstClick3 = YES;
        }
        else
        {
            imageView.image = [UIImage imageNamed:@"xiangxiasanjiao.png"];
            [_SearchConfirmVi removeFromSuperview];
            _isExist = NO;
            _isFirstClick1 = YES;
        }
        
    }
    else
    {
        [_SearchConfirmVi removeFromSuperview];
    }
    
    if (sender.tag ==2002)
    {
        
        
        if (_isFirstClick2)
        {
            imageView.image = [UIImage imageNamed:@"chengsexiangshang.png"];
            _isFirstClick2 = NO;
            _isFirstClick3 = YES;
            _isFirstClick1 = YES;
            
            
        }
        else
        {
            imageView.image = [UIImage imageNamed:@"xiangxiasanjiao.png"];
            _isFirstClick2 = YES;
            
        }
        
        
    }
    if (sender.tag == 2003)
    {
        
        if (_isFirstClick3)
        {
            imageView.image = [UIImage imageNamed:@"chengsexiangshang.png"];
            _isFirstClick3 = NO;
            _isFirstClick1 = YES;
            _isFirstClick2 = YES;
        }
        else
        {
            imageView.image = [UIImage imageNamed:@"xiangxiasanjiao.png"];
            _isFirstClick3 = YES;
        }
        filterVC *vc = (filterVC *)[PublicMethod getVCByStoryboardID:@"filterSB" andWithSBName:@"Main"];
        vc.delegated = self;
        vc.logoArr = _logoDataArr;
        [self presentViewController:vc animated:YES completion:nil];
        
        
        
    }
    
    
    
}
#pragma mark -filterVCDelegate
-(void)selectValueWithSV:(NSString *)sv withBeginValue:(NSString *)bv withEndValue:(NSString *)ev withLogoValue:(NSString *)lv
{
    
    if (sv)
    {
         [self.searchDict setObject:sv forKey:@"sale_num"];
    }
    if (bv)
    {
        [self.searchDict setObject:bv forKey:@"minPrice"];
    }
    if (ev)
    {
          [self.searchDict setObject:ev forKey:@"maxPrice"];
    }
    
    if (lv)
    {
         [self.searchDict setObject:lv forKey:@"brand_id"];
    }
   
    [self getSearchConfirmData];
    
    
//     JPLog(@"----bv = %@ ---ev = %@",bv,ev);
    
}
#pragma mark -ConfirmSearchCellDelegate
-(void)gotoGoodsDetailVC
{
    GoodsdetailVC *vc = (GoodsdetailVC *)[PublicMethod getVCByStoryboardID:@"goodsdetailSB" andWithSBName:@"Main"];
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, 34)];
    vi.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    NSArray *nameArr = @[@"默认",@"国家馆",@"价格",@"筛选"];
    
    self.btnMArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.arrowImgMArr = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i = 0; i< 4; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake([PublicMethod PictureViewAdaptHeight:(39*(i+1)+45*i)], 11, 45, 15);
        btn.titleLabel.font = [UIFont fontWithName:nil size:14];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:UIColorFromOXRGB(0xf29c7b) forState:UIControlStateSelected];
        btn.tag = 2000+i;
        [btn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:nameArr[i] forState:UIControlStateNormal];
        [self.btnMArr addObject:btn];
        if (i==0)
        {
            btn.selected = YES;
        }
        
        [vi addSubview:btn];
        
        if (i!=0)
        {
            UIImageView *arrowImgView = [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.origin.x+btn.frame.size.width+2, 17, 7, 4)];
            arrowImgView.image = [UIImage imageNamed:@"xiangxiasanjiao.png"];
            
            [self.arrowImgMArr addObject:arrowImgView];
            
            [vi addSubview:arrowImgView];
            
        }
        
    }
    
    UIView *lineView = [PublicMethod getLineViewWithFrame:CGRectMake(0, 33.5, IPHONE_WITH, 0.5)];
    [vi addSubview:lineView];
    
    return vi;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PublicMethod PictureViewAdaptHeight:264.0f];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 34;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (_dataArr.count%2!=0) {
        return _dataArr.count/2+1;
    }
    else
    {
        return _dataArr.count/2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ConfirmSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"confirmSearch" forIndexPath:indexPath];
    
    if (indexPath.row == 0)
    {
        for (int i = 0 ; i<2; i++)
        {
            NSDictionary *dic = [_dataArr objectAtIndex:i];
            SearchConfirmModel *model = [[SearchConfirmModel alloc]initWithDictionary:dic];
            
            [cell configureCellWithModel:model];
        }
        
    }
    else
    {
        for (int i = 1 ; i<3; i++)
        {
            NSDictionary *dic = [_dataArr objectAtIndex:indexPath.row+i];
            SearchConfirmModel *model = [[SearchConfirmModel alloc]initWithDictionary:dic];
            [cell configureCellWithModel:model];
        }
    }
    
    
    cell.delegate = self;
    
    return cell;
}
#pragma mark - SearchConfirmViewDelegate
-(void)ChoseNationBtnClick:(NSString *)nationName
{
    UIImageView  *imageView = (UIImageView *)[_arrowImgMArr objectAtIndex:0];
    imageView.image = [UIImage imageNamed:@"xiangxiasanjiao.png"];
    [_SearchConfirmVi removeFromSuperview];
    _isFirstClick1 = YES;
    
    [_searchDict setObject:nationName forKey:@"country_id"];
    
    [self getSearchConfirmData];
    
    
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
