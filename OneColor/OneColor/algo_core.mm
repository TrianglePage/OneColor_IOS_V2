//
//  algo_core.m
//  OneColor
//
//  Created by JI Yangkun on 16/6/19.
//  Copyright © 2016年 hwp. All rights reserved.
//

#import "algo_core.h"

using namespace cv;


void Grow(IplImage* src,IplImage* seed, int t1);

int ImageProcesser(UIImage* src, UIImage** out,int w, int h, CGPoint touchpoint, int touchPointsCount, int level, int bgColor, int bgBlur)
{
    //out=src;
    Mat mat_image_src;
    UIImageToMat(src, mat_image_src);
    printf("w : %d, h : %d \n", mat_image_src.cols,mat_image_src.rows);
    
    IplImage *image_src;
    IplImage temp =IplImage(mat_image_src);
    image_src=&temp;
  /////////////////////////////////////////////////
    
    
    IplImage* dst = cvCreateImage(cvGetSize(image_src), image_src->depth, 3);
    IplImage* show = cvCreateImage(cvGetSize(image_src), image_src->depth, image_src->nChannels);
    IplImage* hsv = cvCreateImage(cvGetSize(image_src), image_src->depth, 3);
    CvSize size_src = cvGetSize(image_src);
    IplImage* maskImage = cvCreateImage(cvGetSize(image_src), image_src->depth,1);
    IplImage* mask_inv = cvCreateImage(cvSize(size_src.width, size_src.height),
                                       image_src->depth, 1);
    IplImage* gray = cvCreateImage(cvSize(size_src.width, size_src.height),
                                   image_src->depth, 1);
    IplImage* gray_dst = cvCreateImage(cvSize(size_src.width, size_src.height),
                                       image_src->depth, 1);
    IplImage* gray_mask = cvCreateImage(cvSize(size_src.width, size_src.height),
                                        image_src->depth, 1);
    IplImage* h_plane = cvCreateImage(cvSize(size_src.width, size_src.height),
                                      image_src->depth, 1);
    IplImage* s = cvCreateImage(cvSize(size_src.width, size_src.height),
                                image_src->depth, 1);
    IplImage* v = cvCreateImage(cvSize(size_src.width, size_src.height),
                                image_src->depth, 1);
    IplImage* r = cvCreateImage(cvSize(size_src.width, size_src.height),
                                image_src->depth, 1);
    IplImage* g = cvCreateImage(cvSize(size_src.width, size_src.height),
                                image_src->depth, 1);
    IplImage* b = cvCreateImage(cvSize(size_src.width, size_src.height),
                                image_src->depth, 1);
    
    IplConvKernel* structure = cvCreateStructuringElementEx(7, 7, 3,3,CV_SHAPE_ELLIPSE);
    
    cvZero(dst);
    cvZero(maskImage);
    
    CvSeq* comp = NULL;
    
    CvMemStorage* storage = cvCreateMemStorage(0);
    
    CvSeq* contours = 0;
    
    cvCvtColor(image_src, gray, CV_BGR2GRAY);
    
    cvCvtColor(image_src, hsv, CV_BGR2HSV_FULL);//CV_RGB2HSV
    
    cvSplit(hsv, h_plane, s, v, 0);
    
    cvSet2D(maskImage,touchpoint.y,touchpoint.x,cvScalar(255));//传入坐标设在这里，这两个100,100
    
    Grow(h_plane,maskImage,level);//传入的level设在这里，
    
    cvFindContours(maskImage, storage, &contours, sizeof(CvContour),
                   CV_RETR_EXTERNAL, CV_CHAIN_APPROX_SIMPLE); //CV_RETR_CCOMP,
    cvZero(maskImage);
    cvDrawContours(maskImage, contours, cvScalar(255), cvScalar(255), 0,
                   CV_FILLED, 8);
    /*
     for (int i = 0; contours != 0; contours = contours->h_next) {
     cvDrawContours(maskImage, contours, cvScalar(255), cvScalar(255), 0,
     CV_FILLED, 8);
     }
     */
    cvDilate(maskImage,maskImage,structure,1);
    cvErode(maskImage,maskImage,structure,1);
    
    
    if(bgBlur == 1)
    {
        cvDilate(maskImage,maskImage,structure,1);
        cvErode(maskImage,maskImage,structure,2);
    }
    else
    {
        
    }
    
    
    cvCopy(image_src, show, maskImage);
    
    cvThreshold(maskImage, mask_inv, 1, 128, CV_THRESH_BINARY_INV);
    
    cvCopy(gray, gray_mask, mask_inv);
    
    if(bgBlur == 1)
    {
        cvSmooth(gray_mask,gray_mask,CV_BLUR,11,11,0,0);
    }
    else
    {
        
    }
    
    //cvDilate()
    
    //bgBlur = 1;
    
    
    
    Mat mat_r(r, 0);
    Mat mat_g(g, 0);
    Mat mat_b(b, 0);
    cvSplit(show, b, g, r, 0);
    
    Mat mat_gray_inv(gray_mask, 0);
    mat_r = mat_gray_inv + r;
    mat_g = mat_gray_inv + g;
    mat_b = mat_gray_inv + b;
    
    //	gray =0,
    //	GREEN=1,
    //	BLUE =2,
    //	YELLOW=3,
    //	PURPLE=4,
    
    switch(bgColor){
            
        case 0:break;
        case 1:cvAddS(g,cvScalar(25),g);
            break;
        case 2:cvAddS(b,cvScalar(25),b);
            break;
        case 3:cvAddS(g,cvScalar(25),g);
            cvAddS(r,cvScalar(25),r);
            break;
        case 4:cvAddS(r,cvScalar(25),r);
	   	   	   break;
        default:break;
            
    }
    
    //cvAddS(r,cvScalar(25),r);
    
    cvMerge(b,g,r,0,show);
    cvReleaseImage(&dst);
//    cvReleaseImage(&show);
    cvReleaseImage(&hsv);
    cvReleaseImage(&maskImage);
    cvReleaseImage(&mask_inv);
    cvReleaseImage(&gray);
    cvReleaseImage(&gray_dst);
    cvReleaseImage(&gray_mask);
    cvReleaseImage(&h_plane);
    cvReleaseImage(&s);
    cvReleaseImage(&v);
    cvReleaseImage(&r);
    cvReleaseImage(&g);
    cvReleaseImage(&b);
    cvReleaseStructuringElement(&structure);
    
//    cvAddS(image_src,cvScalar(20,20,20),image_src);
    
    Mat mat_image_out(show,0);
    UIImage *local_out = MatToUIImage(mat_image_out);
    
    UIImageToMat(local_out, mat_image_out);
    
    *out = local_out;
    //memcpy(local_out,out,sizeof(local_out));
    
    return 0;
}



