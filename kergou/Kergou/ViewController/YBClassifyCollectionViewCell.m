//
//  YBCollectionViewCell.m
//  Kergou
//
//  Created by 王迎博 on 15/9/24.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBClassifyCollectionViewCell.h"
#import "UIImageView+WebCache.h"


@implementation YBClassifyCollectionViewCell

- (void)awakeFromNib
{
    self.cellLabel.layer.cornerRadius = 5;
    
}

- (void)setData:(YBCellModel *)cellModel
{
    self.cellLabel.text = cellModel.category_name;
    [self.cellImage setImageWithURL:[NSURL URLWithString:cellModel.icon]];
    
    
}


@end
