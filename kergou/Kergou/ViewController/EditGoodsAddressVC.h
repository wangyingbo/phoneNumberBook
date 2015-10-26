//
//  EditGoodsAddressVC.h
//  Kergou
//
//  Created by JiaPin on 15/10/12.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditGoodsAddressVC : UIViewController
@property (nonatomic,strong) NSString  *statuesStr;
@property (weak, nonatomic) IBOutlet UITextField *customerName;
@property (weak, nonatomic) IBOutlet UIButton *customerArea;

@property (weak, nonatomic) IBOutlet UITextField *customerPhoneNum;
;
@property (weak, nonatomic) IBOutlet UITextField *coustomerAddress;
;
@property (weak, nonatomic) IBOutlet UIImageView *arrowIMV;

@property (weak, nonatomic) IBOutlet UIButton *defaultAddressBtn;
- (IBAction)customerAreaClick:(UIButton *)sender;

- (IBAction)defaultAddressBtnClick:(UIButton *)sender;


@end
