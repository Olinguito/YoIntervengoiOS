//
//  JORoundMenu.swift
//
//
//  Created by Jorge Raul Ovalle Zuleta on 1/22/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIkit

@objc protocol JORoundMenuDataSource{
//  optional func pageSetted(index:NSIndexPath)
    /*!
    This dataSource method asks the number of buttons that should be showed by the radial menu
    
    @p radialMenu the radial menu that is asking for this method
    @return NSInteger the number of buttons
    */
    func numberOfButtonsForRadialMenu(radialMenu:JORoundMenu) -> CGFloat
    /*!
    This dataSource method asks for the i Button for the radial menu
    
    @p radialMenu the radial menu that is asking for this method
    @p index the index of the asked object
    @return UIButton the asked button
    */
    func radialMenu(radialMenu:JORoundMenu, elementAtIndex index:NSInteger) -> UIButton
    /*!
    Thsi dataSource method determines if the menu can be moved with a pan gesture Recognizer. Defaults to YES.
    
    @p radialMenu the radial menu that is asking for this method
    @return BOOL
    */
    optional func canDragRadialMenu(radialMenu:JORoundMenu)->Bool
    /*!
    This method is used to set the radius of the menu. Defaults to 50. This radius will be the minimum radius for the radial menu. All the buttons will have theyr center point on the circonference of the circle virtually drawn by this radius.
    
    @p radialMenu the radial menu that is asking for this method.
    @return CGFloat the radius size
    */
    optional func radiusLenghtForRadialMenu(radialMenu:JORoundMenu) -> CGRect
    /*!
    You should use this method if you want an inside center top view in the center of the menu. You could also use radialMenu:customizationForRadialMenuView: method to achieve the same result by adding your custom view to the radialMenuView, but you will have to do math to center the custom view of course. ;)
    
    @p radialMenu the radial menu that is asking for this method
    @return UIView Your center view.
    */
    optional func viewForCenterOfRadialMenu(radialMenu:JORoundMenu) -> UIView
    /*!
    A window to customize the radialMenuView (which is the "background plus center" view of the radial menu) before it becomes visible on screen. This method will be called AFTER the viewForCenterOfRadialMenu: method.
    
    @p radialMenu the radial menu that is asking for this method
    @p radialMenuView the background view of the radial menu that contains the centerView
    */
    optional func radialMenu(radialMenu:JORoundMenu,  customizationForRadialMenuView radialMenuView: UIView)
    
}
//func mapView(mapView: RMMapView!, didDeselectAnnotation annotation: RMAnnotation!) {}

//-(UIButton *) radialMenu:(LNERadialMenu *)radialMenu elementAtIndex:(NSInteger)index;

@objc protocol JORoundMenuDelegate{
    func radialMenu(radialMenu:JORoundMenu, didSelectButton button:UIButton)
}


class JORoundMenu: UIView,UIGestureRecognizerDelegate {

    var centerPoint:CGPoint!
    var menuRadius:CGFloat!
    var numberOfButtons:NSInteger!
    var radialMenuView:UIView!
    
    var maxW:CGFloat!
    var elementsArray:NSMutableArray!
    /*!
    The color of the background view. Default is black with 0.3 alpha.
    */
    var dimBackgroundColor:UIColor!
    var delegate:JORoundMenuDelegate!
    var dataSource:JORoundMenuDataSource!
    var centerRadialView:UIView!
    var radialMenuIdentifier:AnyObject!
    
    override func drawRect(dirtyRect: CGRect) {
        super.drawRect(dirtyRect)

    }

    func initWithFrame(frame:CGRect)-> AnyObject!{
        var ds:JORoundMenuDataSource
        var de:JORoundMenuDelegate
        //return self.initFromPoint(CGPointZero, withDataSource: nil, andDelegate: nil)
        return 3
    }
    
    
    func initFromPoint(centerPoint:CGPoint, withDataSource dataSource:JORoundMenuDataSource, andDelegate delegate:JORoundMenuDelegate) -> AnyObject{
        self.initWithFrame(CGRectMake(UIScreen.mainScreen().applicationFrame.origin.x, UIScreen.mainScreen().applicationFrame.origin.y, UIScreen.mainScreen().applicationFrame.size.width, UIScreen.mainScreen().applicationFrame.size.height))
        
        if self.isEqual(nil) {
            self.centerPoint.y -=  UIScreen.mainScreen().applicationFrame.origin.y
            self.centerPoint = CGPointEqualToPoint(centerPoint, CGPointZero) ? self.center : centerPoint
            self.delegate = delegate
            self.dataSource = dataSource
            self.backgroundColor = UIColor.blackColor()
            var tapGesture = UITapGestureRecognizer(target: self, action: Selector("closeRadialMenu:"))
            self.addGestureRecognizer(tapGesture)
            tapGesture.delegate = self
        }
        
        return self
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        var should = true
        if touch.view.isKindOfClass(UIButton){
            should = false
        }
        return should;
    }
    
    
    func closeMenu() {
        closeMenuWithCompletion(nil)
    }
    
    func closeRadialMenu(tapGesture:UITapGestureRecognizer){
        if tapGesture.isEqual(self) && !CGRectContainsPoint(self.radialMenuView.frame,tapGesture.locationInView(self)){
            closeMenu()
        }
    }
    
