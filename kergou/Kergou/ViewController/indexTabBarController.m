//
//  indexTabBarController.m
//  Kergou
//
//  Created by JiaPin on 15/9/30.
//  Copyright (c) 2015年 张帅. All rights reserved.

#import "indexTabBarController.h"

@interface indexTabBarController ()

@end

@implementation indexTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
   
}
-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    if ([item.title isEqualToString:@"购物车"])
    {
        
    }
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
