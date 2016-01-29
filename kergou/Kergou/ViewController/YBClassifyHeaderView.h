//
//  YBCollectionReusable.h
//  Kergou
//
//  Created by 王迎博 on 15/9/24.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YBSectionModel.h"

@interface YBClassifyHeaderView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *sectionName;

- (void)setData:(YBSectionModel *)testModel;

@end
