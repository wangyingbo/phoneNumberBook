//
//  LogInVC.m
//  Kergou
//
//  Created by JiaPin on 15/10/9.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "NSString+MD5HexDigest.h"
#import "LogInVC.h"
#define  LOGIN_URL @"/app/logon"
@interface LogInVC ()
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITextField *accountNumTF;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;


- (IBAction)cancleLogInBtnClick:(UIButton *)sender;
- (IBAction)logInBtnClick:(UIButton *)sender;

@end

@implementation LogInVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.headerView.backgroundColor = UIColorFromOXRGB(0xf1f1f1);
     JPLog(@"----DEVICE_ID = %@",DEVICE_ID);
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

- (IBAction)cancleLogInBtnClick:(UIButton *)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)logInBtnClick:(UIButton *)sender
{
    NSMutableDictionary *postMdic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    NSString *PassWordStr = _passwordTF.text;
    
    [postMdic setObject:_accountNumTF.text forKey:@"username"];
    [postMdic setObject:[PassWordStr md5HexDigest] forKey:@"password"];
    [postMdic setObject:@"check_login" forKey:@"login_flag"];
    
    [postMdic setObject:DEVICE_ID forKey:@"kergo_uniq"];
    
    [NetWorkRequest PostDataViewController:self BaseUrl:BASEURL_GOODS Funtioname:LOGIN_URL Parameter:postMdic Success:^(id responseObject)
    {
        
        
        
        
    } LoadFailed:^(NSError *error) {
        
    } haveNONetWork:^{
        
    }];
    
}
@end
