//
//  IndexPageVC.m
//  Kergou
//
//  Created by JiaPin on 15/9/23.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "GoodsdetailVC.h"
#import "MomAndBabyVC.h"
#import "SearchPage.h"
#import "MJRefresh.h"
#import "ZSIndexCell.h"
#import "PageView.h"
#import "IndexPageVC.h"
#import "IndexPageCategoryModel.h"


#define  HOME_PAGE_KEY @"homePageKey"
#define  HOME_PAGE_AD_URL  @"/system/Picbar"
#define  HOME_PAGE_CATEGORY_URL  @"/goods/CategoryGoods"
#define  HOME_PAGE_BESE_SELECT_URL  @"/tag/tagGoods"
#define  HOME_PAGE_CATEGORY_CACHE_KEY  @"categoryKey"

#define  HOME_PAGE_BESE_SELECT_CACHE_KEY  @"bestSelectKey"

@interface IndexPageVC ()<ZSIndexCellDelegate>
{
    NSMutableDictionary *_dataMuDic;
    MJRefreshHeaderView *_header;
    MJRefreshFooterView *_footer;
    NSMutableArray      *_imageArray;
    BOOL                _isRefresh;
}
@property (nonatomic,strong)       IndexPageCategoryModel *categoryModle;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barBtnItem;
@property (weak, nonatomic) IBOutlet UIView *headerPicView;
@property (weak, nonatomic) IBOutlet UITableView *tableViewPageIndex;
@property (strong,nonatomic) NSMutableDictionary *categoryDataMDic;
@property (strong,nonatomic) NSMutableDictionary *bestSelectDataMDic;
@end

@implementation IndexPageVC
-(void)dealloc
{
    [_header free];
    [_footer free];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.barTintColor = UIColorFromOXRGB(0x21c1aa);
    _isRefresh = NO;

    [self getHomePageData];
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    [self.barBtnItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    self.tableViewPageIndex.frame = CGRectMake(0, 100, IPHONE_WITH, 200);
    
    [self initObject];
   
    //初始化导航栏上的内容
    [self initNavagationItems];
    [self addHeader];
    
}
-(void)initObject
{
    _dataMuDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    self.categoryDataMDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    self.categoryModle = [[IndexPageCategoryModel alloc]init];
    _imageArray = [[NSMutableArray alloc]initWithCapacity:0];
    self.bestSelectDataMDic = [[NSMutableDictionary alloc]initWithCapacity:0];
}
-(void)getHomePageData
{
    NSDictionary *dic = [[JPDataCache sharedInstance]objectForKey:HOME_PAGE_KEY];
    

    
    if (dic&&!_isRefresh)
    {
        [_dataMuDic setDictionary:dic];
        [self hidenWatingView];
        [self updateDataSourceWithID:@"轮播图" andDataDic:_dataMuDic];
       
        
    }
    else
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]initWithCapacity:0];
        [dict setObject:HOME_PAGE_KEY forKey:CACHE_KEY];
       
        [dict setObject:@"0" forKey:@"cat_id"];
        [dict setObject:@"1" forKey:@"picbar_type"];
        
        
        [NetWorkRequest PostDataViewController:self BaseUrl:BASEURL_GOODS Funtioname:HOME_PAGE_AD_URL Parameter:dict Success:^(id responseObject)
        {

            [self updateDataSourceWithID:@"轮播图" andDataDic:responseObject];
            if ([_header isRefreshing])
            {
                [_header endRefreshing];
            }
            
        } LoadFailed:^(NSError *error) {
            [self requestError];
        } haveNONetWork:^{
            [self requestError];
        }];
    
   
    }
    
    NSMutableDictionary *categoryMDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:HOME_PAGE_CATEGORY_CACHE_KEY,CACHE_KEY, nil];
    [NetWorkRequest GETDataViewController:self BaseUrl:BASEURL_GOODS FunctioName:HOME_PAGE_CATEGORY_URL Parameter:categoryMDic success:^(id responseObject)
     {
         [self updateDataSourceWithID:@"分类" andDataDic:responseObject];
         
    } loadFail:^(NSError *error)
    {
         [self requestError];
    } haveNoNetWork:^{
         [self requestError];
    }];
    
    
    NSMutableDictionary *bsetSelectMDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:HOME_PAGE_BESE_SELECT_CACHE_KEY,CACHE_KEY, nil];
    [NetWorkRequest GETDataViewController:self BaseUrl:BASEURL_GOODS FunctioName:HOME_PAGE_BESE_SELECT_URL Parameter:bsetSelectMDic success:^(id responseObject)
     {
         [self updateDataSourceWithID:@"精选" andDataDic:responseObject];
         
     } loadFail:^(NSError *error)
     {
         [self requestError];
     } haveNoNetWork:^{
         [self requestError];
     }];

    
    
    
    
    
    
    
}
-(void)requestError
{
    [_header endRefreshing];
}

