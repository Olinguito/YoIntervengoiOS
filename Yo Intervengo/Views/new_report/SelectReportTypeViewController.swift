//
//  SelectReportTypeViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/8/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit

public class SelectReportTypeViewController: BlurredViewController,LNERadialMenuDelegate,LNERadialMenuDataSource {
    private var btnClose:UIButton!
    private var thisMenu:LNERadialMenu!
    private var connection:Connection!
    private var data:[Type]!
    
    public override func viewDidLoad() {        
        super.viewDidLoad()
    }
    
    public override func viewWillAppear(animated: Bool) {
        let point = CGPointMake(self.view.frame.size.width - 33, self.view.frame.size.height - 33)
        self.connection = Connection()
        self.connection.getTypes { (data, error) in
            if error != nil{
                print(error)
            }else{
                self.data = data as! [Type]
                self.thisMenu  = LNERadialMenu(fromPoint: point, withDataSource: self, andDelegate: self,withFrame: self.view.frame, andLabels:true)
                self.view.addSubview(self.thisMenu)
                self.thisMenu.showMenu()
            }
        }
    }
    
    public func radialMenu(radialMenu: LNERadialMenu!, didSelectButton button: UIButton!) {
        let view2 = SelectCategoryViewController()
        view2.type = self.data[button.tag]
        (self.navigationController as! ReportNavigationViewController).navigator.type = self.data[button.tag]
        self.navigationController?.pushViewController(view2, animated: false)
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
