//
//  JOAlert.h
//  V 2.0
//
//  Created by Jorge Raul Ovalle Zuleta on 10/14/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>

@interface JOAlert : UIView

@property (strong,nonatomic)  UIButton *btnClose;
@property (strong,nonatomic)  CALayer *lyr;
@property (strong,nonatomic)  UIView  *bgTxt;
@property (strong,nonatomic)  UILabel *lblMsg;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UISwipeGestureRecognizer *tapGesture2;
@property (strong,nonatomic)  UIImageView *animationView;

-(instancetype)initWithAnimFrame :(CGRect)frame;
-(instancetype)initWithTextNFrame:(NSString*)text :(CGRect)frame;
-(void)showAlert;
-(void)showAlertAnim;
-(void)dismissAlert;
-(void)dismissAlertAnim;
-(void)setText:(NSString*)text;
-(void)showAlertAutoDismiss;

@end
