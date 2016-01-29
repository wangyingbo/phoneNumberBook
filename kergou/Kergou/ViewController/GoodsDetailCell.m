//
//  GoodsDetailCell.m
//  Kergou
//
//  Created by JiaPin on 15/10/23.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "GoodsDetailCell.h"

@implementation GoodsDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)configureCellWithBrandInfo:(NSString *)brandStr withCellHeight:(float)height
{
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, IPHONE_WITH-40, height)];
    
    lab.text = brandStr;
    
    lab.font = FONT_SIZE(13);
    
    lab.lineBreakMode = NSLineBreakByTruncatingTail;
    
    lab.numberOfLines = 0;
    
    [self addSubview:lab];
    
    
    
    
    
}
-(void)configureCellWithNormalQuestion:(UIImage *)image
{
   
    UIImageView *imgView = [[UIImageView alloc]initWithImage:image];
    imgView.frame = CGRectMake(0, 0, IPHONE_WITH, image.size.height);
    
    [self addSubview:imgView];

    
    
}
-(void)configureCellWithImgArr:(NSArray *)imgArr
{
    float h= 0.0f;
    for (int i = 0;i<imgArr.count;i++)
    {
        UIImage *img = imgArr[i];
        
        UIImageView *IMV = [[UIImageView alloc]initWithImage:img];

        if (i==0)
        {
            IMV.frame = CGRectMake(0, 0, IPHONE_WITH, img.size.height);
            h= img.size.height;
        }
        else
        {
          
         IMV.frame = CGRectMake(0,h, IPHONE_WITH, img.size.height);
         h=h+img.size.height;
        }
       
        
        [self addSubview:IMV];
    }
   
    
    
}

@end
