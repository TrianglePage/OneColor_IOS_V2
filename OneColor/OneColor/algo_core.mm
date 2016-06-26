//
//  algo_core.m
//  OneColor
//
//  Created by JI Yangkun on 16/6/19.
//  Copyright © 2016年 hwp. All rights reserved.
//

#import "algo_core.h"

using namespace cv;

int ImageProcesser(UIImage* src, UIImage* out,int w, int h, CGPoint touchpoint, int touchPointsCount, int level, int bgColor, int bgBlur)
{out=src;
//    Mat mat_image_src;
//    UIImageToMat(src, mat_image_src);
//    //Mat mat_image_out;
//    printf("w : %d, h : %d \n", mat_image_src.cols,mat_image_src.rows);
//    
//    
//    IplImage *image_src;
//    IplImage temp =IplImage(mat_image_src);
//    image_src=&temp;
//    
//    IplImage* gray = cvCreateImage(cvSize(image_src->width, image_src->height),
//                                   image_src->depth, 1);
//    printf("image w : %d, h : %d \n",image_src->width, image_src->height);
//    cvZero(gray);
//    cvCvtColor(image_src,gray,CV_RGB2GRAY);
//    
//    Mat mat_image_out(gray,0);
//    out = MatToUIImage(mat_image_out);
    
    //UIImageToMat(out, mat_image_out);
    
    
    return 0;
}