//
//  ResiterVC.m
//  Kergou
//
//  Created by JiaPin on 15/10/9.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "ResiterVC.h"

#define TIME  11
#define GET_CODE_URL @"/app/user_captcha"
#define REGISTER_URL @"/app/register"
@interface ResiterVC ()
{
    BOOL _isFirstClick;
    NSTimer *_timer;
    NSInteger _countNum;
    
}
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTF;

@property (weak, nonatomic) IBOutlet UIButton *resiterBtn;
@property (weak, nonatomic) IBOutlet UIButton *readProtocolBtn;

@property (weak, nonatomic) IBOutlet UITextField *password1;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;

@property (weak, nonatomic) IBOutlet UITextField *password2;




- (IBAction)readProtocolBtnClick:(UIButton *)sender;


- (IBAction)getCodeBtnClick:(id)sender;
- (IBAction)resiterBtnClick:(id)sender;
- (IBAction)cancleBtnClick:(UIButton *)sender;
- (IBAction)backToLoginVCBtnClick:(id)sender;
@end

@implementation ResiterVC
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (_timer.isValid)
    {
        [_timer invalidate];
    }
    _timer = nil;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _countNum = TIME;
   
   
    
    
    _isFirstClick = YES;
    [self wanShanView];
    
    
    // Do any additional setup after loading the view.
}
- (IBAction)getCodeBtnClick:(id)sender
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(TimeOutSecond:) userInfo:nil repeats:YES];
    
    _timer.fireDate = [NSDate distantPast];
    
    
    
    NSMutableDictionary *postMDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    [postMDic setObject:@"RegisterSms" forKey:@"mod"];
    [postMDic setObject:_phoneNumTF.text forKey:@"address"];
    
    [NetWorkRequest PostDataViewController:self BaseUrl:BASEURL_GOODS Funtioname:GET_CODE_URL Parameter:postMDic Success:^(id responseObject)
     {
         
         
     } LoadFailed:^(NSError *error)
    {
         
     } haveNONetWork:^{
         
     }];
    
    
}

-(void)TimeOutSecond:(NSTimer *)timer
{
    _countNum--;
    if (_countNum != 0)
    {
        [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%d",_countNum] forState:UIControlStateNormal];
        [self.getCodeBtn setBackgroundColor:UIColorFromOXRGB(0xf8f8f8)];
        self.getCodeBtn.userInteractionEnabled = NO;
    }
    else
    {
        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.getCodeBtn setBackgroundColor:[UIColor whiteColor]];
        self.getCodeBtn.userInteractionEnabled = YES;
        _countNum = TIME;
        _timer.fireDate = [NSDate distantFuture];
    }
    
    
}
-(void)wanShanView
{
    self.headerView.backgroundColor = UIColorFromOXRGB(0xf1f1f1);
    [self.getCodeBtn.layer setBorderWidth:0.5];
    [self.getCodeBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    self.resiterBtn.backgroundColor = UIColorFromOXRGB(0xcccccc);
    self.resiterBtn.titleLabel.font = [UIFont fontWithName:nil size:14];
    [self.readProtocolBtn setImage:[UIImage imageNamed:@"weixuanzhong.png"] forState:UIControlStateNormal];
    self.resiterBtn.userInteractionEnabled = NO;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)cancleBtnClick:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)readProtocolBtnClick:(UIButton *)sender
{
    if (_isFirstClick)
    {
        [self.readProtocolBtn setImage:[UIImage imageNamed:@"xuanzhongzhuce.png"] forState:UIControlStateNormal];
        _isFirstClick = NO;
        
        [self.resiterBtn setTitle:@"完成" forState:UIControlStateNormal];
        [self.resiterBtn setBackgroundColor:UIColorFromOXRGB(0xee713b)];
        self.resiterBtn.userInteractionEnabled = YES;
    }
    else
    {
         [self.readProtocolBtn setImage:[UIImage imageNamed:@"weixuanzhong.png"] forState:UIControlStateNormal];
         [self.resiterBtn setTitle:@"注册" forState:UIControlStateNormal];
        [self.resiterBtn setBackgroundColor:UIColorFromOXRGB(0xcccccc)];
        _isFirstClick = YES;
        self.resiterBtn.userInteractionEnabled = NO;
    }
   
}

- (IBAction)resiterBtnClick:(id)sender
{
    if (![_password1.text isEqualToString:_password2.text])
    {
        SHOW_ALTER(@"嘿嘿，您两次输入的密码不一致啊！");
    }
    
    NSMutableDictionary *postMDic = [[NSMutableDictionary alloc]initWithCapacity:0];
     JPLog(@"----_phoneNumTF.text = %@ ----_codeTF= %@----_password1= %@",_phoneNumTF.text,_codeTF.text,_password1);
    [postMDic setObject:_phoneNumTF.text forKey:@"username"];
    [postMDic setObject:_codeTF.text forKey:@"mobileCode"];
    [postMDic setObject:_password1.text forKey:@"password"];
    [postMDic setObject:@"1" forKey:@"reg_from"];
    
    
    
    [NetWorkRequest PostDataViewController:self BaseUrl:BASEURL_GOODS Funtioname:REGISTER_URL Parameter:postMDic Success:^(id responseObject)
    {
       
        
        
        
        
    } LoadFailed:^(NSError *error) {
        
    } haveNONetWork:^{
        
    }];
    
    
}

- (IBAction)backToLoginVCBtnClick:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
