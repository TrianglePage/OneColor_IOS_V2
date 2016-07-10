//
//  algo_core.h
//  OneColor
//
//  Created by JI Yangkun on 16/6/26.
//  Copyright © 2016年 hwp. All rights reserved.
//

#ifndef algo_core_h
#define algo_core_h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <opencv2/opencv.hpp>
#import <opencv2/highgui/ios.h>


typedef enum
{
    gray =0,
    GREEN=1,
    BLUE =2,
    YELLOW=3,
    PURPLE=4,
}BGColor;


int ImageProcesser(UIImage* src, UIImage** out,int w, int h, CGPoint touchpoint, int touchPointsCount, int level, int bgColor, int bgBlur);
#endif /* algo_core_h */
