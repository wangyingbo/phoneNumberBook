//
//  GoodsdetailVC.m
//  Kergou
//
//  Created by JiaPin on 15/9/24.
//  Copyright (c) 2015年 张帅. All rights reserved.
//
#import "ShoppingCarVC.h"
#import "GoodsDetailCell.h"
#import "TFHpple.h"
#import "GoodsDetailHeaderModel.h"
#import "GoodsDetailView.h"
#import "ShowSmallPicScrollView.h"
#import "PicPageControl.h"
#import "GoodsdetailVC.h"
#import "CheckOutVC.h"

#define GOODS_DELTEAIL_URL @"/goods/AppItemInfo"

#define GOODS_DETAIL_CACHE_KEY @"goodsDetailKey"
typedef enum
{
    PicAndTextDetail,
    LogoInfo,
    NormorlQuestion
}SectionBtnClick;

@interface GoodsdetailVC ()<ShowSmallPicScrollViewDelegate,GoodsDetailViewDelegate>
{
    UIView             *_lineView;
    UITabBarController *_tabbarcontroller;
    NSInteger          _count;
    NSInteger          _goodNum;
    UIButton           *_numBtn;
     NSMutableArray *_downloadImages;
    float           _LogoInfoLabHeight;
   
   
    
    
    
    
}
@property (weak, nonatomic) IBOutlet UIView *TBHeaderView;
@property (weak, nonatomic) IBOutlet UITableView *GoodsDetailTabView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headerViewHeight;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *beforePriceLab;

@property (weak, nonatomic) IBOutlet UIImageView *optionalImgView;
@property (weak, nonatomic) IBOutlet UIButton *subtractBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *GoodsNumLab;
@property (nonatomic,strong)      NSMutableDictionary *goodsDetailMDic;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLab;
@property (nonatomic,strong)         NSMutableArray *urlImages;
@property (nonatomic,strong)         UIImage        *normalQuestionImg;
@property (nonatomic,assign)         SectionBtnClick sectionClick;
@property (strong,nonatomic)  UIImageView    *addCarImageView;
- (IBAction)addBtnClick:(UIButton *)sender;

- (IBAction)substractBtnClick:(UIButton *)sender;

- (IBAction)collectBtn:(UIButton *)sender;
- (IBAction)shareBtn:(UIButton *)sender;

@end

