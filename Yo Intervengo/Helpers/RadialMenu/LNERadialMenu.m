//
//  LNERadialMenuView.m
//  LNERadialMenu
//
//  Created by Giuseppe Lanza on 24/03/13.
//  Copyright (c) 2013 La Nuova Era. All rights reserved.
//

#import "LNERadialMenu.h"

@interface LNERadialMenu()



@end

@implementation LNERadialMenu
@synthesize maxW;

-(id)initWithFrame:(CGRect)frame{
	return [self initFromPoint:CGPointZero withDataSource:nil andDelegate:nil withFrame:CGRectZero andLabels:false];
}

-(id) initFromPoint:(CGPoint)centerPoint withDataSource:(id<LNERadialMenuDataSource>)dataSource andDelegate:(id<LNERadialMenuDelegate>)delegate withFrame:(CGRect)frame andLabels:(Boolean)show{
	//self = [super initWithFrame:CGRectMake([[UIScreen mainScreen] applicationFrame].origin.x, [[UIScreen mainScreen] applicationFrame].origin.y, [[UIScreen mainScreen] applicationFrame].size.width, [[UIScreen mainScreen] applicationFrame].size.height)];

    //self = [super initWithFrame:self.superview.frame];
	self = [super initWithFrame:frame];
    
	if(self){
        self.showlabels = show;
		//centerPoint.y -= [[UIScreen mainScreen] applicationFrame].origin.y;
		//centerPoint.y -= self.superview.frame.origin.y;
       // centerPoint.y = ;
        
        
//		//Fix the center point in case it is too near the corners of the screen
//		if(CGRectContainsPoint(CGRectMake(0, 0, 70, 70), centerPoint) && !CGPointEqualToPoint(centerPoint, CGPointZero)){
//			_centerPoint = CGPointMake(70, 70);
//		} else if(CGRectContainsPoint(CGRectMake(0, [[UIScreen mainScreen] applicationFrame].size.height-70, 70, 70), centerPoint)){
//			_centerPoint = CGPointMake(70, [[UIScreen mainScreen] applicationFrame].size.height-70);
//		} else if(CGRectContainsPoint(CGRectMake([[UIScreen mainScreen] applicationFrame].size.width-70, 0, 70, 70), centerPoint)){
//			_centerPoint = CGPointMake([[UIScreen mainScreen] applicationFrame].size.width-70, 70);
//		} else if(CGRectContainsPoint(CGRectMake([[UIScreen mainScreen] applicationFrame].size.width-70, [[UIScreen mainScreen] applicationFrame].size.height-70, 70, 70), centerPoint)){
//			_centerPoint = CGPointMake([[UIScreen mainScreen] applicationFrame].size.width-70, [[UIScreen mainScreen] applicationFrame].size.height-70);
//		} else
			_centerPoint = CGPointEqualToPoint(centerPoint, CGPointZero) ? self.center : centerPoint;
		
		
		
		_dataSource = dataSource;
		_delegate = delegate;
		
		self.backgroundColor = [UIColor clearColor];
		
		UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeRadialMenu:)];
		[self addGestureRecognizer:tapGesture];
		tapGesture.delegate = self;
	}
	
	return self;
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
	BOOL should = YES;
	if([touch.view isKindOfClass:[UIButton class]]){
		should = NO;
	}
	
	return should;
}

-(void)closeRadialMenu:(UITapGestureRecognizer *)tapGesture{
	if([tapGesture.view isEqual:self] && !CGRectContainsPoint(self.radialMenuView.frame, [tapGesture locationInView:self])){
		[self closeMenu];
	}
}

-(void)closeMenuWithCompletion:(void(^)())completion{
	for(int i = 0; i < [self.elementsArray count]; i++){
		UIButton *element = [self.elementsArray objectAtIndex:i];
		double delayInSeconds = 0.025*i;
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
			[UIView animateWithDuration:0.25 animations:^{
				element.alpha = 0;
				element.center = CGPointMake(self.radialMenuView.frame.size.width/2.0, self.radialMenuView.frame.size.height/2.0);
			}];
		});
    }
	
	double delayInSeconds = 0.25+0.025*[self.elementsArray count];
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
		[UIView animateWithDuration:0.25 animations:^{
			self.radialMenuView.alpha = 0;
            self.alpha = 0;
		} completion:^(BOOL finished) {
			[self.radialMenuView removeFromSuperview];
			[self removeFromSuperview];
			
			if(completion) completion();
		}];
	});
}

-(void)closeMenu {
    [self.delegate radialMenu:self closingMenu:true];
	[self closeMenuWithCompletion:nil];
}

