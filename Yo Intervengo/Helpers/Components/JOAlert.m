//
//  JOAlert.m
//  Se Le Tiene
//
//  Created by Jorge Raul Ovalle Zuleta on 10/14/14.
//  Copyright (c) 2014 Olinguito. All rights reserved.
//

#import "JOAlert.h"

@implementation JOAlert
@synthesize lblMsg,lyr,bgTxt,animationView,btnClose;

-(instancetype)initWithTextNFrame:(NSString*)text :(CGRect)frame :(BOOL)closable{
    if (self = [super init]) {
        self.frame = frame;
        self.bounds = frame;
        self.closable_ = closable;
        self.backgroundColor = [UIColor clearColor];
        lyr = [[CALayer alloc]init];
        lyr.frame = frame;
        lyr.backgroundColor = [UIColor blackColor].CGColor;
        lyr.opacity = 0.0;
        [self.layer addSublayer:lyr];
        
        bgTxt = [[UIView alloc] initWithFrame:CGRectMake((frame.size.width-270)/2, ((frame.size.height-64)/2), 270, 50)];
        [self addSubview:bgTxt];
        
        lblMsg = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 270, 50)];
        lblMsg.text = text;
        lblMsg.font = [UIFont fontWithName:@"Roboto-Light" size: 18];
        lblMsg.textColor = [UIColor whiteColor];
        lblMsg.textAlignment = NSTextAlignmentCenter;
        [bgTxt addSubview:lblMsg];
        
        if (self.closable_) {
            btnClose = [[UIButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 63, 30, 43, 43)];
            [btnClose setImage:[UIImage imageNamed:@"btnClose"] forState:UIControlStateNormal];
            btnClose.alpha = 0;
            [self addSubview:btnClose];
            self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            self.tapGesture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap2:)];
            [self addGestureRecognizer:self.tapGesture];
            [self addGestureRecognizer:self.tapGesture2];
        }
        
    }
    return self;
}



-(instancetype)initWithAnimFrame :(CGRect)frame{
    if (self = [super init]) {
        self.frame = frame;
        self.backgroundColor = [UIColor clearColor];
        lyr = [[CALayer alloc]init];
        lyr.frame = frame;
        lyr.backgroundColor = [UIColor blackColor].CGColor;
        lyr.opacity = 0.0;
        [self.layer addSublayer:lyr];
        
        NSArray *animationArray=[NSArray arrayWithObjects:
                                 [UIImage imageNamed:@"fr-01.png"],
                                 [UIImage imageNamed:@"fr-02.png"],
                                 [UIImage imageNamed:@"fr-03.png"],
                                 [UIImage imageNamed:@"fr-04.png"],
                                 nil];
        animationView=[[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-69)/2, ((frame.size.height-44)/2)-64,69,44)];
        animationView.backgroundColor=[UIColor clearColor];
        animationView.animationImages=animationArray;
        animationView.animationDuration=1.5;
        animationView.animationRepeatCount=0;
        [animationView startAnimating];
        [self addSubview:animationView];
        if (self.closable_) {
            self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
            self.tapGesture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap2:)];
        }
    }
    return self;
}


