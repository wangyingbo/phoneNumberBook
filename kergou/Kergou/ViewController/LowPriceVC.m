//
//  LowPriceVC.m
//  Kergou
//
//  Created by JiaPin on 15/10/14.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "BrandSaleModel.h"
#import "BrandPageVC.h"
#import "LowPriceCell.h"
#import "LowPriceVC.h"
#define BRAND_SALE @"/tag/BrandTag"
#define BRAND_SALE_CACHE_KEY @"brandSaleCache"
@interface LowPriceVC ()
@property (nonatomic,strong)NSArray        *dataArr;
@property (weak, nonatomic) IBOutlet UITableView *tableVeiw;
@property (nonatomic,strong)BrandSaleModel *dataModel;

@end

@implementation LowPriceVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getHomeData];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initObjects];
    // Do any additional setup after loading the view.
}
-(void)initObjects
{
    self.dataModel = [[BrandSaleModel alloc]init];
}
-(void)getHomeData
{
    NSMutableDictionary *BrandMDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:BRAND_SALE_CACHE_KEY,CACHE_KEY, nil];
    [NetWorkRequest PostDataViewController:self BaseUrl:BASEURL_GOODS Funtioname:BRAND_SALE Parameter:BrandMDic Success:^(id responseObject)
     {
         NSDictionary *dataDic = (NSDictionary *)responseObject;
         self.dataArr = [dataDic objectForKey:@"data"];
         
         [self.tableVeiw reloadData];
         
  
         
     } LoadFailed:^(NSError *error)
    {
//         [self requestError];
     } haveNONetWork:^{
//         [self requestError];
     }];


    
}
#pragma mark --- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [PublicMethod PictureViewAdaptHeight:186];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BrandPageVC *vc = (BrandPageVC *)[PublicMethod getVCByStoryboardID:@"brandPageSB" andWithSBName:@"Main"];
    [self.navigationController pushViewController:vc animated:YES];
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IDStr = @"lowPriceCell";
    
    LowPriceCell  *cell = [tableView dequeueReusableCellWithIdentifier:IDStr];
    
    if (!cell)
    {
        cell = [[LowPriceCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDStr];
    }
   BrandSaleModel *model = [_dataModel initWithDictionary:[_dataArr objectAtIndex:indexPath.row]];
    [cell ConfigureCellWithModel:model];
    return cell;
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
