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
    
    override var selected: Bool {didSet{selectedCell()}}
    
    func selectedCell(){
        if selected{
            lblSubCat.textColor = btnSubCat.tintColor
            btnSubCat.selected  = true
        }else{
            lblSubCat.textColor = UIColor.addThemeContrast()
            btnSubCat.selected = false
        }
    }
}
