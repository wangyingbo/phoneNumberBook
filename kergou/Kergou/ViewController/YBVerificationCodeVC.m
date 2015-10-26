//
//  YBVerificationCodeVC.m
//  Kergou
//
//  Created by 王迎博 on 15/10/10.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBVerificationCodeVC.h"

@interface YBVerificationCodeVC ()

{
    NSInteger timeTick;
    NSInteger timeTickAgain;
    NSTimer *timer;
    NSTimer *timerAgain;
}

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verifyTextFieldW;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *verifyBtnW;


@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
@property (weak, nonatomic) IBOutlet UITextField *verifyNumTF;
@property (nonatomic,strong) UILabel *timeLabel;
@property (nonatomic,strong) UIView *timeView;

@property (weak, nonatomic) IBOutlet UITextField *codeNew;
@property (weak, nonatomic) IBOutlet UITextField *codeReNew;
@property (weak, nonatomic) IBOutlet UIButton *resetCode;
@end


@implementation YBVerificationCodeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.verifyBtn.hidden = YES;
    self.verifyTextFieldW.constant = 345*Adopt_Device_iPhone6_Width;
    
    //resetCode按钮的 可点击和背景色属性 当textField判断有内容时再设置
    self.resetCode.enabled = NO;
    self.resetCode.backgroundColor = UIColorFromOXRGB(0xB2B2B2);

    
    //x和y无效，x都是0，而y是根据高度来自动调整的。即高度如果超过textField则默认是textField高，如小于textField高度，则上下居中显示。唯一有效的就是宽度
    self.timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 44)];
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 80, 44)];
    //self.timeView.backgroundColor = [UIColor grayColor];
    //self.timeLabel.backgroundColor = [UIColor redColor];
    UIView *viewV = [[UIView alloc]initWithFrame:CGRectMake(7, 14, 2, 16)];
    viewV.backgroundColor = [UIColor grayColor];
    [self.timeView addSubview:viewV];
    [self.timeView addSubview:self.timeLabel];
   
    //在textField设置textField的rightview
    self.verifyNumTF.rightView = self.timeView;
    self.verifyNumTF.rightViewMode = UITextFieldViewModeAlways;
    
    
    //设置密文输入，就是和输入密码时类似的显示为小圆点,也可以在storyboard里勾选
    //self.codeNew.secureTextEntry = YES;
    //self.codeReNew.secureTextEntry = YES;
    
    //textfield触摸屏幕空白处退出编辑
    //注意：如果是最xcode6下的模拟器的话，默认是不调出软键盘的，按CMD+K可以调出，或者在菜单Hardware里地Keyboard里设置
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    
    //设置输入验证码时为纯数字键盘
    //self.verifyNumTF.keyboardType = UIKeyboardTypeNumberPad;
    
    
    self.codeNew.clearsOnBeginEditing = NO;
    self.codeNew.clearsOnInsertion = NO;
    self.codeReNew.clearsOnInsertion = NO;

    
    
    [self countDown];
    
    
}




//-------------------------------跳转进来的倒计时---------------------------------
- (void)countDown
{
    timeTick = 31;//30s倒计时
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethod) userInfo:nil repeats:YES];

}

- (void)timeFireMethod
{
    
    //计时器自减
    timeTick--;
    
    //计时器显示在label上
    self.timeLabel.text = [NSString stringWithFormat:@"%d秒后重发",timeTick];
    self.timeLabel.textColor = [UIColor grayColor];
    self.timeLabel.font = [UIFont systemFontOfSize:13];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    //计时结束激发动作
    if (timeTick == 0)
    {
        [timer invalidate];
        /*
         *****************步骤*****************
         倒计时走完，
        隐藏掉右边的倒计时，
        改变self.verifyTextFieldW.constant宽度,
        显示出来“重新发送验证码”按钮；
         */
        
        self.timeView.hidden = YES;
        
        self.verifyTextFieldW.constant = 210*Adopt_Device_iPhone6_Width;
        self.verifyBtnW.constant = 120*Adopt_Device_iPhone6_Width;
        self.verifyBtn.hidden = NO;
        self.verifyBtn.backgroundColor = UIColorFromOXRGB(0x21C1AA);
        
    }
    
    //当 两个textField内容不为空时，且两个内容相等时，设置resetCode按钮的背景色属性和可点击属性。
    //因此需要每隔一秒检查一下两个textField的text的值，这样激发事件。
    NSInteger timeAll;
    NSTimer *timeInvail;
    timeAll = 100000;
    timeInvail = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(judge) userInfo:nil repeats:YES];

}

- (void)judge
{
    if (self.codeNew.text.length > 0 && self.codeReNew.text.length > 0 && self.verifyNumTF.text.length > 0)
    {
        
        //此resetCode按钮的可点击属性和背景色属性,当判断textField里有内容时才可以被设置
        self.resetCode.backgroundColor = UIColorFromOXRGB(0xEF703C);
        self.resetCode.enabled = YES;
        
        [self.resetCode addTarget:self action:@selector(resetCodeDo:) forControlEvents:UIControlEventTouchDown];
        
    }
}




//-------------------------------重新发送验证码的倒计时---------------------------------
//设置重新发送后的倒计时。
- (IBAction)reGetVerifyNum:(UIButton *)sender
{
    //SHOW_ALTER(@"验证码已重新发送，如未收到验证码，请返回上页校对您的手机号");
    [self countDownAgain];
    
}

- (void)countDownAgain
{
    timeTickAgain = 31;
    timerAgain = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeFireMethodAgain) userInfo:nil repeats:YES];
}

- (void)timeFireMethodAgain
{
    timeTickAgain--;
    NSString *str = [NSString stringWithFormat:@"%ld",(long)timeTickAgain];
    [self.verifyBtn setTitle: str forState: UIControlStateNormal];
    if (timeTickAgain == 0) {
        [timerAgain invalidate];
        [self.verifyBtn setTitle: @"重新获取验证码" forState: UIControlStateNormal];
    }

}




-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}






- (IBAction)resetCodeDo:(UIButton *)sender
{
    
    if (self.verifyNumTF.text.length == VerifiyNumLength)
    {
         if (self.codeNew.text.length>5 && self.codeNew.text.length<20 && self.codeReNew.text.length>5 && self.codeReNew.text.length<20)
         {
             if ([self.codeNew.text isEqualToString:self.codeReNew.text])
             {
                 //1、从网络请求验证码数据
                 
                 
                 
                 
                 //2、判断输入的验证码与后台返回的验证码是否一致
                 if (YES)
                 {
                     //3、需要上传密码到服务器,更换密码
                     SHOW_ALTER(@"新密码设置成功，请重新登录");
                     
                     
                     
                     
                     
                     
                     
                 }
                 else
                 {
                     SHOW_ALTER(@"验证码验证错误！");
                 }
             }
             else
             {
                 SHOW_ALTER(@"两次密码不一样，请输入相同的密码");
             }
         }
         else
         {
          SHOW_ALTER(@"请输入6-20个字符的密码");
         }
    }
    else
    {
        SHOW_ALTER(@"请输入正确的验证码");
    }
    
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    

}



@end
