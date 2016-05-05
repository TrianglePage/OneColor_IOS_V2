//
//  FunctionTableBar.h
//  OneColor
//
//  Created by hwp on 16/5/3.
//  Copyright © 2016年 HEWEIPING. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FunctionTableBar : UIView
{
    
}
@property (strong, nonatomic) IBOutlet UIButton *bt_LensBlur;
@property (strong, nonatomic) IBOutlet UIButton *bt_AddText;
@property (strong, nonatomic) IBOutlet UIButton *bt_3;
@property (strong, nonatomic) IBOutlet UIButton *bt_Share;

-(id) initWithParentView: (UIView *) ParentView;
-(void) setUserInteraction: (UIView *)ParentView :(BOOL) value;
@end
