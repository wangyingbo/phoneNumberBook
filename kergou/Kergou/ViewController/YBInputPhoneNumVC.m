//
//  YBInputPhoneNumVC.m
//  Kergou
//
//  Created by 王迎博 on 15/10/10.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBInputPhoneNumVC.h"
#import "YBVerificationCodeVC.h"
#import "NSMutableDictionary+defaultDic.h"


//static const int iPhoneNumLength = 11;

@interface YBInputPhoneNumVC ()
@property (weak, nonatomic) IBOutlet UITextField *telNumTF;
@property (weak, nonatomic) IBOutlet UIButton *nextStepBtn;

@end

@implementation YBInputPhoneNumVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    //自定义返回按钮的文字
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;

    //textfield触摸屏幕空白处退出编辑
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
    //设置输入电话号码时为纯数字键盘
    self.telNumTF.keyboardType = UIKeyboardTypeNumberPad;
    
    
    
}

//点击按钮时，验证手机号码的正确性，然后出发发送验证码的方法。
- (IBAction)pushBtn:(UIButton *)sender
{
        //JPLog(@"%@",self.telNumTF.text);//接收textField输入的值
   BOOL isMatch =  [PublicMethod checkTelNum:self.telNumTF.text];
    

    if (isMatch) {
        
        [self sendVertifyNum];
        [self gotoNextVC];
    }
    
}

//点击页面退出编辑方法
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}



//写发送验证码的方法,以下为注册时发送验证码的接口。
- (void)sendVertifyNum
{
    
    NSMutableDictionary *postMDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    [postMDic setObject:@"RegisterSms" forKey:@"mod"];
    [postMDic setObject:self.telNumTF.text forKey:@"address"];
    
    [NetWorkRequest PostDataViewController:self BaseUrl:BASEURL Funtioname:KsendVertifyNumURL Parameter:postMDic Success:^(id responseObject)
     {
         
         
     } LoadFailed:^(NSError *error)
     {
         
     } haveNONetWork:^{
         
     }];
    
}





//跳转到下级页面.
-(void)gotoNextVC
{
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"YBClassify" bundle:nil];
        UIViewController *vc = [storyBoard instantiateViewControllerWithIdentifier:@"setCode"];
        [self.navigationController pushViewController:vc animated:YES];
  
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //JPLog(@"源controller = %@",[segue sourceViewController]);
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    

}

@end
