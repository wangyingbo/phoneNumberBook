//
//  filterCell.h
//  Kergou
//
//  Created by JiaPin on 15/10/23.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "LogoModel.h"
#import <UIKit/UIKit.h>
@protocol filterCellDelegate<NSObject>



-(void)switchValue:(NSString *)Sv;
-(void)BeginValue:(NSString *)bv;
-(void)EndValue:(NSString *)ev;
-(void)selectLogoValue:(NSString *)brand;

@end
@interface filterCell : UITableViewCell<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *Switch;
@property (weak, nonatomic) IBOutlet UITextField *beginTF;
@property (weak, nonatomic) IBOutlet UITextField *endTF;
@property (weak, nonatomic) IBOutlet UILabel *logoLab;
@property (assign,nonatomic)      id<filterCellDelegate>delegate;
@property (nonatomic,strong)NSArray *logoArr;
@property (nonatomic,strong)NSMutableArray *BtnMArr;
- (IBAction)switchAction:(id)sender;
-(void)configureCellWithArr:(NSArray *)arr;
@end
