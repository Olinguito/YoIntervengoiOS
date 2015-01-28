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
    
    @IBAction func setCat(sender: AnyObject) {
        lblSubCat.textColor = UIColor(red:0.122, green:0.737, blue:0.859, alpha: 1)
        btnSubCat.setBackgroundImage(UIImage(named: "SubCategory_on"), forState: UIControlState.Normal)
    }
}
