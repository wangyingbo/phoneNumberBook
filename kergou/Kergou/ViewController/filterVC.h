//
//  filterVC.h
//  Kergou
//
//  Created by JiaPin on 15/10/23.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "BasicViewController.h"
@protocol filterVCDelegate <NSObject>
-(void)selectValueWithSV:(NSString *)sv withBeginValue:(NSString *)bv withEndValue:(NSString *)ev withLogoValue:(NSString *)lv;
@end
@interface filterVC : BasicViewController
@property (nonatomic,strong)NSArray *logoArr;
@property (nonatomic,assign)id <filterVCDelegate>delegated;
@end
