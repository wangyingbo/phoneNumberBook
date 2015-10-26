//
//  TransportView.h
//  Kergou
//
//  Created by JiaPin on 15/9/29.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TransportView : UIView
{
    NSArray     *_lableArr;
}
@property (nonatomic,strong) NSArray *lableArr;
-(id)initWithFrame:(CGRect)frame andWithArr:(NSArray *)arr;
@end
