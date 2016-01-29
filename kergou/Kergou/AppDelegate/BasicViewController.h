//
//  BasicViewController.h
//  Kergou
//
//  Created by JiaPin on 15/8/20.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasicViewController : UIViewController

@property(nonatomic,strong)UIActivityIndicatorView *loadingIcon;

-(void)showWaitingView;
-(void)hidenWatingView;
-(void)showWaitingViewWithText:(NSString *)waitingText;
-(void)showLoadingIcon;
-(void)hidenLoadingIcon;
-(void)showWaitingResultWithWaitingText:(NSString *)waitingText afterDelay:(NSTimeInterval)delay;
-(void)showLoginViewController;





@end
