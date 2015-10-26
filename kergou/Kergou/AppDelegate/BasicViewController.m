//
//  BasicViewController.m
//  Kergou
//
//  Created by JiaPin on 15/8/20.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "MBProgressHUD.h"
#import "BasicViewController.h"

@interface BasicViewController ()<MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
}
@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    初始化LoadingIcon
//    [self initLoadingIcon];
    
//    初始化等待的view
//    [self showWaitingResultWithWaitingText:@"付出总会有回报" afterDelay:2];
}

//显示登录的视图
-(void)showLoginViewController
{
    
}

//显示等待的结果和文字
-(void)showWaitingResultWithWaitingText:(NSString *)waitingText afterDelay:(NSTimeInterval)delay
{
    MBProgressHUD *Hud = [[MBProgressHUD alloc]initWithView:self.view];
    Hud.delegate =self;
    [self.view addSubview:Hud];
    Hud.mode = MBProgressHUDModeText;
    Hud.labelText = waitingText;
    [Hud show:YES];
    [Hud hide:YES afterDelay:delay];
}
//显示等待视图和文字
-(void)showWaitingViewWithText:(NSString *)waitingText
{
    if (!HUD) {
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        hud.delegate = self;
        [self.view addSubview:hud];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = waitingText;
        [hud show:YES];
        HUD = hud;
    }
    
}
//显示等待的视图
-(void)showWaitingView
{
    if (!HUD) {
        MBProgressHUD * _HUD = [[MBProgressHUD alloc] initWithView:self.view];
        _HUD.delegate = self;
        [self.view addSubview:_HUD];
        _HUD.mode = MBProgressHUDModeIndeterminate;
        _HUD.labelText = @"正在努力加载中...";
        [_HUD show:YES];
        HUD = _HUD;
    }
}
//隐藏等待仕途
-(void)hidenWatingView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    if (HUD) {
        [HUD hide:YES];
        [HUD removeFromSuperview];
        HUD= nil;
    }
}
#pragma mark - showLoadingIcon
-(void)showLoadingIcon
{
    _loadingIcon.center = self.view.center;
    if (!_loadingIcon.isAnimating) {
        [self.view addSubview:_loadingIcon];
        [_loadingIcon startAnimating];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    }
}
-(void)hidenLoadingIcon
{
    if (_loadingIcon.isAnimating) {
        [_loadingIcon stopAnimating];
        [_loadingIcon removeFromSuperview];
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}
#pragma mark - initLoadingIcon
- (void)initLoadingIcon
{
    _loadingIcon = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(9.0f, 9.0f, 32.0f, 32.0f)];
    [_loadingIcon setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    _loadingIcon.center = self.view.center;
    [_loadingIcon stopAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
