//
//  YBCountryFooterView.h
//  Kergou
//
//  Created by 王迎博 on 15/9/25.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>
//
//@class YBCountryFooterView;
//@protocol YBCountryFooterViewDelegate <NSObject>
//
//- (void)reloadFooterViewData:(YBCountryFooterView *)footerView;
//
//@end


@interface YBCountryFooterView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *footerButton;


//- (void)defButtonWithSelector:(UIButton *)button;
//- (void)buttonPressed:(UIButton *)button;

@end



//UIButton *button = (UIButton *)sender;
//button.selected = !button.selected;