-(void)generateRadialMenu{
	_menuRadius = 50;
	if(self.dataSource && [self.dataSource respondsToSelector:@selector(radiusLenghtForRadialMenu:)]){
		_menuRadius = [self.dataSource radiusLenghtForRadialMenu:self];
	}
	
	_numberOfButtons = [self.dataSource numberOfButtonsForRadialMenu:self];
	
	_elementsArray = [[NSMutableArray alloc] init];
	_radialMenuView = [[UIView alloc] init];
	
	self.maxW = 0;
	for(int i = 0; i < _numberOfButtons; i++){
		UIButton *element = [self.dataSource radialMenu:self elementAtIndex:i];
		if(self.maxW < element.frame.size.width) self.maxW = element.frame.size.width;
		element.userInteractionEnabled = YES;
		element.alpha = 0;
		element.tag = i;
		[element addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
		
		[self.elementsArray addObject:element];
		
		[_radialMenuView addSubview:element];
	}
	
	_radialMenuView.frame = CGRectMake(0, 0, _menuRadius*2.0+self.maxW, _menuRadius*2.0+self.maxW);
	_radialMenuView.center = _centerPoint;
	_radialMenuView.userInteractionEnabled = YES;
	
	UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveAround:)];
	panGesture.delegate = self;
	
	if([self.dataSource respondsToSelector:@selector(canDragRadialMenu:)]){
		panGesture.enabled = [self.dataSource canDragRadialMenu:self];
	}
	
	[_radialMenuView addGestureRecognizer:panGesture];
	
	if([self.dataSource respondsToSelector:@selector(viewForCenterOfRadialMenu:)]){
		_centerRadialView = [self.dataSource viewForCenterOfRadialMenu:self];
		
		if(_centerRadialView){
			_centerRadialView.frame = CGRectZero;
			_centerRadialView.center = CGPointMake(self.radialMenuView.frame.size.width/2.0, self.radialMenuView.frame.size.height/2.0);
			
			[_radialMenuView addSubview:_centerRadialView];
		}
	}

}

-(void)moveAround:(UIPanGestureRecognizer *)panGesture{
	if ((panGesture.state == UIGestureRecognizerStateChanged) || (panGesture.state == UIGestureRecognizerStateEnded)) {
		CGPoint translation = [panGesture translationInView:self];
		// move something in myself (I’m a UIView) by translation.x and translation.y
		// for example, if I were a graph and my origin was set by an @property called origin self.origin = CGPointMake(self.origin.x+translation.x, self.origin.y+translation.y);
		CGRect radialMenuRect = self.radialMenuView.frame;
		radialMenuRect.origin.x += translation.x;
		radialMenuRect.origin.y += translation.y;

		self.radialMenuView.frame = radialMenuRect;

		[self placeRadialMenuElementsAnimated:NO];
		
		[panGesture setTranslation:CGPointZero inView:self];
	}
}

-(void)didTapButton:(UIButton *)sender{
	[self.delegate radialMenu:self didSelectButton:sender];
}

-(void) showMenu{
	[self showMenuWithCompletion:nil];
}

-(UIColor *) dimBackgroundColor{
    if(!_dimBackgroundColor){
        _dimBackgroundColor = [UIColor colorWithWhite:0 alpha:0.0];
    }
    
    return _dimBackgroundColor;
}

-(void)showMenuWithCompletion:(void (^)())completion{
	[self generateRadialMenu];
	
	//[[[[UIApplication sharedApplication] delegate] window] addSubview:self];
	[UIView animateWithDuration:0.25 animations:^{
		self.backgroundColor = self.dimBackgroundColor;
	} completion:^(BOOL finished) {
		[self addSubview:self.radialMenuView];
		
		if([self.dataSource respondsToSelector:@selector(radialMenu:customizationForRadialMenuView:)]){
			[self.dataSource radialMenu:self customizationForRadialMenuView:self.radialMenuView];
		}
		
		[UIView animateWithDuration:0.25 animations:^{
			if(_centerRadialView){
				CGFloat centerViewRadius = 7.0*self.menuRadius/10.0;
				self.centerRadialView.layer.cornerRadius = centerViewRadius;
				self.centerRadialView.layer.masksToBounds = YES;
				
				self.centerRadialView.frame = CGRectMake(self.radialMenuView.frame.size.width/2.0-centerViewRadius, self.radialMenuView.frame.size.height/2.0-centerViewRadius, centerViewRadius*2.0, centerViewRadius*2.0);
			}
			
		} completion:^(BOOL finished) {
			[self placeRadialMenuElementsAnimated:YES];
			if(completion)
				completion();
		}];
	}];
}

