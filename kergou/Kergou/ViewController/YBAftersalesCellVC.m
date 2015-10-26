//
//  YBAftersalesCellVC.m
//  Kergou
//
//  Created by 王迎博 on 15/10/10.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBAftersalesCellVC.h"
#import "YBAfterSalesModel.h"
#import "UIImageView+WebCache.h"

@implementation YBAftersalesCellVC


- (void)awakeFromNib
{
    // Initialization code
    
    self.goodInfo.text = @"花王 碧柔biore UV AQUA美白隔离防晒妆前乳/BB霜 SPF50 33g";
    //设置label自动换行
    self.goodInfo.lineBreakMode = NSLineBreakByWordWrapping;
    self.goodInfo.numberOfLines = 0;
    
    if ([self.statusLabel.text isEqualToString:@"退款成功"])
    {
        self.statusLabel.textColor = UIColorFromOXRGB(0x27E0C6);
    }
}




- (void)setModel:(YBAfterSalesModel *)afterSalesModel
{
  
    self.returnGoodsNum.text = afterSalesModel.goodsNumM;
    self.statusLabel.text = afterSalesModel.statusLabelM;
    //设置图片。
    NSString *strUrl = [afterSalesModel.goodsImageUrlM[0] stringByAppendingString:@""];
    [self.goodsImage setImageWithURL:[NSURL URLWithString:strUrl]];
    self.goodInfo.text = afterSalesModel.goodsInfoM;
    self.timeLabel.text = afterSalesModel.timeLabelM;
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
