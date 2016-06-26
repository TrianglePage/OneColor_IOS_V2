//
//  ViewController.h
//  OneColor
//
//  Created by hwp on 16/5/5.
//  Copyright © 2016年 hwp. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <opencv2/opencv.hpp>
#import <opencv2/highgui/ios.h>

//自定义滑杆
#import "ASValueTrackingSlider.h"
#import "PopoverViewController.h"
#import "FunctionTableBar.h"
#import "ChooseButtonsPanel.h"

@interface ViewController : UIViewController<UIAlertViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,ASValueTrackingSliderDataSource,UIPopoverPresentationControllerDelegate,UITableViewDelegate>
{
    UIImage *image;
    float   image_width;
    float   image_height;
    float   base_scale;
    CGRect  image_rect;
    CGPoint image_co_point;
    cv::Mat cvImage;
}
@property (strong, nonatomic) IBOutlet UIImageView *imageView_loadImage;

@property (strong, nonatomic) IBOutlet UITabBarController *function_TabBar;

@property (weak, nonatomic) IBOutlet UILabel *grading_tip;

@property (weak, nonatomic) IBOutlet ASValueTrackingSlider  *slider_grading;

@property (strong, nonatomic) PopoverViewController *buttonPopVC;
@property (strong, nonatomic) PopoverViewController *itemPopVC;

@property (strong, nonatomic) UIButton *bt_seting;
@property (strong, nonatomic) UIButton *bt_reelect;

@property (strong, nonatomic) ChooseButtonsPanel *cbp;
@property (strong, nonatomic) FunctionTableBar   *ftb;

@property (strong, nonatomic) UIButton *bt_sub;
@property (strong, nonatomic) UIButton *bt_add;

- (CGRect)getScaleImageRect;
- (CGPoint)getImageTouchPoint: (CGPoint)tp;

@end

