//
//  YBCertifyVC.m
//  Kergou
//
//  Created by 王迎博 on 15/10/9.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBCertifyVC.h"

@interface YBCertifyVC ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frontImageH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backImageH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *frontBtnH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backBtnH;

@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userID;
@property (weak, nonatomic) IBOutlet UIImageView *frontImage;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;
@property (nonatomic,strong)NSData *imageData;
@property (nonatomic,strong)UIImage *midImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBtn;

@property (weak, nonatomic) IBOutlet UIButton *frontBtn;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation YBCertifyVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.frontImageH.constant = 90.0*Adopt_Device_iPhone6_Height;
    self.backImageH.constant = 90.0*Adopt_Device_iPhone6_Height;
    self.frontBtnH.constant = 90.0*Adopt_Device_iPhone6_Height;
    self.backBtnH.constant = 90.0*Adopt_Device_iPhone6_Height;
    
    
    
    //textfield触摸屏幕空白处退出编辑
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];

    self.saveBtn.tintColor = UIColorFromOXRGB(0x27E0C6);
    
}


-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
 
}

- (IBAction)frontBtnSelected:(UIButton *)sender
{
    
    JPLog(@"拍照获取正面照片");
    [self takePhoto];
}

- (IBAction)backBtnSelected:(UIButton *)sender
{
    JPLog(@"拍照获取背面照片");
    [self takePhoto];
}


- (void)takePhoto
{
    //资源类型为照相机
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
    //判断是否有相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        //设置拍照后的图片可被编辑
        picker.allowsEditing = YES;
        //资源类型为照相机
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:nil];
    }else
    {
        JPLog(@"该设备无摄像头");
    }

}

//图像选取器的委托方法，选完照片后回调该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    //当图片不为空时显示图片并保存图片
    if (image != nil)
    {
        
        NSData *data;
        CGSize size = CGSizeMake(FULL_SCREEN_WIDTH, FULL_SCREEN_HEIGHT- 20);
        UIGraphicsBeginImageContext(size);
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
        
        
        //把图片转成nsdata类型的数据来保存文件
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(scaledImage, 0.5);
        self.imageData = data;
        
        
          //图片显示在界面
        if (self.frontBtn.selected == YES)
        {
            [self.frontImage setImage:image];
            
            self.frontBtn.selected = NO;
        }
        else if (self.backBtn.selected == YES)
            {
                [self.backImage setImage:image];
                
                self.backBtn.selected = NO;
            }
        
        
      
        //[self.frontImage setImage:image];
        [picker dismissModalViewControllerAnimated:YES];
        
    }
}



@end
