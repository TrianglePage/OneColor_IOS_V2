//
//  FunctionTableBar.m
//  OneColor
//
//  Created by hwp on 16/5/3.
//  Copyright © 2016年 HEWEIPING. All rights reserved.
//

#import "FunctionTableBar.h"

@implementation FunctionTableBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id) initWithParentView:(UIView *) ParentView
{
    float panel_x = ParentView.frame.origin.x;
    float panel_y = ParentView.frame.size.height*9/10;
    float panel_w = ParentView.frame.size.width;
    float panel_h = ParentView.frame.size.height/10;
    
    float button_gap = panel_w*3/40;
    float button_len = 50;
    
    
    self = [super initWithFrame:CGRectMake(panel_x, panel_y, panel_w, panel_h)];
    
    if (self) {
        //一定要开启
        [ParentView setUserInteractionEnabled:YES];
        
//        [self setBackgroundColor:[UIColor colorWithRed:55 green:170 blue:157 alpha:1]];//debug
//        [self setBackgroundColor:[UIColor colorWithRed:255 green:0 blue:0 alpha:1]];//debug
        [self setBackgroundColor:[UIColor colorWithPatternImage: [UIImage imageNamed:@"GreenBackground.png"]]];
        
        self.bt_LensBlur = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt_LensBlur.frame = CGRectMake(button_len*0 + button_gap*1, 5, button_len, button_len);
        self.bt_LensBlur.imageView.frame = self.bt_LensBlur.bounds;
        self.bt_LensBlur.imageView.hidden= NO;
        [self.bt_LensBlur setImage:[UIImage imageNamed:@"扭1选中.png"] forState:UIControlStateNormal];
        
        //button AddText
        self.bt_AddText = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt_AddText.frame = CGRectMake(button_len*1 + button_gap*2, 5, button_len, button_len);
        [self.bt_AddText setImage:[UIImage imageNamed:@"扭2选中.png"] forState:UIControlStateNormal];
        
        //button bt_3
        self.bt_3 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt_3.frame = CGRectMake(button_len*2 + button_gap*3, 5, button_len, button_len);
        [self.bt_3 setImage:[UIImage imageNamed:@"扭3选中.png"] forState:UIControlStateNormal];
        
        //button Share
        self.bt_Share = [UIButton buttonWithType:UIButtonTypeCustom];
        self.bt_Share.frame = CGRectMake(button_len*3 + button_gap*4, 5, button_len, button_len);
        [self.bt_Share setImage:[UIImage imageNamed:@"扭4选中.png"] forState:UIControlStateNormal];
        
        [self addSubview:_bt_LensBlur];
        [self addSubview:_bt_AddText];
        [self addSubview:_bt_3];
        [self addSubview:_bt_Share];
        
        NSLog(@"FunctionButtonsPanel INIT");
        NSLog(@"FunctionButtonsPanel's Parent: (%f, %f, %f, %f)", ParentView.frame.origin.x, ParentView.frame.origin.y, ParentView.frame.size.width, ParentView.frame.size.height);
        NSLog(@"FunctionButtonsPanel:(%f, %f, %f, %f)", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
        
    }
    return self;
}

-(void) setUserInteraction: (UIView *)ParentView :(BOOL) value
{
    [ParentView setUserInteractionEnabled:value];
}


@end