@implementation GoodsdetailVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _tabbarcontroller = [PublicMethod getTabBarController];
    _tabbarcontroller.tabBar.hidden = YES;
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    _tabbarcontroller.tabBar.hidden = NO;
    
    
    
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _count = [self.GoodsNumLab.text integerValue];
    self.goodsDetailMDic = [[NSMutableDictionary alloc]initWithCapacity:0];
    
    
    
    
    _goodNum = 0;
    
    
    
    [self initNavagation];
    
    
    [self initLineView];
    
    
    
    self.optionalImgView.layer.borderWidth = 0.5;
    self.optionalImgView.layer.borderColor = [UIColor orangeColor].CGColor;
    
    [self getCurrentPageData];
    
}
-(void)getCurrentPageData
{
    
    
    NSMutableDictionary *goodsDetailMDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:GOODS_DETAIL_CACHE_KEY,CACHE_KEY, nil];
    
    [goodsDetailMDic setObject:@"2222265" forKey:@"goods_id"];
    [NetWorkRequest PostDataViewController:self BaseUrl:BASEURL_GOODS Funtioname:GOODS_DELTEAIL_URL Parameter:goodsDetailMDic Success:^(id responseObject)
     {
         self.goodsDetailMDic = [responseObject objectForKey:@"data"];
         [self initHeaderView];
         [self WanShanView];
         [self initBtmView];
         [self getTheDataResultHeight];
         
     } LoadFailed:^(NSError *error) {
         
     } haveNONetWork:^{
         
     }];
}
-(void)getTheDataResultHeight
{
    NSString *brandInfoStr = [[_goodsDetailMDic objectForKey:@"brand"]objectForKey:@"brand_explain"];
    CGRect frame = [brandInfoStr boundingRectWithSize:CGSizeMake(IPHONE_WITH, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil];
    _LogoInfoLabHeight = frame.size.height;
   
    
    NSString *questionStr = [[_goodsDetailMDic objectForKey:@"info"]objectForKey:@"question_img"];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:questionStr]];
    
    UIImage *img = [UIImage imageWithData:imageData];
    
    self.normalQuestionImg = img;
}
-(void)initBtmView
{
    GoodsDetailView *vi = [[GoodsDetailView alloc]initWithFrame:CGRectMake(0, IPHONE_HEIGHT-52, IPHONE_WITH, 52)];
    
   NSArray *dataArr = [_goodsDetailMDic objectForKey:@"stock"];
    
   NSDictionary *dic = [dataArr objectAtIndex:0];
   GoodsDetailStockModel *model = [[GoodsDetailStockModel alloc]initWithDictionary:dic];
   [vi configureBtmViewWithModel:model];
    
    
    
    vi.delegate = self;
    
    
    
    
    
    
    _numBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _numBtn.frame = CGRectMake(29+22-4,IPHONE_HEIGHT - 45,15, 15);
    _numBtn.backgroundColor = [UIColor orangeColor];
    _numBtn.hidden = YES;
    [_numBtn setTitle:@"1" forState:UIControlStateNormal];
    _numBtn.titleLabel.font = [UIFont fontWithName:nil size:12];
    [_numBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_numBtn.layer setMasksToBounds:YES];
    [_numBtn.layer setCornerRadius:7.5];
    
    
    
    
    [self.view addSubview:vi];
    [self.view addSubview:_numBtn];
}
-(void)WanShanView
{
    if (IPHONE_WITH==320) {
        self.TBHeaderView.frame = CGRectMake(0, 0, IPHONE_WITH,620);
    }
    else
    {
        self.TBHeaderView.frame = CGRectMake(0, 0, IPHONE_WITH,[PublicMethod PictureViewAdaptHeight:660]);
        
    }
    
    self.TBHeaderView.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
    self.headerViewHeight.constant = [PublicMethod PictureViewAdaptHeight:376];
    
    [self.subtractBtn.layer setBorderWidth:0.5];
    [self.subtractBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    
    [self.addBtn.layer setBorderWidth:0.5];
    [self.addBtn.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    [self.GoodsNumLab.layer setMasksToBounds:YES];
    [self.GoodsNumLab.layer setCornerRadius:4];
    [self.GoodsNumLab.layer setBorderWidth:0.3];
    [self.GoodsNumLab.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    
    NSDictionary *dic = [_goodsDetailMDic objectForKey:@"info"];
    
    self.priceLab.text = [NSString stringWithFormat:@"¥%@",[dic objectForKey:@"sale_price"]];
    self.beforePriceLab.text = [NSString stringWithFormat:@"¥%@",[dic objectForKey:@"market_price"]];
    
    self.goodsNameLab.text = [dic objectForKey:@"goods_name"];
    [self.optionalImgView setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"main_picture_75"]] placeholderImage:nil];
    NSDictionary *StockDic = [[_goodsDetailMDic objectForKey:@"stock"]objectAtIndex:0];
    
    self.GoodsNumLab.text = [StockDic objectForKey:@"goods_num"];
    
    NSString *webPicStr = [dic objectForKey:@"desc"];
    
    
    NSData *data = [webPicStr dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *xlmArr =   [self parseData:data];
    self.urlImages = [self downLoadPicture:xlmArr];

    
                   
                   
}
                   
- (NSArray*)parseData:(NSData*) data
    {
        TFHpple *doc = [[TFHpple alloc] initWithHTMLData:data];
        
        //在页面中查找img标签
        NSArray *images = [doc searchWithXPathQuery:@"//img"];
        
        
        return images;
    }
                   //下载图片的方法
-(NSMutableArray*)downLoadPicture:(NSArray *)images
{
        //创建存放UIImage的数组
        _downloadImages = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < [images count]; i++)
        {
            NSString *prefix = [[[images objectAtIndex:i] objectForKey:@"src"] substringToIndex:4];
            
            
            NSString *url = [[images objectAtIndex:i] objectForKey:@"src"];
            
            UIImage *image;
            //判断图片的下载地址是相对路径还是绝对路径，如果是以http开头，则是绝对地址，否则是相对地址
            if ([prefix isEqualToString:@"http"] == YES)
            {
                
                NSURL *downImageURL = [NSURL URLWithString:url];
                
                image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:downImageURL]];
            }
            //~~~~~~~~~~~~todo  添加图片的缓存～～～～～～～～～～～～～～
            if(image != nil){
                [_downloadImages addObject:image];
            }
           
        }
        return _downloadImages;
}
-(void)initLineView
{
        
        
        UIView *LV1 = [[UIView alloc]initWithFrame:CGRectMake(0,[PublicMethod PictureViewAdaptHeight:863/2], IPHONE_WITH, 0.5)];
        LV1.backgroundColor = [UIColor lightGrayColor];
        [self.TBHeaderView addSubview:LV1];
        
        UIView *LVBG = [[UIView alloc]initWithFrame:CGRectMake(0,[PublicMethod PictureViewAdaptHeight:990/2], IPHONE_WITH,8)];
        LVBG.backgroundColor =UIColorFromOXRGB(0xf3f4f9);
        [self.TBHeaderView addSubview:LVBG];
}
-(void)initHeaderView
{
        NSArray *imageArr = [_goodsDetailMDic objectForKey:@"image"];
        
        
        NSMutableArray *picMarr = [[NSMutableArray alloc]initWithCapacity:0];
        
        for (NSDictionary *dic in imageArr)
        {
            GoodsDetailHeaderModel *gdModel = [[GoodsDetailHeaderModel alloc]init];
            GoodsDetailHeaderModel *model =[gdModel initWithDictionary:dic];
            NSString *picUrlStr = model.goods_pic_450;
            NSData *picdata = [NSData dataWithContentsOfURL:[NSURL URLWithString:picUrlStr]];
            UIImage *image =[UIImage imageWithData:picdata];
            
            if (image)
            {
                [picMarr addObject:image];
                
            }
            //
            
        }
        
        //    初始化商品详情的scrollView
        ShowSmallPicScrollView *scroll = [[ShowSmallPicScrollView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, [PublicMethod PictureViewAdaptHeight:376]) withPicArr:picMarr];
        scroll.delegat = self;
        float x = self.view.center.x;
        
        PicPageControl *page = [[PicPageControl alloc]initWithFrame:CGRectMake(x-IPHONE_WITH/2, scroll.frame.size.height-20,0,0) withPageCount:picMarr.count withClass:scroll];
        page.hidden = YES;
        
        
        [self.headerView addSubview:scroll];
        
        
        self.addCarImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jiarugouwuche.png"]];
        float x1 = self.view.center.x;
        _addCarImageView.frame = CGRectMake(x1-4.5,100, 9, 9);
        _addCarImageView.alpha = 0;
        
        
        [self.headerView addSubview:_addCarImageView];
        
        
        
        
    }