-(void)placeRadialMenuElementsAnimated:(BOOL)animated{
	CGFloat startingAngle = 0;
	CGFloat usableAngle = 2.0*M_PI;
	BOOL fullCircle = YES;
	
	//if the arc is too small all objects would be too near to be pressed, so we need to recalculate the radius and add something
	CGFloat radiusToAdd = 0;
	
	//Calculating visible circle's arc
	
	//LEFT BORDER
	if(self.radialMenuView.frame.origin.x < 0){
		fullCircle = NO;
		
		//BEGIN
		if(self.radialMenuView.frame.origin.y >0){
			CGFloat d = -(self.radialMenuView.frame.origin.x +self.menuRadius);
			startingAngle = -acosf((d+5)/(self.menuRadius +radiusToAdd));
		} else {
			
			CGFloat d = -(self.radialMenuView.frame.origin.y +self.menuRadius);
			startingAngle = asinf((d+self.maxW/2.0+5)/(self.menuRadius+radiusToAdd));
		}
		
		//END
		if(CGRectGetMaxY(self.radialMenuView.frame) <= self.frame.size.height){
			if(self.radialMenuView.frame.origin.y >0){
				usableAngle = -2*startingAngle;
			} else {
				CGFloat d = -(self.radialMenuView.frame.origin.x +self.menuRadius);
				CGFloat virtualAngle = acosf((d+5)/(self.menuRadius+radiusToAdd));
				usableAngle = 2*virtualAngle -(virtualAngle+startingAngle);
			}
		} else {
			CGFloat d = (CGRectGetMaxY(self.radialMenuView.frame)-self.frame.size.height -self.menuRadius);
			CGFloat virtualAngle = -asinf((d+5)/(self.menuRadius+radiusToAdd));
			usableAngle = -startingAngle+virtualAngle;
		}
	}
	
	//TOP BORDER
	if(self.radialMenuView.frame.origin.y < 0 && self.radialMenuView.frame.origin.x > 0 && CGRectGetMaxX(self.radialMenuView.frame) < self.frame.size.width){
		fullCircle = NO;
		
		CGFloat d = -(self.radialMenuView.frame.origin.y +self.menuRadius);
		startingAngle = asinf((d+self.maxW/2.0+5)/(self.menuRadius+radiusToAdd));
		
		usableAngle = M_PI-2*startingAngle;
		
	}
	
	//BOTTOM BORDER
	if(CGRectGetMaxY(self.radialMenuView.frame) > self.frame.size.height && self.radialMenuView.frame.origin.x > 0 && CGRectGetMaxX(self.radialMenuView.frame) < self.frame.size.width){
		fullCircle = NO;
		
		CGFloat d = (CGRectGetMaxY(self.radialMenuView.frame)-self.frame.size.height -self.menuRadius);
		startingAngle = M_PI+asinf((d+5)/(self.menuRadius+radiusToAdd));
		usableAngle = 2*M_PI-startingAngle-asinf((d+5)/(self.menuRadius+radiusToAdd));
		
	}
	
	//RIGHT BORDER
	if(CGRectGetMaxX(self.radialMenuView.frame) > self.frame.size.width){
		fullCircle = NO;

		//BEGIN
		if(CGRectGetMaxY(self.radialMenuView.frame) < self.frame.size.height){
			CGFloat d = self.menuRadius-(CGRectGetMaxX(self.radialMenuView.frame)-self.frame.size.width);
			startingAngle = acosf((d-5)/(self.menuRadius +radiusToAdd));
		} else {
			CGFloat d = (CGRectGetMaxY(self.radialMenuView.frame)-self.frame.size.height -self.menuRadius);
			startingAngle = M_PI+asinf((d+5)/(self.menuRadius+radiusToAdd));
			
		}
		
		//END
		if(self.radialMenuView.frame.origin.y > 0){
			CGFloat d = self.menuRadius-(CGRectGetMaxX(self.radialMenuView.frame)-self.frame.size.width);
			CGFloat virtualAngle = acosf((d-5)/(self.menuRadius +radiusToAdd));
			usableAngle = 2*M_PI-virtualAngle-startingAngle;
		} else {
			CGFloat d = -(self.radialMenuView.frame.origin.y +self.menuRadius);
			CGFloat virtualAngle = asinf((d+self.maxW/2.0+5)/(self.menuRadius+radiusToAdd));
			
			usableAngle = M_PI-virtualAngle-startingAngle;
		}
	}
	
	
	//Placing the objects
	for(int i = 0; i < [self.elementsArray count]; i++){
		UIButton *element = [self.elementsArray objectAtIndex:i];
		element.center = CGPointMake(self.radialMenuView.frame.size.width/2.0, self.radialMenuView.frame.size.height/2.0);
		double delayInSeconds = 0.025*i;
		
		void (^elementPositionBlock)(void) = ^{
			element.alpha = 1;
			[self.radialMenuView bringSubviewToFront:element];
			CGPoint endPoint = CGPointMake(self.radialMenuView.frame.size.width/2.0+(_menuRadius+radiusToAdd)*(cos(startingAngle+usableAngle/(self.numberOfButtons-(fullCircle ? 0 :1))*(float)i)), self.radialMenuView.frame.size.height/2.0+(_menuRadius+radiusToAdd)*(sin(startingAngle+usableAngle/(self.numberOfButtons-(fullCircle ? 0 :1))*(float)i)));
			element.center = endPoint;
            
            if (self.showlabels) {
                UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(element.center.x, element.center.y, 100, 20)];
                lab.text = element.titleLabel.text;
                lab.textAlignment = NSTextAlignmentRight;
                lab.textColor = UIColor.whiteColor;
                lab.font = [UIFont fontWithName:@"Roboto-Regular" size:16];
                lab.center = CGPointMake(endPoint.x - 80, endPoint.y);
                [_radialMenuView addSubview:lab];
            }
		};
		
		if(animated) {
			dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
			dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
				[UIView animateWithDuration:0.25 animations:elementPositionBlock];
			});
		} else elementPositionBlock();
	}
}

@end
