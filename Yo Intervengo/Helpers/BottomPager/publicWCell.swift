//
//  publicWCell.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/29/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class publicWCell: UICollectionViewCell {
    @IBOutlet var lblTitle:UILabel!
    @IBOutlet var subTitle:UILabel!
    @IBOutlet var lblDescr:UILabel!
    @IBOutlet var follower:UIButton!
    @IBOutlet var bgIcon:UIView!
    @IBOutlet var iconPublic:UIImageView!
    @IBOutlet var imgPublic:UIImageView!
    @IBOutlet var goReport:UIButton!
    
    @IBAction func follow(){
        println("Entra aca?")
        self.follower.backgroundColor = UIColor(red:0.902, green:0.349, blue:0.176, alpha: 1)
        self.follower.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        self.follower.tintColor = UIColor.whiteColor()
    }
    
}
