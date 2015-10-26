//
//  YBMyCollectionVC.m
//  Kergou
//
//  Created by 王迎博 on 15/10/9.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBMyCollectionVC.h"
#import "IndexPageVC.h"


@interface YBMyCollectionVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageW;
@end

@implementation YBMyCollectionVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.imageH.constant = 135.0*FULL_SCREEN_HEIGHT/667;
    self.imageW.constant = 145.0*FULL_SCREEN_WIDTH/375;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    

}

- (IBAction)goHome:(UIButton *)sender
{
    //去首页逛逛。
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    IndexPageVC *home = [storyBoard instantiateViewControllerWithIdentifier:@"indexPageSB"];
    [self.navigationController pushViewController:home animated:YES];

}

@end
