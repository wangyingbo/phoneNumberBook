//
//  YBClassifyTabBarVC.m
//  Kergou
//
//  Created by 王迎博 on 15/9/24.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBClassifyTabBarVC.h"

@interface YBClassifyTabBarVC ()

@end

@implementation YBClassifyTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.frame = CGRectMake(0, 0, self.tabBar.frame.size.width, self.tabBar.frame.size.height);
    
//    [self.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                             [UIColor whiteColor], NSForegroundColorAttributeName,
//                                             [NSValue valueWithUIOffset:UIOffsetMake(0,0)], NSShadowAttributeName,
//                                             [UIFont systemFontOfSize:20], NSFontAttributeName, nil]
//                                   forState:UIControlStateNormal];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
