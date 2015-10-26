//
//  CheckOutView.h
//  Kergou
//
//  Created by JiaPin on 15/10/13.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CheckOutViewDelegate<NSObject>

-(void)sendOrderBtnClick;
@end

@interface CheckOutView : UIView
@property (assign ,nonatomic) id<CheckOutViewDelegate>delegate;
@end
