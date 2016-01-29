//
//  AddressManageCell.h
//  Kergou
//
//  Created by JiaPin on 15/10/12.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AddressManageCellDelegate <NSObject>

-(void)editBtnClickToEditAddress;

@end
@interface AddressManageCell : UITableViewCell
-(void)configureViewWithBtnStatuesStr:(NSString *)stateStr;
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@property (weak, nonatomic) IBOutlet UIView *cellBtmView;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (nonatomic,assign)id<AddressManageCellDelegate>delegate;
- (IBAction)defaultBtnClick:(UIButton *)sender;
- (IBAction)editBtnClick:(UIButton *)sender;
- (IBAction)deleteBtnClick:(UIButton *)sender;

@end
