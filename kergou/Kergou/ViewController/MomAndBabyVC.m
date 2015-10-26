//
//  MomAndBabyVC.m
//  Kergou
//
//  Created by JiaPin on 15/9/23.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "GoodsdetailVC.h"
#import "MomAndBabyCell.h"
#import "SearchConfirmView.h"
#import "SearchPage.h"
#import "MomAndBabyVC.h"

@interface MomAndBabyVC ()<SearchConfirmViewDelegate,MomAndBabyCellDelegate>
{
    UITabBarController *_tabBarControl;
    SearchConfirmView  *_SearchConfirmVi;
    BOOL               _isFirstClick1;
    BOOL               _isFirstClick2;
    BOOL               _isFirstClick3;
    BOOL               _isExist;

}
@property (nonatomic,strong)NSMutableArray *btnMArr;
@property (nonatomic,strong)NSMutableArray *arrowImgMArr;

@end

@implementation MomAndBabyVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _isFirstClick1 = YES;
    _isFirstClick2 = YES;
    _isFirstClick3 = YES;
    _isExist = NO;
    _tabBarControl = [PublicMethod getTabBarController];
    _tabBarControl.tabBar.hidden = YES;

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _tabBarControl.tabBar.hidden = NO;
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    _SearchConfirmVi = [[SearchConfirmView alloc]initWithFrame:CGRectMake(0, 108+31, IPHONE_WITH, IPHONE_HEIGHT)];
    _SearchConfirmVi.delegate = self;
    [self initNavagation];

    
}
-(void)initNavagation
{
    [self.navigationItem.backBarButtonItem setTitle:@""];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationItem.title = _navTitleStr;

    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:@"zuojiantou.png"] forState:UIControlStateNormal];
    backBtn.frame = CGRectMake(0,0, 38, 38);
    [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [searchBtn setImage:[[UIImage imageNamed:@"shensesousuo.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
    searchBtn.frame = CGRectMake(0,0, 38, 38);
    [searchBtn addTarget:self action:@selector(searchBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *searchBar = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    
    self.navigationItem.leftBarButtonItem = barBtn;
    self.navigationItem.rightBarButtonItem = searchBar;
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 130/2;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH,65)];
    vi.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    
    NSArray *scrollNameArr = @[@"奶粉",@"纸尿裤",@"辅食",@"宝宝营养",@"宝宝洗护",@"孕妈专区"];
    
    UIScrollView *scoll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, 31)];
    scoll.contentSize = CGSizeMake((24*(scrollNameArr.count+1)+58*scrollNameArr.count), 0);
    scoll.showsHorizontalScrollIndicator = NO;
    scoll.backgroundColor = [UIColor whiteColor];
    scoll.bounces = NO;
    for (int i = 0; i<scrollNameArr.count; i++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake([PublicMethod PictureViewAdaptHeight:(24*(i+1)+58*i)],10, 58, 9);
        btn.titleLabel.font = [UIFont fontWithName:nil size:14];
        btn.tag = 2000+i;
        [btn setTitleColor:UIColorFromOXRGB(0x8c8c8c) forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(selectBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:scrollNameArr[i] forState:UIControlStateNormal];
        [scoll addSubview:btn];
        
        
    }
    UIView *headerLineView = [PublicMethod getLineViewWithFrame:CGRectMake(0, 30.5,(24*(scrollNameArr.count+1)+58*scrollNameArr.count), 0.5)];
    [scoll addSubview:headerLineView];
    [vi addSubview:scoll];
    
    UIView *btmvi = [[UIView alloc]initWithFrame:CGRectMake(0, 31, IPHONE_WITH, 34)];
    btmvi.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    NSArray *btmNameArr = @[@"默认",@"国家馆",@"价格",@"筛选"];
    
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
        [btn setTitle:btmNameArr[i] forState:UIControlStateNormal];
        [self.btnMArr addObject:btn];
        if (i==0)
        {
            btn.selected = YES;
        }
        
        [btmvi addSubview:btn];
        
        if (i!=0)
        {
            UIImageView *arrowImgView = [[UIImageView alloc]initWithFrame:CGRectMake(btn.frame.origin.x+btn.frame.size.width+2, 17, 7, 4)];
            arrowImgView.image = [UIImage imageNamed:@"xiangxiasanjiao.png"];
            
            [self.arrowImgMArr addObject:arrowImgView];
            
            [btmvi addSubview:arrowImgView];
            
        }
        
    }
    
    UIView *lineView = [PublicMethod getLineViewWithFrame:CGRectMake(0, 33.5, IPHONE_WITH, 0.5)];
    [btmvi addSubview:lineView];
    
    [vi addSubview:btmvi];
    return vi;

    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PublicMethod PictureViewAdaptHeight:264.0f];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MomAndBabyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MomAndBabyCell" forIndexPath:indexPath];
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
    

}
#pragma mark - MomAndBabyCellDelegate
-(void)gotoGoodsDetailVC
{
    GoodsdetailVC *vc = (GoodsdetailVC *)[PublicMethod getVCByStoryboardID:@"goodsdetailSB" andWithSBName:@"Main"];
    [self.navigationController pushViewController:vc animated:YES];
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
    }
    
    
    
}

-(void)selectBtn:(UIButton *)sender
{
    
}

-(void)selectBtn1:(UIButton *)sender
{
    
}
-(void)backBtnClick:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)searchBtnClick:(UIButton *)sender
{
    SearchPage *vc = (SearchPage *)[PublicMethod getVCByStoryboardID:@"SearchPage" andWithSBName:@"Main"];

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
