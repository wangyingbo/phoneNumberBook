//
//  YBClassifyVC.m
//  Kergou
//
//  Created by 王迎博 on 15/9/24.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBClassifyVC.h"
#import "YBClassifyCollectionViewCell.h"
#import "YBClassifyHeaderView.h"
#import "NSMutableDictionary+defaultDic.h"
#import "Common.h"
#import "YBClassifyHeaderView.h"
#import "YBSearchBar.h"
#import "YBButtonVC.h"
#import "SearchPage.h"
#import "YBSectionModel.h"
#import "YBCellModel.h"
#import "SVProgressHUD.h"


static NSInteger EmptyPlaceCell = 15;

@interface YBClassifyVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)   NSMutableArray *sectionNumArr;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation YBClassifyVC

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
}




//-------------------------------------分割---------------------------------
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.sectionNumArr = [[NSMutableArray alloc]initWithCapacity:0];
    self.modelArr = [[NSMutableArray alloc]initWithCapacity:0];

    YBSearchBar *searchBar = [[YBSearchBar alloc]initWithFrame:CGRectMake(9, -40, self.view.frame.size.width-18, 35)];
    //searchBar.layer.cornerRadius = 10;
    YBButtonVC *btn = [[YBButtonVC alloc]initWithFrame:CGRectMake(9, -40, searchBar.frame.size.width, searchBar.frame.size.height)];
    
    [btn pushSearchVC];//可以相应实例化对象方法。
    [btn addTarget:self action:@selector(pushSearch) forControlEvents:UIControlEventTouchUpInside];
    
    [self.collectionView addSubview:searchBar];
    [self.collectionView addSubview:btn];
    // self.collectionView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    //self.collectionView.contentOffset = CGPointMake(0, -50);
    
    [self loadData];
}

//-------------------------------------加载数据方法---------------------------------
- (void)loadData
{
    
    NSMutableDictionary *parameter = [NSMutableDictionary defaultDicWithAdr:kClassifyParameter];
    parameter[kClassifyParameter]=@2;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    
    [manager POST:kClassifyBaseURL parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *messageArr = responseObject[DATA];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in messageArr)
        {
            NSError *jsonError = nil;
            YBSectionModel *model0 = [[YBSectionModel alloc]initWithDictionary:dic error:&jsonError];
            
            [array addObject:model0];
            if ([dic objectForKey:CHILDREN]!=[NSNull null])
            {
                [self.sectionNumArr addObject:model0.children];
            }
            
        }
        //一级数据的全局数组
        self.modelArr = array;
        [self.collectionView reloadData];
        
    }
          failure:^(AFHTTPRequestOperation *operation, NSError *error){
              JPLog(@"%@",operation.responseString);
              [SVProgressHUD showWithStatus:@"正在加载"];
          }];
}


//-------------------------------------push到搜索页---------------------------------
- (void)pushSearch
{
    //JPLog(@"转向搜索页");
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchPage *searchPage = [storyBoard instantiateViewControllerWithIdentifier:@"SearchPage"];
    [self.navigationController pushViewController:searchPage animated:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



//-------------------------------------data source---------------------------------
#pragma mark   --data source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    //判断，当分类sectionName为空时不加载，不为空时加载
    return self.sectionNumArr.count;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //return self.cellNumArr.count;
    //return [[self.sectionNumArr objectAtIndex:section] count];
    return [self.sectionNumArr[section] count];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YBClassifyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    //[cell setData:self.sectionNumArr[indexPath.section]];
    //[cell setData:self.cellNumArr[indexPath.section]];
    //UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    YBSectionModel *model = self.modelArr[indexPath.section];
    NSArray *arr = model.children;
    [cell setData:arr[indexPath.item]];
    
    
    if (cell.cellImage == nil) {
        JPLog(@"--------图片为空");
    }
    
    return cell;
}


//section的四边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = UIEdgeInsetsMake(15, 22, 15, 22);
    return insets;
}

//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return EmptyPlaceCell;
}


//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return (FULL_SCREEN_WIDTH-272)/3;
}

//---------------------------------------------delegate---------------------------------------------
//cell被选择时被调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"点击了第%ld个section的第%ld个item",(long)indexPath.section,(long)indexPath.row);
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchPage *searchPage = [storyBoard instantiateViewControllerWithIdentifier:@"searchOk"];
    [self.navigationController pushViewController:searchPage animated:YES];
}


//cell反选时被调用(多选时才生效)
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//-------------------------------------headerView---------------------------------
//添加headerview的方法
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        YBClassifyHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        
        [header setData:self.modelArr[indexPath.section]];
        reusableView = header;
    }
    return reusableView;
}


@end