-(void)updateDataSourceWithID:(NSString *)IDStr andDataDic:(id)responseObject
{
    [self hidenWatingView];
    
    if ([IDStr isEqualToString:@"轮播图"])
    {
        if ([(NSDictionary *)responseObject count]>0)
        {
            [_dataMuDic setDictionary:(NSMutableDictionary *)responseObject];
            
            [self setImageView];
           
            
            
            
        }
    }
 
    if ([IDStr isEqualToString:@"分类"])
    {
        NSMutableDictionary *responesDic = (NSMutableDictionary *)responseObject;
        if(responesDic&&responesDic.count>0)
        {
            [_categoryDataMDic setDictionary:responesDic];
         
        }

    }
    
    if ([IDStr isEqualToString:@"精选"])
    {
        if ([(NSDictionary *)responseObject count]>0)
        {
            [self.bestSelectDataMDic setDictionary:(NSMutableDictionary *)responseObject];

            
        }
    }

     [self.tableViewPageIndex reloadData];
   
}


-(void)setImageView
{

    NSArray *picDetailsArray = [_dataMuDic objectForKey:@"data"];
    [_imageArray removeAllObjects];
    for (NSDictionary *picDetailDic  in picDetailsArray)
    {
       NSString *picUrlStr = [picDetailDic objectForKey:@"wap_pic"];
        [_imageArray addObject:picUrlStr];
        
    }
    self.headerPicView.backgroundColor = UIColorFromOXRGB(0xf4f4f4);
    CGFloat headerViewHeight = [PublicMethod PictureViewAdaptHeight:195];
    self.headerPicView.frame = CGRectMake(0, 0, IPHONE_WITH,headerViewHeight );
    PageView *pageView = [[PageView alloc]initPageViewFrame:CGRectMake(0, 0, self.view.bounds.size.width,headerViewHeight - 11)];
    pageView.isWebImage = YES;
    pageView.imageArray = _imageArray;
    pageView.duration = 3.0;
    [self.headerPicView addSubview:pageView];
    
    
    
}
-(void)addHeader
{
    __unsafe_unretained IndexPageVC *vc = self;
    MJRefreshHeaderView *header = [MJRefreshHeaderView header];
    header.scrollView = _tableViewPageIndex;
    header.beginRefreshingBlock = ^(MJRefreshBaseView *refreshView)
    {
        _isRefresh = YES;
        [vc getHomePageData];
    };
    header.endStateChangeBlock = ^(MJRefreshBaseView *refreshView)
    {
        
    };
    header.refreshStateChangeBlock = ^(MJRefreshBaseView *refreshView, MJRefreshState state) {
        // 控件的刷新状态切换了就会调用这个block
        switch (state) {
            case MJRefreshStateNormal:
                //NSLog(@"%@----切换到：普通状态", refreshView.class);
                break;
                
            case MJRefreshStatePulling:
                //NSLog(@"%@----切换到：松开即可刷新的状态", refreshView.class);
                break;
                
            case MJRefreshStateRefreshing:
                //NSLog(@"%@----切换到：正在刷新状态", refreshView.class);
                
                break;
            default:
                break;
        }
    };
    _header = header;

}

-(void)initNavagationItems
{
   
    UIImageView *indexBarTitleImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 35)];
    indexBarTitleImgView.image = [UIImage imageNamed:@"kergou.png"];
    indexBarTitleImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.navigationItem.titleView = indexBarTitleImgView;
    
    
    
}