void Grow(IplImage* src,IplImage* seed, int t1)//
{
    Vector <CvPoint> seedd;
    CvPoint point;
    
    int height     = src->height;
    int width      = src->width;
    int step       = src->widthStep;
    uchar* seed_data    = (uchar *)seed->imageData;
    uchar* src_data=(uchar *)src->imageData;
    int temp = 0;
    //将种子点压入堆栈
    for(int i=0;i<height;i++)
    {
        for(int j=0;j<width;j++)
        {
            if(seed_data[i*step+j]==255)
            {
                point.x=i;
                point.y=j;
                temp = src_data[point.x*step+point.y];
                seedd.push_back(point);
            }
        }
    }
    
    CvPoint temppoint;
    while(!seedd.empty())
    {
        point = seedd.back();
        seedd.pop_back();
        if((point.x>0)&&(point.x<(height-1))&&(point.y>0)&&(point.y<(width-1)))
        {
            if((seed_data[(point.x-1)*step+point.y]==0)&&(abs(src_data[(point.x-1)*step+point.y]-temp) <= t1))
            {
                seed_data[(point.x-1)*step+point.y]=255;
                temppoint.x=point.x-1;
                temppoint.y=point.y;
                seedd.push_back(temppoint);
            }
            if((seed_data[point.x*step+point.y+1]==0)&&(abs(src_data[point.x*step+point.y+1]-temp) <= t1))
            {
                seed_data[point.x*step+point.y+1]=255;
                temppoint.x=point.x;
                temppoint.y=point.y+1;
                seedd.push_back(temppoint);
            }
            if((seed_data[point.x*step+point.y-1]==0)&&(abs(src_data[point.x*step+point.y-1]-temp) <= t1))
            {
                seed_data[point.x*step+point.y-1]=255;
                temppoint.x=point.x;
                temppoint.y=point.y-1;
                seedd.push_back(temppoint);
            }
            if((seed_data[(point.x+1)*step+point.y]==0)&&(abs(src_data[(point.x+1)*step+point.y]-temp) <= t1))
            {
                seed_data[(point.x+1)*step+point.y]=255;
                temppoint.x=point.x+1;
                temppoint.y=point.y;
                seedd.push_back(temppoint);
            }
            if((seed_data[(point.x-1)*step+point.y-1]==0)&&(abs(src_data[(point.x-1)*step+point.y-1]-temp) <= t1))
            {
                seed_data[(point.x-1)*step+point.y-1]=255;
                temppoint.x=point.x-1;
                temppoint.y=point.y-1;
                seedd.push_back(temppoint);
            }
            if((seed_data[(point.x-1)*step+point.y+1]==0)&&(abs(src_data[(point.x-1)*step+point.y+1]-temp) <= t1))
            {
                seed_data[(point.x-1)*step+point.y+1]=255;
                temppoint.x=point.x-1;
                temppoint.y=point.y+1;
                seedd.push_back(temppoint);
                
            }
            if((seed_data[(point.x+1)*step+point.y-1]==0)&&(abs(src_data[(point.x+1)*step+point.y-1]-temp) <= t1))
            {
                seed_data[(point.x+1)*step+point.y-1]=255;
                temppoint.x=point.x+1;
                temppoint.y=point.y-1;
                seedd.push_back(temppoint);
            }
            if((seed_data[(point.x+1)*step+point.y+1]==0)&&(abs(src_data[(point.x+1)*step+point.y+1]-temp) <= t1))
            {
                seed_data[(point.x+1)*step+point.y+1]=255;
                temppoint.x=point.x+1;
                temppoint.y=point.y+1;
                seedd.push_back(temppoint);
            }
        }
    }
    
}



