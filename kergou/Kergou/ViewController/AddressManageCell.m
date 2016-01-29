//
//  AddressManageCell.m
//  Kergou
//
//  Created by JiaPin on 15/10/12.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "AddressManageCell.h"

@implementation AddressManageCell

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor whiteColor];
}
-(void)configureViewWithBtnStatuesStr:(NSString *)stateStr
{
   
    
    
    [self wanShanViewWithStateStr:stateStr];
  
}
-(void)wanShanViewWithStateStr:(NSString *)stateStr
{
    
    self.cellBtmView.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    
    [self.defaultBtn.layer setMasksToBounds:YES];
    [self.defaultBtn.layer setCornerRadius:3];
    if ([stateStr isEqualToString:@"1"])
    {
        [self.defaultBtn setBackgroundColor:UIColorFromOXRGB(0xff542d)];
    }
    else
    {
        [self.defaultBtn setBackgroundColor:[UIColor whiteColor]];
        [self.defaultBtn.layer setBorderColor:UIColorFromOXRGB(0xff542d).CGColor];
        [self.defaultBtn.layer setBorderWidth:1];
        [self.defaultBtn setTitleColor:UIColorFromOXRGB(0xff542d) forState:UIControlStateNormal];
        
    }
    
    [self.editBtn.layer setMasksToBounds:YES];
    [self.editBtn.layer setCornerRadius:3];
    [self.editBtn.layer setBorderColor:UIColorFromOXRGB(0xff542d).CGColor];
    [self.editBtn.layer setBorderWidth:1];
    [self.editBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.editBtn setBackgroundColor:[UIColor clearColor]];
    
    [self.deleteBtn.layer setMasksToBounds:YES];
    [self.deleteBtn.layer setCornerRadius:3];
    [self.deleteBtn.layer setBorderColor:UIColorFromOXRGB(0xff542d).CGColor];
    [self.deleteBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [self.deleteBtn.layer setBorderWidth:1];
    [self.deleteBtn setBackgroundColor:[UIColor clearColor]];
    
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)defaultBtnClick:(UIButton *)sender {
}

- (IBAction)editBtnClick:(UIButton *)sender
{
    if (_delegate&&[_delegate respondsToSelector:@selector(editBtnClickToEditAddress)]) {
        [self.delegate editBtnClickToEditAddress];
    }

}

- (IBAction)deleteBtnClick:(UIButton *)sender {
}
@end
