//
//  filterCell.m
//  Kergou
//
//  Created by JiaPin on 15/10/23.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "filterCell.h"

@implementation filterCell

- (void)awakeFromNib
{
    self.BtnMArr = [[NSMutableArray alloc]initWithCapacity:0];
    // Initialization code
    [self wanShanView];
}
-(void)wanShanView
{
    UIView *lineView1 = [PublicMethod getLineViewWithFrame:CGRectMake(14, self.Switch.frame.origin.y+35, IPHONE_WITH, 0.5)];
    [self addSubview:lineView1];
    UIView *lineView2 = [PublicMethod getLineViewWithFrame:CGRectMake(14, self.beginTF.frame.origin.y+35, IPHONE_WITH, 0.5)];
    [self addSubview:lineView2];
    
    UIView *lineView3 = [PublicMethod getLineViewWithFrame:CGRectMake(14, self.logoLab.frame.origin.y+28, IPHONE_WITH, 0.5)];
    [self addSubview:lineView3];

    self.beginTF.tag = 20000;
    self.endTF.tag = 30000;
    [self.beginTF setReturnKeyType:UIReturnKeyDone];
     [self.endTF setReturnKeyType:UIReturnKeyDone];
    self.beginTF.delegate = self;
    self.endTF.delegate = self;
    
}
- (IBAction)switchAction:(id)sender
{
    UISwitch *swithButton = (UISwitch *)sender;
    NSInteger isButtonOn = [swithButton isOn];
    
    if (_delegate&&[_delegate respondsToSelector:@selector(switchValue:)])
    {
    
        [self.delegate   switchValue:[NSString stringWithFormat:@"%d",isButtonOn]];
    }

    
    
  
}

-(void)configureCellWithArr:(NSArray *)arr
{
    self.logoArr = arr;
    
    [self initViews];
    
}
-(void)initViews
{
    float k = (IPHONE_WITH-[PublicMethod PictureViewAdaptHeight:102]*3)/4;
    
    float h = 0.0;
    for (int i = 0; i<_logoArr.count; i++)
    {
        
        LogoModel *model = _logoArr[i];
         JPLog(@"----model = %@",model.brand_name);
        NSInteger w = i/3;
        NSInteger r = i%3;
        JPLog(@"----w = %ld",(long)w);
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(k*(r+1)+[PublicMethod PictureViewAdaptHeight:102]*r,_beginTF.frame.origin.y+98+(17+[PublicMethod PictureViewAdaptHeightChange:40])*w,[PublicMethod PictureViewAdaptHeight:102],[PublicMethod PictureViewAdaptHeightChange:40]);
        [btn setTitleColor:UIColorFromOXRGB(0xef703c) forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont fontWithName:nil size:14];
        [btn.layer setMasksToBounds:YES];
        btn.tag = 2000+i;
        [btn.layer setCornerRadius:3];
        [btn.layer setBorderWidth:1];
        [btn.layer setBorderColor:UIColorFromOXRGB(0xef703c).CGColor];
        btn.tag = 2000+i;
        [btn addTarget:self action:@selector(logoBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:model.brand_name forState:UIControlStateNormal];
        [self.BtnMArr addObject:btn];
        [self addSubview:btn];
        h= btn.frame.origin.y;
    }
    

    UIView *lineView4 = [PublicMethod getLineViewWithFrame:CGRectMake(0,h+62, IPHONE_WITH, 0.5)];
    [self addSubview:lineView4];
    
    UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    clearBtn.frame = CGRectMake(16,h+86, IPHONE_WITH-32, [PublicMethod PictureViewAdaptHeightChange:84/2]);
    [clearBtn addTarget:self action:@selector(CleanBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [clearBtn setTitle:@"清除选项" forState:UIControlStateNormal];
    
    
    
//    UIButton *clearBtn = [PublicMethod buttonAddsuperview_superView:self _subViewFrame:CGRectMake(16,h+86, IPHONE_WITH-32, [PublicMethod PictureViewAdaptHeightChange:84/2]) _tag:self _action:@selector(CleanBtnClick:) _string:@"清除选项" _imageName:nil];
    clearBtn.titleLabel.font = FONT_SIZE(14);
    [clearBtn setBackgroundColor:UIColorFromOXRGB(0xbfbebe)];
    [self addSubview:clearBtn];

    
}
-(void)CleanBtnClick:(UIButton *)sender
{
    [self.Switch setOn:YES];
    self.beginTF.text = nil;
    self.endTF.text = nil;
    for (UIButton *btn in _BtnMArr)
    {
        
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:UIColorFromOXRGB(0xef703c) forState:UIControlStateNormal];
    }
    
    if (_delegate&&[_delegate respondsToSelector:@selector(BeginValue:)]) {
        [self.delegate   BeginValue:nil];
    }
    
    if (_delegate&&[_delegate respondsToSelector:@selector(EndValue:)]) {
        [self.delegate  EndValue:nil];
    }
    if (_delegate&&[_delegate respondsToSelector:@selector(selectLogoValue:)]) {
        [self.delegate   selectLogoValue:nil];
        
    }
    if (_delegate&&[_delegate respondsToSelector:@selector(switchValue:)])
    {
        
        [self.delegate   switchValue:nil];
    }


}

-(void)logoBtnClick:(UIButton *)sender
{
    for (UIButton *btn in _BtnMArr)
    {
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setTitleColor:UIColorFromOXRGB(0xef703c) forState:UIControlStateNormal];

    }
   UIButton *btn = [_BtnMArr objectAtIndex:sender.tag - 2000];
    [btn setBackgroundColor:UIColorFromOXRGB(0xef703c)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
   
    
   LogoModel *model = _logoArr[sender.tag-2000];
    if (_delegate&&[_delegate respondsToSelector:@selector(selectLogoValue:)]) {
        [self.delegate   selectLogoValue:model.brand_id];
        
    }


    
}
#pragma mark - textFiledDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return [textField resignFirstResponder];
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField.tag == 20000) {
        if (_delegate&&[_delegate respondsToSelector:@selector(BeginValue:)]) {
            [self.delegate   BeginValue:textField.text];
        }
    }
    
    if (textField.tag == 30000)
    {
        if (_delegate&&[_delegate respondsToSelector:@selector(EndValue:)]) {
            [self.delegate  EndValue:textField.text];
        }
    }
    
    
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
