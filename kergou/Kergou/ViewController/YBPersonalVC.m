//
//  PersonalVC.m
//  Kergou
//
//  Created by 王迎博 on 15/9/28.
//  Copyright (c) 2015年 张帅. All rights reserved.
//

#import "YBPersonalVC.h"
#import "YBDatePicker.h"


//------------------------------------分割------------------------------
@interface YBPersonalVC ()

@property (nonatomic,retain)NSArray *arr;
@property (nonatomic,retain)NSArray *sectionTitleArray;
@property (nonatomic,strong)UIImageView *picImage;
@property (nonatomic,strong)NSData *imageData;
@property (nonatomic,strong)UITextField *textField;
@property (nonatomic,strong)UILabel *pickerLabel;
@property (nonatomic,strong)NSString *timeStr;
@property (nonatomic,strong)UIView *buttonView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation YBPersonalVC

@synthesize myDatePicker;
@synthesize myPicker;


- (void)viewWillAppear:(BOOL)animated
{
    [self.picImage setImage:[UIImage imageWithData:self.imageData]];
    [super viewWillAppear:YES];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupArray];
    self.tableView.scrollEnabled = NO;
    
    self.saveBtn.tintColor = UIColorFromOXRGB(0x27E0C6);
    
    [self setUpForDismissKeyboard];
}

//------------------------------------触摸屏幕隐藏键盘------------------------------

- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}

//------------------------------------分割------------------------------
- (void)setupArray
{
    self.states = [[NSMutableDictionary alloc]init];
    
//    [self.states setObject:@"name" forKey:@"用户名"];
//    [self.states setObject:@"touxiang" forKey:@"头像"];
//    [self.states setObject:@"chushengriqi" forKey:@"出生日期"];
//    
//    
//    self.dataArray = [self.states allKeys];
    self.arr = @[@"头像",@"用户名",@"出生日期"];
    self.sectionTitleArray = @[@"个人资料"];
}


//------------------------------------分割------------------------------
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


//------------------------------------分割------------------------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


//------------------------------------分割------------------------------

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
}


//------------------------------------分割------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //去掉底部多余的表格线。
    [tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    static NSString *CellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    
        cell.textLabel.text = [self.arr objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.row == 0)
    {
        self.picImage = [[UIImageView alloc] initWithFrame:CGRectMake(FULL_SCREEN_WIDTH - 85, 0, 42, 42)];
        self.picImage.layer.cornerRadius = self.picImage.frame.size.width/2;
        self.picImage.backgroundColor = [UIColor grayColor];
        
//        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(self.picImage.frame.origin.y, self.picImage.frame.origin.y, self.picImage.frame.size.width, self.picImage.frame.size.height)];
//        [button addTarget:self action:@selector(choosePhoto) forControlEvents:UIControlEventTouchDown];
//        
//        [self.picImage addSubview:button];
        [cell addSubview:self.picImage];
        
    }
    else if (indexPath.row == 1)
    {
        //在第二个cell里设置textfield，并把cell最右边的箭头去掉。
        cell.accessoryType = UITableViewCellAccessoryNone;
        self.textField = [[UITextField alloc]initWithFrame:CGRectMake(FULL_SCREEN_WIDTH - 115, 0, 85, cell.frame.size.height)];
        
        //self.textField.backgroundColor = [UIColor yellowColor];
        self.textField.placeholder = @"输入您的昵称";
        self.textField.font = [UIFont systemFontOfSize:14];
        self.textField.textAlignment = NSTextAlignmentCenter;
        self.textField.textColor = [UIColor grayColor];
        
        [cell addSubview:self.textField];
    }
    else if (indexPath.row == 2)
    {
        self.pickerLabel = [[UILabel alloc]initWithFrame:CGRectMake(FULL_SCREEN_WIDTH - 115, 0, 85, cell.frame.size.height)];
        self.pickerLabel.textAlignment = NSTextAlignmentCenter;
        //self.pickerLabel.backgroundColor = [UIColor orangeColor];
        self.pickerLabel.text = @"您的出生日期";
        self.pickerLabel.font = [UIFont systemFontOfSize:14];
        self.pickerLabel.textColor = [UIColor grayColor];
        
        [cell addSubview:self.pickerLabel];
        
    }
    
    
    //cell被选中时的颜色。
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}


//------------------------------------分割------------------------------
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        //第一各cell被选中时的要做的动作。
        JPLog(@"调取图库或摄像头");
        UIActionSheet *myActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册中选择",@"拍照", nil];
        
        [myActionSheet showInView:self.view];
        
    }
    
    else if (indexPath.row == 1)
    {
        //第二个cell被选中时的方法。
        JPLog(@"在textfield里输入用户名保存");
    }
    
    else if (indexPath.row == 2)
        {
            //第三个cell
            JPLog(@"在pickView里选取出生日期");
            self.buttonView.hidden = NO;
            myDatePicker.hidden = NO;
            if (myDatePicker == nil)
                
            {
                self.buttonView = [[UIView alloc]initWithFrame:CGRectMake(0, (FULL_SCREEN_HEIGHT/3) * 2 - 40, FULL_SCREEN_WIDTH, 40)];
                UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 40, self.buttonView.frame.size.height)];
                UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(FULL_SCREEN_WIDTH - 50, 0, 40, self.buttonView.frame.size.height)];
                [leftButton setTitle:@"取消" forState:UIControlStateNormal];
                [rightButton setTitle:@"完成" forState:UIControlStateNormal];
                self.buttonView.backgroundColor = [UIColor blackColor];
                [self.buttonView addSubview:rightButton];
                [self.buttonView addSubview:leftButton];
                [leftButton addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchDown];
                [rightButton addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchDown];
                [self.view addSubview:self.buttonView];
            myDatePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, (FULL_SCREEN_HEIGHT/3) * 2, FULL_SCREEN_WIDTH, FULL_SCREEN_HEIGHT/3)];
            
            NSTimeInterval perDay = 24 * 60 * 60;
            NSTimeInterval minYear = perDay * 365 * 80;
            NSTimeInterval maxYear = perDay * 365;
            
            NSDate *today = [[NSDate alloc]init];
            NSDate *min = [today dateByAddingTimeInterval:-minYear];
            NSDate *max = [today dateByAddingTimeInterval:-maxYear];
            
            [myDatePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"]];
            [myDatePicker setDatePickerMode:UIDatePickerModeDate];
            [myDatePicker setMinimumDate:min];
            [myDatePicker setMaximumDate:max];
                
//                UIDatePicker *datePicker = [[YBDatePicker alloc] initDatePicker];
//                myDatePicker = datePicker;
                
            }
            
            [myDatePicker addTarget:self action:@selector(onDatePickerChanged:) forControlEvents:UIControlEventValueChanged];
            
            [self.view addSubview:myDatePicker];
        }
    
}



