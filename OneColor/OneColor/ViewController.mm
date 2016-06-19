//
//  ViewController.m
//  OneColor
//
//  Created by hwp on 16/5/5.
//  Copyright © 2016年 hwp. All rights reserved.
//

#import "ViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //隐藏状态栏，全屏显示
    [self prefersStatusBarHidden];
    
    
    //添加子View,即添加图片页面 ---start
    CGRect r = [ UIScreen mainScreen ].bounds;
    UIView *View_AddImage = [[UIView alloc]initWithFrame:CGRectMake(r.origin.x, r.origin.y, r.size.width, r.size.height)];
    NSLog(@"screen.w=%f, screen.h=%f", r.size.width, r.size.height);
    UIImageView *iv_add_image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"添加页面2.png"]];
    iv_add_image.frame = CGRectMake(r.origin.x, r.origin.y, r.size.width, r.size.height);
    [iv_add_image setContentScaleFactor:[[UIScreen mainScreen] scale]];
    iv_add_image.contentMode =  UIViewContentModeScaleAspectFit;
    iv_add_image.autoresizingMask = UIViewAutoresizingNone;
    iv_add_image.clipsToBounds  = YES;
    
    UIButton *bt_add_image = [[UIButton alloc] initWithFrame:CGRectMake((r.size.width*2/5)-20, (r.size.height/2)-(r.size.width/10)-45, r.size.width/5+40, r.size.width/5+40)];
    [bt_add_image setBackgroundImage:[UIImage imageNamed:@"添加图标2.png"] forState:UIControlStateNormal];
    [bt_add_image addTarget:self action:@selector(addImage:) forControlEvents:UIControlEventTouchUpInside];
    [View_AddImage addSubview:iv_add_image];
    [View_AddImage addSubview:bt_add_image];
    View_AddImage.tag = 1;
    [self.view addSubview:View_AddImage];
    
    //添加子View,即添加图片页面 ---end
    
    
    //添加左右按钮  --start
    //左按钮
    _bt_reelect = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width/8, self.view.frame.size.width/8)];
    [_bt_reelect setBackgroundColor:[UIColor colorWithRed:55.0 green:170.0 blue:157.0 alpha:1]];
    [_bt_reelect setBackgroundImage:[UIImage imageNamed:@"GreenBackground.png"] forState:UIControlStateNormal];
    [_bt_reelect setImage:[UIImage imageNamed:@"选择图片.png"] forState:UIControlStateNormal];
    [_bt_reelect setHidden:YES];
    [self.view addSubview:_bt_reelect];
    [_bt_reelect addTarget:self action:@selector(reelect_Click:) forControlEvents:UIControlEventTouchUpInside];
    
    //右按钮
    _bt_seting = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width*7/8, self.view.frame.origin.y, self.view.frame.size.width/8, self.view.frame.size.width/8)];
    [_bt_seting setBackgroundColor:[UIColor colorWithRed:55.0 green:170.0 blue:157.0 alpha:1]];
    [_bt_seting setBackgroundImage:[UIImage imageNamed:@"GreenBackground.png"] forState:UIControlStateNormal];
    [_bt_seting setImage:[UIImage imageNamed:@"关于.png"] forState:UIControlStateNormal];
    [_bt_seting setHidden:YES];
    [self.view addSubview:_bt_seting];
    [_bt_seting addTarget:self action:@selector(seting_clicked:) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableDidSelected:) name:@"click" object:nil];
    //添加左右按钮  --end
    
    
    //添加ImageView加载选择的图片  --start
    _imageView_loadImage = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y+self.bt_reelect.frame.size.height+5, self.view.frame.size.width, self.view.frame.size.height-150)];
    _imageView_loadImage.contentMode = UIViewContentModeScaleAspectFit;//等比缩放显示
    NSLog(@"XXXXXXXXXscale=%f", self.imageView_loadImage.image.scale);
    NSLog(@"imageView_Load_w=%f, imageView_Load_h=%f", _imageView_loadImage.frame.size.width, _imageView_loadImage.frame.size.height);
    [self.view addSubview:_imageView_loadImage];
    //添加ImageView加载选择的图片  --end
    
    //添加ImageView里的右侧边栏按钮  --start
    _cbp = [[ChooseButtonsPanel alloc] init:self.imageView_loadImage];
    NSLog(@"drawer(%f, %f, %f, %f)", _cbp.frame.origin.x, _cbp.frame.origin.y, _cbp.frame.size.width, _cbp.frame.size.height);
    [_cbp.bt_undo addTarget:self action:@selector(undo_click:) forControlEvents:UIControlEventTouchUpInside];
    [_cbp.bt_redo addTarget:self action:@selector(redo_click:) forControlEvents:UIControlEventTouchUpInside];
    [_cbp.bt_save addTarget:self action:@selector(save_click:) forControlEvents:UIControlEventTouchUpInside];
    [_cbp.bt_cancel addTarget:self action:@selector(cancel_click:) forControlEvents:UIControlEventTouchUpInside];
    [_cbp setHidden:YES];
    [self.imageView_loadImage addSubview:_cbp];
    //添加ImageView里的右侧边栏按钮  --end
    
    //添加滑动条及加减粒度按钮 --start
    ASValueTrackingSlider *slider = [[ASValueTrackingSlider alloc] initWithFrame:CGRectMake(37, 478, 246, 25)];
    self.slider_grading = slider;
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [slider setNumberFormatter:formatter];
    slider.font = [UIFont fontWithName:@"Futura-CondensedExtraBold" size:26];
    slider.popUpViewAnimatedColors = @[[UIColor purpleColor], [UIColor redColor], [UIColor orangeColor]];
    slider.popUpViewArrowLength = 20.0;
    [slider setMaximumTrackImage:[UIImage imageNamed:@"拉条2.png"] forState:(UIControlStateNormal)];
    [slider setMinimumTrackImage:[UIImage imageNamed:@"拉条1.png"] forState:(UIControlStateNormal)];
    self.slider_grading.maximumValue = 100;
    self.slider_grading.minimumValue = 0;
    self.slider_grading.value = 0;
    [self.view addSubview: slider];
    [self.slider_grading setHidden:YES];
    
    /* 加减按钮 */
    _bt_sub = [UIButton buttonWithType:UIButtonTypeCustom];
    //    _bt_sub.frame = CGRectMake(self.view.frame.origin.x + 5, self.view.frame.size.height - self.ftb.frame.size.height - 5, 10, 10);
    _bt_sub.frame = CGRectMake(5, 478, 30, 30);
    _bt_sub.imageView.frame = self.bt_sub.bounds;
    _bt_sub.imageView.hidden= NO;
    [_bt_sub setImage:[UIImage imageNamed:@"减号.png"] forState:UIControlStateNormal];
    [_bt_sub addTarget:self action:@selector(sub_grading:) forControlEvents:UIControlEventTouchUpInside];
    
    _bt_add = [UIButton buttonWithType:UIButtonTypeCustom];
    _bt_add.frame = CGRectMake(285, 478, 30, 30);
    _bt_add.imageView.frame = self.bt_add.bounds;
    _bt_add.imageView.hidden= NO;
    [_bt_add setImage:[UIImage imageNamed:@"加号.png"] forState:UIControlStateNormal];
    [_bt_add addTarget:self action:@selector(add_grading:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_bt_sub];
    [self.view addSubview:_bt_add];
    [_bt_sub setHidden:YES];
    [_bt_add setHidden:YES];
    //添加滑动条及加减粒度按钮 --end
    
    
    //添加功能按钮栏TableView --start
    //    UITabBar *tabBar = [[UITabBar alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.size.height-50, self.view.frame.size.width, 100)];
    ////    [tabBar setBackgroundImage:[UIImage imageNamed:@"GreenBackground.png"]];
    //
    //    UITabBarItem *item_LensBlur = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"扭1选中.png"] tag:1];
    //    UITabBarItem *item_AddText  = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"扭2选中.png"] tag:2];
    //    UITabBarItem *item_3        = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"扭3选中.png"] tag:3];
    //    UITabBarItem *item_Share    = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage imageNamed:@"扭4选中.png"] tag:4];
    //
    //    item_LensBlur.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //    item_AddText.imageInsets  = UIEdgeInsetsMake(6, 0, -6, 0);
    //    item_3.imageInsets        = UIEdgeInsetsMake(6, 0, -6, 0);
    //    item_Share.imageInsets    = UIEdgeInsetsMake(6, 0, -6, 0);
    //
    //    NSArray *ItemsArray = [[NSArray alloc] initWithObjects:item_LensBlur, item_AddText, item_3, item_Share, nil];
    //    [tabBar setItems:ItemsArray];
    //    tabBar.items = ItemsArray;
    
    _ftb = [[FunctionTableBar alloc] initWithParentView:self.view];
    [_ftb.bt_LensBlur addTarget:self action:@selector(bt_LensBlur_clicked:) forControlEvents:UIControlEventTouchUpInside];
    [_ftb.bt_AddText addTarget:self action:@selector(bt_AddText_clicked:) forControlEvents:UIControlEventTouchUpInside];
    [_ftb.bt_3 addTarget:self action:@selector(bt_3_clicked:) forControlEvents:UIControlEventTouchUpInside];
    [_ftb.bt_Share addTarget:self action:@selector(bt_Share_clicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [_ftb setHidden:YES];
    [self.view addSubview:_ftb];
    
    //添加功能按钮栏TableView --end
    
}
- (BOOL) prefersStatusBarHidden
{
    return YES;//default to NO
}


//响应用户单击屏幕操作
- (void)handleTapBehind:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded){
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
-(void) dismissAlertView
{
    //定义单击屏幕关闭alertview
    UITapGestureRecognizer *recognizerTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapBehind:)];
    [recognizerTap setNumberOfTapsRequired:1];
    [recognizerTap setNumberOfTouchesRequired:1];
    recognizerTap.cancelsTouchesInView = NO;
    [[UIApplication sharedApplication].keyWindow addGestureRecognizer:recognizerTap];
}

