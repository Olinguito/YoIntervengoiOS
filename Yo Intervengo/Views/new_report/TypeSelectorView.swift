//
//  TypeSelectorView.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/9/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit

@objc protocol TypeSelectorViewDelegate{
    optional func selectedItem(type:Type)
}

public class TypeSelectorView: LNERadialMenu,LNERadialMenuDelegate,LNERadialMenuDataSource  {
    
    private  var connection:Connection!
    private  var data:[Type]!
    internal var control:TypeSelectorViewDelegate?
    
    init(point:CGPoint,frame:CGRect){
        super.init(fromPoint: point, withDataSource: nil, andDelegate: nil, withFrame: frame, andLabels: true)
        
        self.delegate   = self
        self.dataSource = self
        self.connection = Connection()
        self.connection.getTypes { (data, error) in
            if error != nil{
                print(error)
            }else{
                self.data = data as! [Type]
            }
        }
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func radialMenu(radialMenu: LNERadialMenu!, didSelectButton button: UIButton!) {
        control?.selectedItem!(self.data[button.tag])
        radialMenu.closeMenu()
    }
    
    public func numberOfButtonsForRadialMenu(radialMenu: LNERadialMenu!) -> Int {
        return self.data.count
    }
    
    public func radialMenu(radialMenu: LNERadialMenu!, closingMenu close: Bool) {
        
    }
    
    public func radiusLenghtForRadialMenu(radialMenu: LNERadialMenu!) -> CGFloat {
        return 60
    }
    
    public func radialMenu(radialMenu: LNERadialMenu!, elementAtIndex index: Int) -> UIButton! {
        let element              = UIButton(frame: CGRect(x: 0, y: 0, width: 70, height: 70))
        let type                 = data[index]
        element.tag              = index
        element.titleLabel?.text = type.name!.uppercaseString
        element.setBackgroundImage(UIImage(named: type.icon!), forState: UIControlState.Normal)
        element.setTitleColor(UIColor.clearColor(), forState: UIControlState.Normal)
        return element
    }
    
    public func viewForCenterOfRadialMenu(radialMenu: LNERadialMenu!) -> UIView! {
        let centerView = UIView(frame: CGRect(x: 0, y: 0, width: 190, height: 190))
        centerView.backgroundColor  = UIColor.blackColor().colorWithAlphaComponent(0.2)
        return centerView
    }
    
    public func canDragRadialMenu(radialMenu: LNERadialMenu!) -> Bool {
        return false
    }
}
