//
//  SearchConfirmView.h
//  Kergou
//
//  Created by JiaPin on 15/10/13.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchConfirmViewDelegate<NSObject>
-(void)ChoseNationBtnClick:(NSString *)nationName;
@end
@interface SearchConfirmView : UIView
@property (strong,nonatomic) NSMutableArray   *btnMArr;
@property (strong,nonatomic) NSMutableArray   *IMVMArr;
@property (strong,nonatomic) NSArray   *countryModelArr;
@property (strong,nonatomic) NSMutableArray   *countryNameArr;
@property (strong,nonatomic) NSMutableArray   *countryIDArr;
@property (assign,nonatomic) id<SearchConfirmViewDelegate>delegate;

-(void)configureDataWithArr:(NSArray *)arr;
@end
