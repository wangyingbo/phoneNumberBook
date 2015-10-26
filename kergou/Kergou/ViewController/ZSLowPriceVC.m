//
//  ZSLowPriceVC.m
//  Kergou
//
//  Created by JiaPin on 15/9/18.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "ZSLowPriceVC.h"

@interface ZSLowPriceVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *NewSaleBtn;
@property (weak, nonatomic) IBOutlet UIButton *SoonSaleBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *lowPriceScroll;
@property (weak, nonatomic) IBOutlet UIView *bgView;



@property (weak, nonatomic) IBOutlet UITableView *lowPriceTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bgViewWidth;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrollViewWidth;



- (IBAction)NewSaleBtn:(UIButton *)sender;
- (IBAction)SoonSaleBtn:(UIButton *)sender;

@end

@implementation ZSLowPriceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIWindow *win = [UIApplication sharedApplication].windows[0];
    UITabBarController *tabBarController = (UITabBarController *)win.rootViewController;
    //    tabBarController.tabBar.selectedItem.
    tabBarController.tabBar.selectedItem.image = [[UIImage imageNamed:@"temaibaise.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    tabBarController.tabBar.selectedItem.selectedImage = [[UIImage imageNamed:@"tamai.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    
    self.bgViewWidth.constant = IPHONE_WITH;
    self.scrollViewWidth.constant = IPHONE_WITH*2;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self initTitleBtn];
    
    [self initScrollView];
    

}

-(void)initScrollView
{
   
    self.lowPriceScroll.delegate = self;
    self.lowPriceScroll.bounces = NO;
    self.lowPriceScroll.alwaysBounceVertical = NO;
    
    
//    self.lowPriceScroll.contentSize = CGSizeMake(IPHONE_WITH*2, 0);
   
}

//初始化导航栏处的button
-(void)initTitleBtn
{
    self.NewSaleBtn.selected = YES;
    [self.NewSaleBtn setTitleColor:UIColorFromOXRGB(0xef703c) forState:UIControlStateSelected];
    [self.SoonSaleBtn setTitleColor:UIColorFromOXRGB(0xef703c) forState:UIControlStateSelected];
    self.lineView.backgroundColor = UIColorFromOXRGB(0xef703c);
    

}

- (IBAction)NewSaleBtn:(UIButton *)sender
{
    self.NewSaleBtn.selected = YES;
    self.SoonSaleBtn.selected = NO;
    [UIView animateWithDuration:0.3 animations:^{
            self.lineView.frame = CGRectMake(26,33,70, 1);
        self.lowPriceScroll.contentOffset = CGPointMake(0, 0);
    }];
    

    
}


- (IBAction)SoonSaleBtn:(UIButton *)sender
{
    self.SoonSaleBtn.selected = YES;
    self.NewSaleBtn.selected = NO;
    
    [UIView animateWithDuration:0.3f animations:^{
            self.lineView.frame = CGRectMake(117,33,70, 1);
        self.lowPriceScroll.contentOffset = CGPointMake(IPHONE_WITH, 0);
    }];
    
}

#pragma mark --- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IDStr = @"lowPriceCell";
    
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:IDStr];
    
    
    return cell;
}

#pragma mark - scrollVeiwDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  NSInteger offSet = self.lowPriceScroll.contentOffset.x/IPHONE_WITH;
    
    if (offSet == 0)
    {
        self.NewSaleBtn.selected = YES;
        self.SoonSaleBtn.selected = NO;
        [UIView animateWithDuration:0.3f animations:^{
            self.lineView.frame = CGRectMake(26,33,70, 1);
        }];
    }
    else
    {
        self.SoonSaleBtn.selected = YES;
        self.NewSaleBtn.selected = NO;
      
        
        [UIView animateWithDuration:0.3f animations:^{
            self.lineView.frame = CGRectMake(117,33,70, 1);
        }];
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
