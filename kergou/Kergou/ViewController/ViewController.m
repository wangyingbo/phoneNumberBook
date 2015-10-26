//
//  ViewController.m
// Kergou
//
//  Created by JiaPin on 15/8/18.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "GetVerifyCodeLable.h"
#import "PicPageControl.h"
#import "ShowSmallPicScrollView.h"
#import "UIImageView+MJWebCache.h"

#import "EAIntroView.h"
#import "PageView.h"
#import "ViewController.h"

@interface ViewController ()<EAIntroDelegate>
{
    NSArray *_urls;
 
}
@property (nonatomic,strong)  UILabel  *checkCodeNumberLabel;
@property (nonatomic,strong)  NSString  *code;
@property (nonatomic,strong)  UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
  

//    //Model 的示例
//        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"ZS",@"name",@"25",@"age",@"man",@"sex",nil];
//    
//   ExampleModel *model = [[ExampleModel alloc]initWithDictionary:dic];
//
//    NSLog(@"------model.name = %@ model.age = %@  model.sex = %@",model.name,model.age,model.sex);
    
//    添加验证码btn
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(10, 200, 100, 30);
//    btn.backgroundColor = [UIColor cyanColor];
//    [btn addTarget:self action:@selector(CreateVeriterfy:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];
//    self.checkCodeNumberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 100,80,30)];
    
 
    
   
    
    //轮换图之本地图片
    //    NSArray *imageArray = [[NSArray alloc] initWithObjects:@"img_01",@"img_02",@"img_03",@"img_04",nil];
    //轮换图之网络图片
//    NSArray *imageArray = @[@"http://i1.douguo.net//upload/banner/0/6/a/06e051d7378040e13af03db6d93ffbfa.jpg", @"http://i1.douguo.net//upload/banner/9/3/4/93f959b4e84ecc362c52276e96104b74.jpg", @"http://i1.douguo.net//upload/banner/5/e/3/5e228cacf18dada577269273971a86c3.jpg", @"http://i1.douguo.net//upload/banner/d/8/2/d89f438789ee1b381966c1361928cb32.jpg"];
//    PageView *pageView = [[PageView alloc]initPageViewFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
//    pageView.isWebImage = YES;
//    pageView.imageArray = imageArray;
//    pageView.duration = 3.0;
//    [self.view addSubview:pageView];
    
// 展示商品详情的图片
//   [self setSmallImageView];
 
//    添加引导图
//    [self addGuidePage];

}

//   添加验证码的lable
-(void)CreateVeriterfy:(UIButton *)sender
{
    
    UILabel *verifyLab = [GetVerifyCodeLable CreatVerifyCodeLableWithFrame:CGRectMake(10, 100,80,30)];

    [self.view addSubview:verifyLab];
    
 }

-(void)setSmallImageView
{
    
////    商品详情的图片数组，数组中为image元素
//    NSArray *imageArray = [[NSArray alloc] initWithObjects:[UIImage imageNamed:@"111.jpg"],[UIImage imageNamed:@"222.jpg"],[UIImage imageNamed:@"333.jpg"],nil];
//    
//    
//    
////    初始化商品详情的scrollView
//    ShowSmallPicScrollView *scroll = [[ShowSmallPicScrollView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, 200) withPicArr:imageArray withViewController:self];
//    PicPageControl *page = [[PicPageControl alloc]initWithFrame:CGRectMake(0, scroll.frame.size.height-20, IPHONE_WITH, 20) withPageCount:imageArray.count withClass:scroll];
//
//
//    [self.view addSubview:scroll];
//    
//    [self.view addSubview:page];
}



//添加引导图
-(void)addGuidePage
{
    NSString *appVersion = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    if (![[[NSUserDefaults standardUserDefaults]objectForKey:@"version"]isEqualToString:appVersion])
    {
        [self initGuidePage];
        [[NSUserDefaults standardUserDefaults]setObject:appVersion forKey:@"version"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

-(void)initGuidePage
{
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:self.view.bounds];
    EAIntroPage *page1 = [EAIntroPage pageWithCustomView:imageview1];
    
    UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:self.view.bounds];
    EAIntroPage *page2 = [EAIntroPage pageWithCustomView:imageview2];
    
    UIImageView *imageview3 = [[UIImageView alloc]initWithFrame:self.view.bounds];
    EAIntroPage *page3 = [EAIntroPage pageWithCustomView:imageview3];
    
    
    UIImageView *imageview4 = [[UIImageView alloc]initWithFrame:self.view.bounds];
    EAIntroPage *page4 = [EAIntroPage pageWithCustomView:imageview4];
    
    imageview1.image = [UIImage imageNamed:@"111.jpg"];
    imageview2.image = [UIImage imageNamed:@"222.jpg"];
    imageview3.image = [UIImage imageNamed:@"333.jpg"];
    imageview4.image = [UIImage imageNamed:@"111.jpg"];
    
    EAIntroView  *intro = [[EAIntroView alloc]initWithFrame:self.view.bounds andPages:@[page1,page2,page3,page4]];
    [intro setDelegate:self];
    [intro showInView:self.view animateDuration:0];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end




























