//------------------------------------分割------------------------------
//设置右边索引字节数
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return nil;
}


//-------------------------------------分割---------------------------------
//section标题显示
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return [self.sectionTitleArray objectAtIndex:section];
}


//------------------------------------分割------------------------------

//设置section的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   return 40;
}



//------------------------------------分割------------------------------
//点击右侧索引表项时调用
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
//{
//    
//}


//------------------------------------分割------------------------------
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    UIView *v = nil;
//    if (section == 0) {
//        v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
//        [v setBackgroundColor:[UIColor grayColor]];
//        
//        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(50.0f, 10.0f, 200.0f, 30.0f)];
//        [labelTitle setBackgroundColor:[UIColor clearColor]];
//        labelTitle.textAlignment = NSTextAlignmentCenter;
//        labelTitle.text = @"第一个section 定制页面";
//        [v addSubview:labelTitle];
//    }
//    
//    return v;
//}


////------------------------------------分割------------------------------
//// 设置cell的高度
//- (CGFloat)tableView:(UITableView *)atableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 44;
//}


//------------------------------------分割------------------------------

//-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
//    //用于设置sectionIndexTitle
//    //返回要为一个内容为NSString 的NSArray 里面存放section title;
//    //默认情况下 section Title根据顺序对应 section 【如果不写tableView: sectionForSectionIndexTitle: atIndex:的话】
//    NSMutableArray* a=[NSMutableArray array];
//    for(CountryVO *c in self.countryDy){
//        [a addObject: [c.countryName substringToIndex:1]];
//    }
//    
//    
//    
//    //    return b=@[@"1",@"2"];
//    return a;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
//    //传入 section title 和index 返回其应该对应的session序号。
//    //一般不需要写 默认section index 顺序与section对应。除非 你的section index数量或者序列与section不同才用修改
//    return index;
//}



//------------------------------------分割------------------------------
//最后一行分隔线顶头显示
//-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Remove seperator inset
//    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
//        [cell setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//     //Prevent the cell from inheriting the Table View's margin settings
//    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
//        [cell setPreservesSuperviewLayoutMargins:YES];
//    }
//    
//    // Explictly set your cell's layout margins
//    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
//        [cell setLayoutMargins:UIEdgeInsetsZero];
//    }
//}


//------------------------------------分割------------------------------
//If all fails, you may brute-force your Table View margins:
//-(void)viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//    
//    // Force your tableview margins (this may be a bad idea)
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
//    }
//    
//    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
//        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
//    }
//}



#pragma mark  --UIActionSheetDelegate的实现


//********************************分割********************************

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            //从相册中选择
            [self localPhoto];
            break;
        case 1:
            //拍照
            [self takePhoto];
            break;
            
        default:
            
            break;
    }
}


//********************************分割********************************
//从相册中选择
- (void)localPhoto
{
    UIImagePickerController *picker = [[UIImagePickerController alloc]init];
    //资源类型为图库
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    //设置选择后的图片可被编辑
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}


//********************************分割********************************
//拍照
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

//********************************分割********************************

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
        
        //图片显示在界面
        UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(scaledImage, 0.5);
        self.imageData = data;
        
        //把图片转成nsdata类型的数据来保存文件
        [self.picImage setImage:image];
        [picker dismissModalViewControllerAnimated:YES];
        
    }
}


//********************************分割********************************








#pragma mark  --UIDatePickerViewDelegate

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~分割~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- (void)onDatePickerChanged:(UIDatePicker *)datePicker
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    //NSString *timeStr = [formatter stringFromDate:datePicker.date];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger seconds=[timeZone secondsFromGMTForDate:datePicker.date];
    NSDate *newDate=[datePicker.date dateByAddingTimeInterval:seconds];
    self.timeStr=[formatter stringFromDate:newDate];
    //NSLog(@"newDate----%@",newDate);
   // NSLog(@"newTimeStr-------%@",newTimeStr);
    //self.pickerLabel.text = [NSString stringWithFormat:@"%@",self.timeStr];
    
}

- (void)hidden
{
    myDatePicker.hidden = YES;
    self.buttonView.hidden = YES;
}

- (void)done
{
    self.pickerLabel.text = [NSString stringWithFormat:@"%@",self.timeStr];
    
    myDatePicker.hidden = YES;
    self.buttonView.hidden = YES;
}

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~分割~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- (IBAction)saveData:(UIBarButtonItem *)sender
{
    
    NSLog(@"需要填写方法保存数据到服务器");
   
    //[self setMyDatePicker:nil];
    
    
}

@end
