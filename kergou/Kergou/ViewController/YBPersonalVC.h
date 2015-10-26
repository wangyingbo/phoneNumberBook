//
//  PersonalVC.h
//  Kergou
//
//  Created by 王迎博 on 15/9/28.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface YBPersonalVC : UIViewController<UITabBarControllerDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDelegate>

@property (nonatomic,strong)UIPickerView *myPicker;
@property (nonatomic,strong)UIDatePicker *myDatePicker;

@property (nonatomic,retain)NSMutableDictionary *states;
@property (nonatomic,retain)NSArray *dataArray;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;

- (void)setupArray;


@end