-(void)showAlert{
    POPBasicAnimation *scl = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    scl.duration = 0.15;
    scl.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl.delegate = self;
    [scl setValue:@"alpha1" forKey:@"animName"];
    scl.toValue = @(0.85);
    [lyr pop_addAnimation:scl forKey:@"alpha1"];
    
    POPBasicAnimation *scl2 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    scl2.duration = 0.15;
    scl2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl2.delegate = self;
    [scl2 setValue:@"alpha2" forKey:@"animName"];
    scl2.toValue = @(1);
    [bgTxt pop_addAnimation:scl2 forKey:@"alpha2"];
    
    POPSpringAnimation *sA1 = [POPSpringAnimation animation];
    sA1.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
    sA1.toValue = @((self.bounds.size.height/2));
    [sA1 setValue:@"toCenter1" forKey:@"animName"];
    sA1.springBounciness = 10;
    sA1.springSpeed = 10;
    [bgTxt pop_addAnimation:sA1 forKey:@"toCenter1"];
    
    if (self.closable_) {
        POPBasicAnimation *scl3 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
        scl3.duration = 0.2;
        scl3.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        scl3.delegate = self;
        [scl3 setValue:@"alpha3" forKey:@"animName"];
        scl3.toValue = @(1);
        [btnClose pop_addAnimation:scl3 forKey:@"alpha3"];
        
        [btnClose addTarget:self action:@selector(dismissAlert) forControlEvents:UIControlEventTouchUpInside];
    
         [self addGestureRecognizer:self.tapGesture];
         [self addGestureRecognizer:self.tapGesture2];
     }
}
-(void)dismissAlert{
    POPSpringAnimation *sA1 = [POPSpringAnimation animation];
    sA1.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
    sA1.toValue = @(((self.frame.size.height-50)/2)-50);
    [sA1 setValue:@"toCenter2" forKey:@"animName"];
    sA1.springBounciness = 10;
    sA1.springSpeed = 10;
    [bgTxt pop_addAnimation:sA1 forKey:@"toCenter2"];
    
    POPBasicAnimation *scl2 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    scl2.duration = 0.15;
    scl2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl2.delegate = self;
    [scl2 setValue:@"alpha3" forKey:@"animName"];
    scl2.toValue = @(0);
    [bgTxt pop_addAnimation:scl2 forKey:@"alpha3"];
    
    POPBasicAnimation *scl = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    scl.duration = 0.15;
    scl.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl.delegate = self;
    [scl setValue:@"alpha4" forKey:@"animName"];
    scl.toValue = @(0);
    [lyr pop_addAnimation:scl forKey:@"alpha4"];
}


-(void)showAlertAnim{
    POPBasicAnimation *scl = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    scl.duration = 0.15;
    scl.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl.delegate = self;
    [scl setValue:@"alpha1" forKey:@"animName"];
    scl.toValue = @(0.6);
    [lyr pop_addAnimation:scl forKey:@"alpha1"];
    
    POPBasicAnimation *scl2 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    scl2.duration = 0.15;
    scl2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl2.delegate = self;
    [scl2 setValue:@"alpha2" forKey:@"animName"];
    scl2.toValue = @(1);
    [animationView pop_addAnimation:scl2 forKey:@"alpha2"];
    
    POPSpringAnimation *sA1 = [POPSpringAnimation animation];
    sA1.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
    sA1.toValue = @((self.frame.size.height/2));
    [sA1 setValue:@"toCenter1" forKey:@"animName"];
    sA1.springBounciness = 10;
    sA1.springSpeed = 10;
    [animationView pop_addAnimation:sA1 forKey:@"toCenter1"];
}

-(void)dismissAlertAnim{
    NSLog(@"Paso por aca");
    POPSpringAnimation *sA1 = [POPSpringAnimation animation];
    sA1.property = [POPAnimatableProperty propertyWithName:kPOPLayerPositionY];
    sA1.toValue = @(((self.frame.size.height-50)/2)-50);
    [sA1 setValue:@"toCenter2" forKey:@"animName"];
    sA1.springBounciness = 10;
    sA1.springSpeed = 10;
    [animationView pop_addAnimation:sA1 forKey:@"toCenter2"];
    
    POPBasicAnimation *scl2 = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
    scl2.duration = 0.15;
    scl2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl2.delegate = self;
    [scl2 setValue:@"alpha3" forKey:@"animName"];
    scl2.toValue = @(0);
    [animationView pop_addAnimation:scl2 forKey:@"alpha3"];
    
    POPBasicAnimation *scl = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    scl.duration = 0.15;
    scl.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    scl.delegate = self;
    [scl setValue:@"alpha5" forKey:@"animName"];
    scl.toValue = @(0);
    [lyr pop_addAnimation:scl forKey:@"alpha5"];
    
}

- (void)handleTap:(UITapGestureRecognizer *)recognizer {
    [self dismissAlert];
}

- (void)handleTap2:(UISwipeGestureRecognizer *)recognizer {
    [self dismissAlert];
}

- (void)pop_animationDidStop:(POPAnimation *)anim finished:(BOOL)finished {
    if (finished) {
        if ([[anim valueForKey:@"animName"] isEqualToString:@"alpha4"]) {
            [self removeFromSuperview];
        }else{
            if ([[anim valueForKey:@"animName"] isEqualToString:@"alpha5"]) {
                NSLog(@"Entra por aca");
                [self removeFromSuperview];
            }
        }
    }
}

-(void)setText:(NSString*)text{
    lblMsg.text = text;
}

-(void)showAlertAutoDismiss{
    [self showAlert];
    [self performSelector:@selector(dismissAlert) withObject:nil afterDelay:0.4];
//    [self dismissAlert];
}



@end
