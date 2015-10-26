//
//  ShoppingCarCell.h
//  Kergou
//
//  Created by JiaPin on 15/9/22.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "ShopCarListModel.h"
#import <UIKit/UIKit.h>

@interface ShoppingCarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerIMV;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *jianBtn;

@property (weak, nonatomic) IBOutlet UILabel *goodsDescribeLab;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLab;

@property (weak, nonatomic) IBOutlet UIImageView *goodsImageIMV;


- (IBAction)jianBtnClick:(id)sender;
- (IBAction)addBtnClick:(id)sender;
-(void)configureCellWithModel:(ShopCarListModel *)model;
@property (weak, nonatomic) IBOutlet UIButton *loseFunBtn;

@end
