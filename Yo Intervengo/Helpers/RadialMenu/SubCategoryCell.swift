//
//  SubCategoryCell.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/28/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class SubCategoryCell: UICollectionViewCell {
    @IBOutlet weak var btnSubCat: UIButton!
    @IBOutlet weak var lblSubCat: UILabel!
    var type:Int!
    
    @IBAction func setCat(sender: AnyObject) {
        if type == 0{
            lblSubCat.textColor = UIColor.blurYI()
            btnSubCat.setBackgroundImage(UIImage(named: "SubCategory_on"), forState: UIControlState.Normal)
        }else{
            lblSubCat.textColor = UIColor.orangeYI()
            btnSubCat.setBackgroundImage(UIImage(named: "SubCategory2_on"), forState: UIControlState.Normal)
        }
    }
}
