//
//  ChooseButtons.m
//  OneColor
//
//  Created by HEWEIPING on 16/4/24.
//  Copyright © 2016年 HEWEIPING. All rights reserved.
//

#import "ChooseButtonsPanel.h"

//黄金分割比例
#define golden_section_ratio (0.618)

@implementation ChooseButtonsPanel
-(id) init:(UIView *) ParentView
{
    float panel_x = (ParentView.frame.size.width * 7)/8;
    float panel_y = ParentView.frame.size.height*(1-golden_section_ratio);
    float panel_w = ParentView.frame.size.width/8;
    float button_gap = panel_w/10;
    float panel_h = panel_w*4+button_gap*3;
    float button_len = panel_w;

    
    self = [super initWithFrame:CGRectMake(panel_x, panel_y, panel_w, panel_h)];

    if (self) {
        //一定要开启
//        [ParentView setUserInteractionEnabled:YES];
        
//        [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:1]];//debug
        
        self.bt_undo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        self.bt_undo.layer.cornerRadius = 34.0;
//        self.bt_undo.layer.borderWidth = 1.0;
//        self.bt_undo.layer.borderColor =[UIColor clearColor].CGColor;
//        self.bt_undo.clipsToBounds = TRUE;
        self.bt_undo.frame = CGRectMake(0, 0, button_len, button_len);
        [self.bt_undo setImage:[UIImage imageNamed:@"undo.png"] forState:UIControlStateNormal];
        
        //button redo
        self.bt_redo = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.bt_redo.frame = CGRectMake(0, 0+button_len+button_gap, button_len, button_len);
        [self.bt_redo setImage:[UIImage imageNamed:@"redo.png"] forState:UIControlStateNormal];
        
        //button save
        self.bt_save = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.bt_save.frame = CGRectMake(0, (0+button_len+button_gap)*2, button_len, button_len);
        [self.bt_save setImage:[UIImage imageNamed:@"save.png"] forState:UIControlStateNormal];
        
        //button cancel
        self.bt_cancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        self.bt_cancel.frame = CGRectMake(0, (0+button_len+button_gap)*3, button_len, button_len);
        [self.bt_cancel setImage:[UIImage imageNamed:@"cancel.png"] forState:UIControlStateNormal];
        
        
        [self addSubview:_bt_undo];
        [self addSubview:_bt_redo];
        [self addSubview:_bt_save];
        [self addSubview:_bt_cancel];
        
        NSLog(@"ChooseButtonsPanel INIT");
        NSLog(@"Panel's Parent: (%f, %f, %f, %f)", ParentView.frame.origin.x, ParentView.frame.origin.y, ParentView.frame.size.width, ParentView.frame.size.height);
        NSLog(@"ChooseButtonsPanel:(%f, %f, %f, %f)", self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);

    }
    return self;
}

-(void) setUserInteraction: (UIView *)ParentView :(BOOL) value
{
    [ParentView setUserInteractionEnabled:value];
}

@end
