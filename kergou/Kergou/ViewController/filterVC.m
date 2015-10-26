//
//  filterVC.m
//  Kergou
//
//  Created by JiaPin on 15/10/23.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "filterCell.h"
#import "filterVC.h"

@interface filterVC ()<filterCellDelegate>
@property (weak, nonatomic) IBOutlet UIView *navagationView;
@property (nonatomic,strong)    NSString *switchValue;
@property (nonatomic,strong)    NSString *beginValue;
@property (nonatomic,strong)    NSString *endValue;
@property (nonatomic,strong)    NSString *logoValue;
- (IBAction)OKBtnClick:(id)sender;

- (IBAction)cancleBtnClick:(id)sender;


@end

@implementation filterVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navagationView.backgroundColor = UIColorFromOXRGB(0xf1f1f1);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark --- tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 460/2+_logoArr.count*55/3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *IDStr = @"filterID";
    
    filterCell  *cell = [tableView dequeueReusableCellWithIdentifier:IDStr];
    
    if (!cell)
    {
        cell = [[filterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:IDStr];
    }
    cell.delegate = self;
    [cell configureCellWithArr:_logoArr];
  
    return cell;
}

#pragma mark - filterCellDelegate

-(void)switchValue:(NSString *)Sv
{
    self.switchValue = Sv;
}
-(void)BeginValue:(NSString *)bv
{
    self.beginValue = bv;
}
-(void)EndValue:(NSString *)ev
{
    self.endValue = ev;
}
-(void)selectLogoValue:(NSString *)brand
{
    self.logoValue = brand;
    
}

- (IBAction)OKBtnClick:(id)sender
{
    if (_delegated&&[_delegated respondsToSelector:@selector(selectValueWithSV:withBeginValue:withEndValue:withLogoValue:)])
    {
        [self.delegated selectValueWithSV:_switchValue withBeginValue:_beginValue withEndValue:_endValue withLogoValue:_logoValue];
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancleBtnClick:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}
@end