#pragma mark - Table view data source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [PublicMethod PictureViewAdaptHeight:272];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    

    return [[_categoryDataMDic objectForKey:@"data"] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    if (section == 6) {
        return 3;
    }
    else
    {
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 65/2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *IDStr = @"reuseIdentifier";
    
    ZSIndexCell  *cell = [tableView dequeueReusableCellWithIdentifier:IDStr];
    if (!cell)
    {
        cell = [[ZSIndexCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDStr];
    }
    cell.delegate = self;
    NSDictionary *dataDic = [[_categoryDataMDic objectForKey:@"data"]objectAtIndex:indexPath.section];
    
    NSArray     *dataArr = [dataDic objectForKey:@"goodsItem"];
    
    for (int i=0; i<2; i++)
    {
        NSDictionary *cellDic = dataArr[i];
        [cell configureCellWithDataModel:[_categoryModle initWithDictionary:cellDic] withNumCell:i];
    }
   
  
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, 65/2)];
    
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(9, 10, 15, 15)];
    
    UILabel *TitleLable = [[UILabel alloc]initWithFrame:CGRectMake(imageView.frame.origin.x+20, imageView.frame.origin.y, 70, imageView.frame.size.height)];
    TitleLable.font = [UIFont fontWithName:nil size:14.0f];
    
    
    UIButton *moreGoodsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreGoodsBtn.frame = CGRectMake(IPHONE_WITH-130, imageView.frame.origin.y,120, 15);
    moreGoodsBtn.titleLabel.font = [UIFont fontWithName:nil size:14.0];
    moreGoodsBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    moreGoodsBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [moreGoodsBtn setTitleColor:UIColorFromOXRGB(0xb0b0b0) forState:UIControlStateNormal];
    [moreGoodsBtn addTarget:self action:@selector(seeMoreGoods:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    switch (section)
    {
                   case 0:
            imageView.image = [UIImage imageNamed:@"muyingzhuanqu.png"];
         break;
        case 1:
            
            imageView.image = [UIImage imageNamed:@"yingyangbaojian.png"];
          
            break;
        case 2:
            
            imageView.image = [UIImage imageNamed:@"gehu.png"];
            
           
            break;
        case 3:
            imageView.image = [UIImage imageNamed:@"shipin.png"];
            break;
        case 4:
            imageView.image = [UIImage imageNamed:@"riyong.png"];

            break;
            
        default:
            imageView.image = [UIImage imageNamed:@"jingxuan.png"];

            break;
    }
    
    NSDictionary *dic  = [[_categoryDataMDic objectForKey:@"data"] objectAtIndex:section];
    
    NSString *categoryName = [dic objectForKey:@"category_name"];
    
    TitleLable.text = categoryName;
    
    if ([categoryName isEqualToString:@"每日精选"])
    {
        [moreGoodsBtn setTitle:@"每日10点更新" forState:UIControlStateNormal];
        moreGoodsBtn.tag = 10000+section;
        
    }
    else
    {
    [moreGoodsBtn setTitle:@"更多>" forState:UIControlStateNormal];
     moreGoodsBtn.tag = 10000+section;
    }

    
    
    [vi addSubview:imageView];
    [vi addSubview:TitleLable];
    [vi addSubview:moreGoodsBtn];
    
    vi.backgroundColor = [UIColor whiteColor];
    

    return vi;
}
-(void)seeMoreGoods:(id)sender
{
    UIButton *btn = (UIButton *)sender;
 
    
    MomAndBabyVC *vc = (MomAndBabyVC *)[PublicMethod getVCByStoryboardID:@"MAB" andWithSBName:@"Main"];

   
    
    
    switch (btn.tag)
    {
        case 10000:
            vc.navTitleStr = @"母婴专区";
            [self.navigationController pushViewController:vc animated:YES];
        
        
            
            
            break;
        case 10001:
            
            
            
            break;
        case 10002:
            
            break;
        case 10003:
            
            break;
        case 10004:
            
            break;
         
        default:
            
            
            
            
            break;
    }
    
    
}

#pragma mark - ZSIndexCellDelegate
-(void)gotoGoodsDetailVC
{
    GoodsdetailVC *vc = (GoodsdetailVC *)[PublicMethod getVCByStoryboardID:@"goodsdetailSB" andWithSBName:@"Main"];
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
