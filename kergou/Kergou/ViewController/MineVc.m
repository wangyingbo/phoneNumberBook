//
//  MineVc.m
//  Kergou
//
//  Created by JiaPin on 15/10/9.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "SelectVC.h"
#import "AddressManage.h"
#import "MineBtmCell.h"
#import "MineCell.h"
#import "MineVc.h"
#import "OderDetailVC.h"
@interface MineVc ()<MineCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (strong,nonatomic) NSArray *titleArr;
@property (strong,nonatomic) NSMutableArray *imageArr;
@property (weak, nonatomic) IBOutlet UIImageView *headerIMV;
@property (weak, nonatomic) IBOutlet UIButton *logInBtn;
@property (weak, nonatomic) IBOutlet UIButton *resiterBtn;


@end

@implementation MineVc

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.titleArr = @[@"我的收藏",@"实名认证",@"地址管理",@"客服电话",@"帮助中心"];
    
    self.imageArr = [[NSMutableArray alloc]initWithCapacity:0];
    
    for (int i=0; i<5; i++)
    {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+101]];
        [_imageArr addObject:image];
 
    }
   
    
    [self wanShanView];
    
}
-(void)wanShanView
{
    
    [self.headerIMV.layer setMasksToBounds:YES];
    [self.headerIMV.layer setCornerRadius:20];
    self.headerIMV.image = [UIImage imageNamed:@"touxiang.png"];
    [self.logInBtn setTitleColor:UIColorFromOXRGB(0x22c0a9) forState:UIControlStateNormal];
    [self.logInBtn.layer setMasksToBounds:YES];
    [self.logInBtn.layer setCornerRadius:4];
    
    [self.resiterBtn setBackgroundColor:[UIColor clearColor]];
    [self.resiterBtn.layer setMasksToBounds:YES];
    [self.resiterBtn.layer setCornerRadius:4];
    [self.resiterBtn.layer setBorderWidth:0.5];
    [self.resiterBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.resiterBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
      return 110;
    }
    else
    {
        return 45;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 20;
    }
    
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1 ;
    }
    else
    {
        return 5;
    }
   
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
      
        
        if (indexPath.row == 0)
        {
            SelectVC *vc=  (SelectVC *) [PublicMethod getVCByStoryboardID:@"SelectSB" andWithSBName:@"Main"];
            [self.navigationController pushViewController:vc animated:YES];
        }
       
        if (indexPath.row == 2)
        {
            AddressManage *vc=  (AddressManage *) [PublicMethod getVCByStoryboardID:@"AdressManageSB" andWithSBName:@"Main"];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        if (indexPath.row == 3)
        {
            NSString *allStr = [NSString stringWithFormat:@"400100111"];
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:allStr]];
        }
                

        
        
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        MineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineCell" forIndexPath:indexPath];
        cell.delegate = self;
        
        return cell;
    }
    else
    {
        MineBtmCell *cell;
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"MineBtmCell" owner:nil options:nil];
        for (id obj in nibs)
        {
            if ([obj isKindOfClass:[MineBtmCell class]])
            {
                cell = (MineBtmCell *)obj;
                cell.nameLable.text = _titleArr[indexPath.row];
                cell.headerImgView.image = _imageArr[indexPath.row];
                cell.phoneNumLab.hidden = YES;
                if (indexPath.row == 3) {
                     cell.phoneNumLab.hidden = NO;
                }

            }
            
        }
        
        return cell;

        
    }
    
}
-(void)oderDetailBtnClick:(NSInteger)btnTag
{
     JPLog(@"----btnTag = %ld",(long)btnTag);
    
    OderDetailVC *vi =  (OderDetailVC *) [PublicMethod getVCByStoryboardID:@"oderdetaiSB" andWithSBName:@"Main"];
    vi.stateNum = btnTag;
    [self.navigationController pushViewController:vi animated:YES];
    
    
    
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