-(void)returnScrollView:(UIScrollView *)scr
{
        [self.view addSubview:scr];
}

-(void)initNavagation
    {
        self.navigationController.navigationBar.barTintColor = UIColorFromOXRGB(0xf8f8f8);
        [self.navigationItem.backBarButtonItem setTitle:@""];
        [self.navigationItem setHidesBackButton:YES];
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setImage:[UIImage imageNamed:@"zuojiantou.png"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0,0, 38, 38);
        [backBtn addTarget:self action:@selector(backBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *barBtn = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        self.navigationItem.leftBarButtonItem = barBtn;
        
        
        
}

-(void)backBtnClick:(UIButton *)sender
{
        [self.navigationController popViewControllerAnimated:YES];
}
                   
                   
                   
#pragma mark - GoodsDetailDelegate
-(void)gotoShopCarVC
{
     ShoppingCarVC *vc = (ShoppingCarVC *)[PublicMethod getVCByStoryboardID:@"ShopCarSB" andWithSBName:@"Main"];
    [vc configureViewController];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void )addShopCarBtnClick
{
    
    [UIView animateWithDuration:0.5 animations:^{
            float x1 = self.view.center.x;
            _addCarImageView.frame = CGRectMake(x1-22.5,100, 45, 45);
            _addCarImageView.alpha = 1;
            
        } completion:^(BOOL finished)
         {
             [self performSelector:@selector(delayAnimation) withObject:self afterDelay:0.5];
             
             
         }];
        
        
        
    }
-(void)buyRightNow
{
        CheckOutVC *vi = (CheckOutVC *)[PublicMethod getVCByStoryboardID:@"CheckOutSB" andWithSBName:@"Main"];
        [self.navigationController pushViewController:vi animated:YES];
    
    
    
    
    
        
}
-(void)delayAnimation
{
        [UIView animateWithDuration:0.5 animations:^{
            _addCarImageView.frame = CGRectMake(29,IPHONE_HEIGHT-41, 9, 9);
            _addCarImageView.alpha = 0;
            
        } completion:^(BOOL finished) {
            float x1 = self.view.center.x;
            _addCarImageView.frame = CGRectMake(x1-4.5,100, 9, 9);
            _addCarImageView.alpha = 0;
            _numBtn.hidden = NO;
            _goodNum++;
            [_numBtn setTitle:[NSString stringWithFormat:@"%d",_goodNum] forState:UIControlStateNormal];
            
        }];
}
#pragma mark - Table view data source
                   
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
        
        UIView *vi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, 34)];
        
        UIView *headerlineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WITH, 0.5)];
        headerlineView.backgroundColor = [UIColor lightGrayColor];
        vi.backgroundColor = UIColorFromOXRGB(0xf8f8f8);
        NSArray *nameArr = @[@"图文详情",@"品牌介绍",@"常见问题"];
        
        for (int i = 0; i< nameArr.count; i++)
        {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(((IPHONE_WITH-180)/4*(i+1)+60*i), 11, 60, 15);
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:UIColorFromOXRGB(0xed6f32) forState:UIControlStateSelected];
            btn.titleLabel.font = [UIFont fontWithName:nil size:14];
            btn.tag = 2000+i;
            [btn addTarget:self action:@selector(turnPage:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitle:nameArr[i] forState:UIControlStateNormal];
            [vi addSubview:btn];
            
        }
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(((IPHONE_WITH-180)/4*(0+1)+60*0), 29, 60,3)];
        _lineView.backgroundColor = [UIColor orangeColor];
        
        [vi addSubview:headerlineView];
        [vi addSubview:_lineView];
        
        return vi;
        
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//        for(int i = 0;i<_urlImages.count;i++)
//        {
//            
//        }
    if (_sectionClick == LogoInfo)
    {
       
        return _LogoInfoLabHeight+200;

    }
     else if (_sectionClick == NormorlQuestion)
    {
        
        
        return _normalQuestionImg.size.height+200;
        
    }
    else{
    float h = 0.0f ;
    for (UIImage *img in _urlImages)
    {
        h=h+img.size.height;
    }
        return h;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
        return 35;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        
        
        return 1;
}
                   
                   
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        GoodsDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"goodsdetail" forIndexPath:indexPath];
    if (!cell)
    {
        cell = [[GoodsDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"goodsdetail"];
    }
    if (_sectionClick==PicAndTextDetail)
    {
         [cell configureCellWithImgArr:_urlImages];
    }
    if (_sectionClick == LogoInfo)
    {
        NSString *brandInfoStr = [[_goodsDetailMDic objectForKey:@"brand"]objectForKey:@"brand_explain"];
        [cell configureCellWithBrandInfo:brandInfoStr withCellHeight:_LogoInfoLabHeight];
    }
    if (_sectionClick == NormorlQuestion)
    {
     
        [cell configureCellWithNormalQuestion:_normalQuestionImg];
    }
   
    return cell;
    
}
                   
