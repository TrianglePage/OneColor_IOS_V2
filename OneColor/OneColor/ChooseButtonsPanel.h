//
//  ChooseButtons.h
//  OneColor
//
//  Created by HEWEIPING on 16/4/24.
//  Copyright © 2016年 HEWEIPING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChooseButtonsPanel : UIView
{
    
}

@property (strong, nonatomic) IBOutlet UIButton *bt_redo;
@property (strong, nonatomic) IBOutlet UIButton *bt_undo;
@property (strong, nonatomic) IBOutlet UIButton *bt_save;
@property (strong, nonatomic) IBOutlet UIButton *bt_cancel;


-(id) init:(UIView *) ParentView;
-(void) setUserInteraction: (UIView *)ParentView :(BOOL) value;
@end
