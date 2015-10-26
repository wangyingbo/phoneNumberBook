//
//  YBModifySecretCodeVC.m
//  Kergou
//
//  Created by 王迎博 on 15/10/10.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBModifySecretCodeVC.h"

@interface YBModifySecretCodeVC ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

@property (weak, nonatomic) IBOutlet UITextField *oldCodeTF;
@property (weak, nonatomic) IBOutlet UITextField *neCodeTF;

@property (weak, nonatomic) IBOutlet UITextField *reNewCodeTF;

@end

@implementation YBModifySecretCodeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    //textfield触摸屏幕空白处退出编辑
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    self.saveButton.tintColor = UIColorFromOXRGB(0x27E0C6);

    self.neCodeTF.placeholder = @"请输入6-20位字符";
    self.reNewCodeTF.placeholder = @"请再次输入新密码";
    
}


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    

}



- (IBAction)saveCode:(id)sender
{
    JPLog(@"替换保存密码");
    
    
}


@end
