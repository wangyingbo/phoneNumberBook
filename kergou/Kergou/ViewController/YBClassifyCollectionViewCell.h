//
//  YBCollectionViewCell.h
//  Kergou
//
//  Created by 王迎博 on 15/9/24.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBCellModel.h"


@interface YBClassifyCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellLabel;


- (void)setData:(YBCellModel *)cellModel;

@end
