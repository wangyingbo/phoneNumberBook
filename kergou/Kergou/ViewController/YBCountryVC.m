//
//  YBCountryVC.m
//  Kergou
//
//  Created by 王迎博 on 15/9/25.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBCountryVC.h"
#import "Common.h"
#import "YBCountryCollectionViewCell.h"
#import "YBCountryHeaderVIew.h"
#import "YBCountryFooterView.h"
#import "YBSearchBar.h"
#import "YBButtonVC.h"
#import "SearchPage.h"
#import "NSMutableDictionary+defaultDic.h"


//-------------------------------------分割---------------------------------
@interface YBCountryVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)NSIndexSet *mid;

@end



@implementation YBCountryVC
- (void)viewDidLoad
{
    [super viewDidLoad];

     self.collectionView.contentInset = UIEdgeInsetsMake(10, 0, 0, 0);
    self.collectionView.contentOffset = CGPointMake(0, 0);

    
    self.collectionModelArr = @[@[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test"], @[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test"], @[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test"], @[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test"], @[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test"]];
    //self.collectionModelSmall = [self.collectionModelLarge subarrayWithRange:NSMakeRange(0, 3)];
    //self.collectionModel = self.collectionModelLarge;
    
    [self loadData];
}


//-------------------------------------请求数据---------------------------------
//请求数据，解析数据。
- (void)loadData
{
    //无参数访问
    //NSMutableDictionary *parameter = [NSMutableDictionary defaultDicWithAdr:nil];
    [NetWorkRequest PostDataViewController:self BaseUrl:nil Funtioname:kCountryBaseURL Parameter:nil Success:^(id responseObject) {
        JPLog(@">>>>>>>>>>>>>>>>>>>>>>>>打印数据>>>>>>>>>>>>>>>>>>>>>>>>%@",responseObject);
        
        
        
    } LoadFailed:^(NSError *error) {
        JPLog(@"%@",error);
    } haveNONetWork:^{
        
    }];
}



//-------------------------------------分割---------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

//#pragma mark  --YBCountryFooterViewDelegate
//- (void)reloadFooterViewData:(YBCountryFooterView *)footerView
//{
//    NSIndexSet *idxSet = [NSIndexSet indexSetWithIndex:footerView.tag];
//    [self.collectionView reloadSections:idxSet];
//}




//-------------------------------------data source---------------------------------
#pragma mark data source
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return self.collectionModelArr.count;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [self.collectionModelArr[section] count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    YBCountryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    
    return cell;
}


//cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size = CGSizeMake((FULL_SCREEN_WIDTH-18)/3, 70);
    CGFloat width = FULL_SCREEN_WIDTH - 9 - size.width*3;
    self.cellFloat = width;
    
    return size;
}


//section的四边距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 9, 0, 9);
    return insets;
}



//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    
    
    
    return 0;
}

//-------------------------------------delegate---------------------------------
//cell被选择时被调用
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSLog(@"点击了第%ld个section的第%ld个item",(long)indexPath.section,(long)indexPath.row);
    //brandPageSB
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchPage *searchPage = [storyBoard instantiateViewControllerWithIdentifier:@"brandPageSB"];
    [self.navigationController pushViewController:searchPage animated:YES];

    
}

//-------------------------------------分割---------------------------------
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader)
        
    {
        YBCountryHeaderVIew *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerView" forIndexPath:indexPath];
        headerView.headerName.text = @"test";
        reusableView = headerView;
    }
    
    //添加footerView
    if (kind == UICollectionElementKindSectionFooter)
    {
        YBCountryFooterView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerView" forIndexPath:indexPath];
        [footerView.footerButton setImage:[UIImage imageNamed:@"xiajiantou"] forState:UIControlStateNormal];
        [footerView.footerButton setImage:[UIImage imageNamed:@"shanglajiantou"] forState:UIControlStateSelected];
//        footerView.footerButton.showsTouchWhenHighlighted = YES;
        
        
        [footerView.footerButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];

        
        
        /*
        怎么在刷新reloadSection方法时，获得它的参数NSIndexSet
        */
        footerView.tag = indexPath.section;
        self.mid = [NSIndexSet indexSetWithIndex:footerView.tag];

        
        reusableView = footerView;
    }
    return reusableView;
}
//-------------------------------------footerView上button的点击方法---------------------------------
- (void)buttonPressed:(UIButton *)button
{
    UIButton *butt = (UIButton *)button;
    butt.selected = !butt.selected;
    
   
    //self.mid = [NSIndexSet indexSetWithIndex:indexPath.section];
    //NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:1];
    
    if(button.tag == 0)
    {
        JPLog(@"点击了展开按钮");
        //self.collectionModelArr = @[@[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test", @"test",@"test", @"test"], @[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test", @"test",@"test", @"test"], @[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test", @"test",@"test", @"test"], @[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test", @"test",@"test", @"test"], @[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test", @"test",@"test", @"test"]];
        
        //self.collectionModelArr = self.collectionModelLarge;
        
        //需要刷新section，而不是刷新collectionView
        //问题是怎么传入reloadSection的参数。
        //[self.collectionView reloadSections:indexSet];
        //[self.collectionView reloadData];
        button.tag = 1;
    }
    else
    {
        JPLog(@"点击了折叠按钮");
       // self.collectionModelArr = @[@[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test"], @[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test"], @[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test"], @[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test"], @[@"test",@"test", @"test",@"test", @"test",@"test", @"test",@"test", @"test"]];

        
        
        //self.collectionModelArr = self.collectionModelSmall;
    
        //[self.collectionView reloadSections:indexSet];
        //[self.collectionView reloadSections:<#(NSIndexSet *)#>];
        //[self.collectionView reloadData];
        button.tag = 0;
    }
    
}

@end
