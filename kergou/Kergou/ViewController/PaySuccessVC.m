//
//  PaySuccessVC.m
//  Kergou
//
//  Created by JiaPin on 15/10/10.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "PaySuccessVC.h"

@interface PaySuccessVC ()
@property (weak, nonatomic) IBOutlet UIImageView *headerView;

@end

@implementation PaySuccessVC

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    
    [self initView];
    
}

-(void)initView
{
    NSArray *strArr = @[@"订单号：123456789",@"订单号：123456789",@"订单号：123456789",@"订单号：123456789"];
    
    float y = self.headerView.frame.origin.y+self.headerView.frame.size.height;
    UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0,y , IPHONE_WITH,  14*(strArr.count+1)+12*strArr.count+51)];
    vi.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i<strArr.count; i++)
    {
        UILabel *oderLab = [[UILabel alloc]initWithFrame:CGRectMake(20,14*(i+1)+12*i, 140, 12)];
        oderLab.text = strArr[i];
        oderLab.font = [UIFont fontWithName:nil size:14];
        
        [vi addSubview:oderLab];
        
    }
    
    UIImageView *lineImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    lineImgView.frame = CGRectMake(7, 14*(strArr.count+1)+12*strArr.count, IPHONE_WITH-14, 1);
    lineImgView.backgroundColor = [UIColor redColor];
    
    
    UILabel *payMoneyLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 14*(strArr.count+1)+12*strArr.count+11, 125, 18)];
    payMoneyLab.font = [UIFont fontWithName:nil size:14];
    payMoneyLab.text = @"支付金额：¥119.0";
    [vi addSubview:payMoneyLab];
    
    UIImageView *lineImgView2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    lineImgView2.frame = CGRectMake(7, 14*(strArr.count+1)+12*strArr.count+70-32, IPHONE_WITH-14, 1);
    lineImgView2.backgroundColor = [UIColor redColor];
    
    UIImageView *lineImgView3 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@""]];
    lineImgView3.frame = CGRectMake(0, 14*(strArr.count+1)+12*strArr.count+83-32, IPHONE_WITH, 1);
    lineImgView3.backgroundColor = [UIColor redColor];
    
    
    
    [vi addSubview:lineImgView];
    [vi addSubview:lineImgView2];
    [vi addSubview:lineImgView3];
    
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(30,vi.frame.origin.y+vi.frame.size.height+15,100, 35);
    [leftBtn setTitle:@"继续购物" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [leftBtn setBackgroundColor:UIColorFromOXRGB(0xef703d)];
    leftBtn.titleLabel.font = [UIFont fontWithName:nil size:14];
    [self.view addSubview:leftBtn];
    
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(IPHONE_WITH-30-100, vi.frame.origin.y+vi.frame.size.height+15,100, 35);
    [rightBtn setTitle:@"查看订单列表" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightBtn setBackgroundColor:UIColorFromOXRGB(0xef703d)];
    rightBtn.titleLabel.font = [UIFont fontWithName:nil size:14];
    [self.view addSubview:rightBtn];
    
    
    
    
    
    
    
    
    [self.view addSubview:vi];
    
    
    
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