    func closeMenuWithCompletion(AnyObject?)->Void{
        for(var i = 0; i < self.elementsArray.count; i++){
            var element:UIView = self.elementsArray.objectAtIndex(i) as UIView
            var delayInSeconds = Double(0.025*Float(i))
            
            var popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue()) {
                UIView.animateWithDuration(0.25, animations: {
                    element.alpha = 0
                    element.center = CGPointMake(self.radialMenuView.frame.size.width/2.0, self.radialMenuView.frame.size.height/2.0)
                })
            }
        }
        var delayInSeconds = Double(0.25+0.025*Float(self.elementsArray.count))
        var popTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(popTime, dispatch_get_main_queue()){
            UIView.animateWithDuration(0.25, animations: {
                self.radialMenuView.alpha = 0
                self.alpha = 0
            }, completion:{(Bool) in
                self.radialMenuView.removeFromSuperview()
                self.removeFromSuperview()
            })
        }
    }
    
    
    func generateRadialMenu(){
        menuRadius = 50
        if (self.dataSource != nil){
            menuRadius = self.dataSource.numberOfButtonsForRadialMenu(self)
        }
        numberOfButtons = Int(self.dataSource.numberOfButtonsForRadialMenu(self))
        elementsArray = NSMutableArray()
        radialMenuView = UIView()
        
        self.maxW = 0
        for (var i  = 0 ; i < numberOfButtons; i++){
            var element = self.dataSource.radialMenu(self, elementAtIndex: i)
            if self.maxW < element.frame.size.width {
                self.maxW = element.frame.size.width
            }
            element.userInteractionEnabled = true
            element.alpha = 0
            element.tag = i
            element.addTarget(self, action: Selector("didTapButton:"), forControlEvents: UIControlEvents.TouchUpInside)
            self.elementsArray.addObject(element)
            radialMenuView.addSubview(element)
        }
        radialMenuView.frame = CGRectMake(0, 0, menuRadius*2.0+self.maxW, menuRadius*2.0+self.maxW)
        radialMenuView.center = centerPoint
        radialMenuView.userInteractionEnabled = true
        
        var panGesture = UIPanGestureRecognizer(target: self, action: Selector("moveAround:"))
        panGesture.delegate = self
        
        //if self.dataSource.re  if([self.dataSource respondsToSelector:@selector(canDragRadialMenu:)]){
            panGesture.enabled = true
        
        radialMenuView.addGestureRecognizer(panGesture)
        
        //if self.dataSource.re //if([self.dataSource respondsToSelector:@selector(viewForCenterOfRadialMenu:)]){
            centerRadialView = self.dataSource.viewForCenterOfRadialMenu!(self)
            if centerRadialView != nil {
                centerRadialView.frame = CGRectZero
                centerRadialView.center = CGPointMake(self.radialMenuView.frame.size.width/2.0, self.radialMenuView.frame.size.height/2.0)
                radialMenuView.addSubview(centerRadialView)
            }
        
        
    }
    
    func placeRadialMenuElementsAnimated(animated:Bool){
        var startingAngle:Float = 0
        var usableAngle:Float = Float(2.0 * M_PI)
        var fullCircle = true
        
        //if the arc is too small all objects would be too near to be pressed, so we need to recalculate the radius and add something
        var radiusToAdd:Float = 0.0
        
        
        //LEFT BORDER
        if(self.radialMenuView.frame.origin.x < 0){
            fullCircle = false
            
            //BEGIN
            if(self.radialMenuView.frame.origin.y > 0){
                var d:Float = -(Float(self.radialMenuView.frame.origin.x) + Float(self.menuRadius))
                startingAngle = -acosf(Float((d+5)/(Float(self.menuRadius) + radiusToAdd)));
            } else {
                
                var d:Float = -(Float(self.radialMenuView.frame.origin.y) + Float(self.menuRadius))
                startingAngle = asinf((d+Float(self.maxW)/2.0+5)/(Float(self.menuRadius)+radiusToAdd))
            }
        }
    
    }
        //Calculating visible circle's arc
    
        /*
        
        //if the arc is too small all objects would be too near to be pressed, so we need to recalculate the radius and add something
        
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

        
        */
    
    func moveAround(panGesture:UIPanGestureRecognizer){
        if ((panGesture.state == UIGestureRecognizerState.Changed) || (panGesture.state == UIGestureRecognizerState.Ended)) {
            var translation = panGesture.translationInView(self)
            var radialMenuRect = self.radialMenuView.frame
            radialMenuRect.origin.x += translation.x
            radialMenuRect.origin.y += translation.y
            self.radialMenuView.frame = radialMenuRect;
            self.placeRadialMenuElementsAnimated(false)
            panGesture.setTranslation(CGPointZero, inView: self)
        }
    }
    
    
    func didTapButton(sender:UIButton){
        self.delegate.radialMenu(self, didSelectButton: sender)
    }
    

    func showMenu(){
        //showMenuWithCompletion(self)
    }
    
    func dimBackgroundColor2() -> UIColor{
        if self.dimBackgroundColor == nil {
            self.dimBackgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.3)
        }
        return self.dimBackgroundColor
    }
}