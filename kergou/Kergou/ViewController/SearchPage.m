//
//  SearchPage.m
//  Kergou
//
//  Created by JiaPin on 15/9/24.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "SearchConfirmVC.h"
#import "PublicCell.h"
#import "SearchPage.h"

@interface SearchPage ()<UITextFieldDelegate>
{
    UITabBarController *_tabBarController;
    NSArray            *_btnTitleArr;
}

@property (weak, nonatomic) IBOutlet UITextField *searchBar;
@property (weak, nonatomic) IBOutlet UIImageView *latestSearchImage;
- (IBAction)cancleBtn:(id)sender;

@end

@implementation SearchPage
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
   
    _tabBarController= [PublicMethod getTabBarController];
    _tabBarController.tabBar.hidden = YES;
  

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
   
    _tabBarController.tabBar.hidden = NO;
    
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initSearchBar];
    [self initLatestSearchBtn];
    [self initNavagation];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiisKeyboard)];
    [self.view addGestureRecognizer:tap];
   
}
-(void)initNavagation
{
    [self.navigationItem.backBarButtonItem setTitle:@""];
    [self.navigationItem setHidesBackButton:YES];
    self.navigationController.navigationBar.barTintColor = UIColorFromOXRGB(0xffffff);
    self.searchBar.delegate = self;
    self.searchBar.placeholder = @"请输入关键字搜索";
    self.searchBar.backgroundColor = UIColorFromOXRGB(0xe8e8e8);
    self.searchBar.returnKeyType = UIReturnKeyGoogle;

}
-(void)initLatestSearchBtn
{
     JPLog(@"----latestSearchImage = %f   -----=%f",self.latestSearchImage.frame.origin.x,_latestSearchImage.frame.origin.y);
    
    
    //限定历史的搜索数据条数
    
    _btnTitleArr = @[@"零食",@"宝宝洗簌",@"纸尿裤",@"么么哒",@"哈哈哈",@"哈哈哈",@"哈哈哈",@"哈哈哈",@"哈哈哈",@"哈哈哈",@"哈哈哈",@"哈哈哈",@"哈哈哈",@"哈哈哈"];
    
   
    NSInteger p = -1;
    NSInteger x = [PublicMethod PictureViewAdaptHeight:68];
    float y = _latestSearchImage.frame.origin.y;
    NSInteger k = (IPHONE_WITH-5*x)/6;
    for (int i = 0; i<_btnTitleArr.count; i++)
    {
         UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (i%5 == 0)
        {
            p++;
            historyBtn.frame = CGRectMake(k*((i-p*5)+1)+x*(i-p*5), y+25+42*p, x, 27);
            
        }
        else
        {
            historyBtn.frame = CGRectMake(k*((i-p*5)+1)+x*(i-p*5), y+25+42*p, x, 27);
            
        }
        [historyBtn setTitle:_btnTitleArr[i] forState:UIControlStateNormal];
        [historyBtn setTitleColor:UIColorFromOXRGB(0x8e8e8e) forState:UIControlStateNormal];
        historyBtn.titleLabel.font = [UIFont fontWithName:nil size:12];
        historyBtn.backgroundColor = [UIColor whiteColor];
        historyBtn.tag = 2000+i;
        [historyBtn addTarget:self action:@selector(historyBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [historyBtn.layer setMasksToBounds:YES];
        [historyBtn.layer setCornerRadius:8];
        [historyBtn.layer setBorderWidth:1];
        [historyBtn.layer setBorderColor:UIColorFromOXRGB(0xcbcbcb).CGColor];
        
        [self.view addSubview:historyBtn];
    }
   
    UIImageView *deleteImage = [[UIImageView alloc]initWithFrame:CGRectMake(2*(k+x)-10, y+42*p+64+44, 17, 17)];
    deleteImage.image = [UIImage imageNamed:@"lajitong.png"];
    [self.view addSubview:deleteImage];
    
    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(2*(k+x)+10, y+42*p+64+44,100, 15)];
    lable.font = [UIFont fontWithName:nil size:14];
    lable.text = @"清空搜索历史";
    lable.textColor = UIColorFromOXRGB(0x8e8e8e);
    [self.view addSubview:lable];
    
    
    
    
    
    
    
    
    
}
-(void)initSearchBar
{
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sousuoxibing.png"]];
    imageView.frame = CGRectMake(114, 10, 16, 16);
    
    self.searchBar.leftView = imageView;
    self.searchBar.leftViewMode = UITextFieldViewModeAlways;
}
-(void)dismiisKeyboard
{
    [self.searchBar resignFirstResponder];
}
-(void)historyBtnClick:(UIButton *)sender
{

    self.searchBar.text = _btnTitleArr[sender.tag-2000];
    
    SearchConfirmVC *vc = (SearchConfirmVC *) [PublicMethod getVCByStoryboardID:@"searchOk" andWithSBName:@"Main"];
    vc.searchTextFile.text = _btnTitleArr[sender.tag-2000];
    [self.navigationController pushViewController:vc animated:YES];
    

}
#pragma mark - keyboardDelegat
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
   
    [textField resignFirstResponder];
    
    SearchConfirmVC *vc = (SearchConfirmVC *) [PublicMethod getVCByStoryboardID:@"searchOk" andWithSBName:@"Main"];
    vc.searchTextFile.text = _searchBar.text;
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    return YES;
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

- (IBAction)cancleBtn:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