//处理popover上的talbe的cell点击
- (void)tableDidSelected:(NSNotification *)notification {
    NSIndexPath *indexpath = (NSIndexPath *)notification.object;
    switch (indexpath.row)
    {
        case 0:
        {
            NSLog(@"UIAlert!!!");
            [self.buttonPopVC dismissViewControllerAnimated:YES completion:nil];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"关于" message:@"这是一个牛XX的软件" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertController animated:YES completion:nil];//显示alertView
            
            //定义单击屏幕关闭alertview
            [self dismissAlertView];
        }
            break;
        case 1:
        {
            NSLog(@"UIAlert!!!");
            [self.buttonPopVC dismissViewControllerAnimated:YES completion:nil];
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"检查更新" message:@"当前已是最新版本" preferredStyle:UIAlertControllerStyleAlert];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
            //定义单击屏幕关闭alertview
            [self dismissAlertView];
        }
            break;
        default:
            NSLog(@"Selecte Nothing!!");
    }
}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone;
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    return YES;   //点击蒙版popover不消失， 默认yes
}

/* “重选图片”与“关于”按钮的响应函数 */
- (IBAction)reelect_Click:(id)sender {
    //创建上拉列表alertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    
    //创建列表子项：取消，监听事件nil
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //创建列表子项：从相册选择，监听事件为打开相册
    UIAlertAction *selectFromImageLibraryAction = [UIAlertAction actionWithTitle:@"从机册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    
    //创建列表子项：拍照，监听事件为打开相机
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:selectFromImageLibraryAction];
    [alertController addAction:photoAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (IBAction)seting_clicked:(id)sender {
    self.buttonPopVC = [[PopoverViewController alloc] init];
    self.buttonPopVC.modalPresentationStyle = UIModalPresentationPopover;
    self.buttonPopVC.popoverPresentationController.sourceView = _bt_seting;  //rect参数是以view的左上角为坐标原点（0，0）
    self.buttonPopVC.popoverPresentationController.sourceRect = _bt_seting.bounds; //指定箭头所指区域的矩形框范围（位置和尺寸），以view的左上角为坐标原点
    self.buttonPopVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp; //箭头方向
    self.buttonPopVC.popoverPresentationController.delegate = self;
    [self presentViewController:self.buttonPopVC animated:YES completion:nil];
}

//添加图片按钮：Button_addImage
- (IBAction)addImage:(id)sender
{
    //创建上拉列表alertController
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    
    //创建列表子项：取消，监听事件nil
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //创建列表子项：从相册选择，监听事件为打开相册
    UIAlertAction *selectFromImageLibraryAction = [UIAlertAction actionWithTitle:@"从机册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    
    //创建列表子项：拍照，监听事件为打开相机
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
            imagePicker.delegate = self;
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:selectFromImageLibraryAction];
    [alertController addAction:photoAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

//当选择一张图片后进入这里, 实现代理imagePickerController
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil) {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    self.imageView_loadImage.image = image;
    
    //获取图像宽高
    self->image_width = image.size.width;
    self->image_height = image.size.height;
    NSLog(@"image_w=%f, image_h=%f", self->image_width, self->image_height);
    
    NSLog(@"ImageView_w=%f, ImageView_h=%f", self.imageView_loadImage.frame.size.width, self.imageView_loadImage.frame.size.height);
    
    NSLog(@"scale=%f", self.imageView_loadImage.image.scale);
    
    float base_scale;
    
    float scale_image_xy = self->image_width/self->image_height;
    float scale_widget_xy = self.imageView_loadImage.frame.size.width/self.imageView_loadImage.frame.size.height;
    NSLog(@"scale_image_xy=%f, scale_widget_xy=%f", scale_image_xy, scale_widget_xy);
    
    if (scale_image_xy > scale_widget_xy) {
        if(self->image_height >= self.imageView_loadImage.frame.size.height)
        {
            base_scale = self.imageView_loadImage.frame.size.height/self->image_height;
        }
        else
        {
            base_scale = self->image_height / self.imageView_loadImage.frame.size.height;
        }
    }
    else
    {
        if(self->image_width >= self.imageView_loadImage.frame.size.width)
        {
            base_scale = self.imageView_loadImage.frame.size.width/self->image_width;
        }
        else
        {
            base_scale = self->image_width / self.imageView_loadImage.frame.size.width;
        }
 
    }
    NSLog(@"base_scale=%f", base_scale);
    
    //隐藏或者删除添加图片的子view
    for (UIView *View in [self.view subviews])
    {
        if(1 == View.tag)//如果有多个同类型的View可以通过tag来区分
        {
            //            [self.view sendSubviewToBack:View];//隐藏此控件
            //            [View setHidden:YES];//隐藏此控件
            [View removeFromSuperview];//删除此控件
        }
    }
    //显示panel并开启响应panel的点击事件
    [self.cbp setHidden:NO];
    [self.cbp setUserInteraction:self.imageView_loadImage :YES];
    
    [self.slider_grading setHidden:NO];
    [_bt_reelect setHidden:NO];
    [_bt_seting setHidden:NO];
    [_ftb setHidden:NO];
    [_bt_sub setHidden:NO];
    [_bt_add setHidden:NO];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//后退按钮响应
- (IBAction)undo_click:(id)sender {
    NSLog(@"undo Clicked");
}
//后退按钮响应
- (IBAction)redo_click:(id)sender {
    NSLog(@"redo Clicked");
}
//保存按钮响应
- (IBAction)save_click:(id)sender {
    UIImageWriteToSavedPhotosAlbum(self.imageView_loadImage.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}
//取消按钮响应
- (IBAction)cancel_click:(id)sender {
    NSLog(@"cancel Clicked");
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (!error)
    {
        UIAlertController *alert_save_result = [UIAlertController alertControllerWithTitle:@"保存结果" message:@"已保存到相册" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert_save_result animated:YES completion:nil];
        
        //定义单击屏幕关闭alertview
        [self dismissAlertView];
    }
    else
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"保存结果" message:@"保存失败" preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alert animated:YES completion:nil];
        
        //定义单击屏幕关闭alertview
        [self dismissAlertView];
    }
}



-(void) hidePopUpView
{
    [self.slider_grading hidePopUpViewAnimated:YES];
}
//减小粒度
- (IBAction)sub_grading:(id)sender {
    if (self.slider_grading.value > self.slider_grading.minimumValue)
    {
        [self.slider_grading showPopUpViewAnimated:YES];
        self.slider_grading.value --;
    }
    //延迟隐藏提示信息
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(hidePopUpView) userInfo:nil repeats:NO];
}
//增加粒度
- (IBAction)add_grading:(id)sender {
    if (self.slider_grading.value < self.slider_grading.maximumValue)
    {
        [self.slider_grading showPopUpViewAnimated:YES];
        self.slider_grading.value ++;
    }
    //延迟隐藏提示信息
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(hidePopUpView) userInfo:nil repeats:NO];
    self.grading_tip.text = [NSString stringWithFormat:@"色彩保留等级： %d", (int)self.slider_grading.value];
}

//4个功能按钮响应函数
- (IBAction)bt_LensBlur_clicked:(id)sender {
    NSLog(@"bt_LensBlur_clicked");
}
- (IBAction)bt_AddText_clicked:(id)sender {
    NSLog(@"bt_AddText_clicked");
}
- (IBAction)bt_3_clicked:(id)sender {
    NSLog(@"bt_3_clicked");
}
- (IBAction)bt_Share_clicked:(id)sender {
    NSLog(@"bt_Share_clicked");
    //1、创建分享参数
//    NSArray *imageArray = @[[UIImage imageNamed:@"初始页.png"]];
////    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
//    if (imageArray) {
    
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:nil
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];//}
}



//触摸事件响应
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSSet *allTouches = [event allTouches];    //返回与当前接收者有关的所有的触摸对象
    UITouch *touch = [allTouches anyObject];   //视图中的所有对象
    CGPoint point = [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
    int x = point.x;
    int y = point.y;
    NSLog(@"touch (x, y) is (%d, %d)", x, y);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