-(void)turnPage:(UIButton *)sender
{
        sender.selected = YES;
        [UIView animateWithDuration:0.3 animations:^{
            _lineView.frame = CGRectMake(((IPHONE_WITH-180)/4*(sender.tag-2000+1)+60*(sender.tag-2000)), 29, 60,3);
            sender.selected = NO;
        }];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    
    if (sender.tag == 2000)
    {
        self.sectionClick = PicAndTextDetail;
        
        
        [self.GoodsDetailTabView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
        
    }
    if (sender.tag == 2001)
    {
        self.sectionClick = LogoInfo;
            [self.GoodsDetailTabView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    if (sender.tag == 2002)
    {
        self.sectionClick = NormorlQuestion;
            [self.GoodsDetailTabView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationNone];
    }
    
    
    
        
}
                   
                   
- (void)didReceiveMemoryWarning
{
                       [super didReceiveMemoryWarning];
                       // Dispose of any resources that can be recreated.
}
                   

                   
- (IBAction)addBtnClick:(UIButton *)sender
{
        _count ++;
        self.GoodsNumLab.text = [NSString stringWithFormat:@"%d",_count];
        
}
                   
                   
- (IBAction)substractBtnClick:(UIButton *)sender
{
        _count --;
        if (_count == 0)
        {
            
            self.GoodsNumLab.text = [NSString stringWithFormat:@"%d",1];
            _count = 1;
        }
        else
        {
            
            self.GoodsNumLab.text = [NSString stringWithFormat:@"%d",_count];
        }
        
        
}
                   
- (IBAction)collectBtn:(UIButton *)sender
{
}
                   
- (IBAction)shareBtn:(UIButton *)sender
{
    
}

@end
