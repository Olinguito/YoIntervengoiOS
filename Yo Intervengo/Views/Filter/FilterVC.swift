//
//  FilterVC.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/21/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class FilterVC: GenericViewController,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnErase: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        btnErase.titleLabel?.font = UIFont(name: "Roboto-Light", size: 18)
        btnErase.setTitleColor(UIColor.addThemeContrast(), forState: UIControlState.Normal)
        btnErase.layer.borderColor = UIColor.addThemeContrast().CGColor
        btnErase.layer.borderWidth = 1
        btnSearch.titleLabel?.font = UIFont(name: "Roboto-Light", size: 18)
        btnSearch.setTitleColor(UIColor.addThemeContrast(), forState: UIControlState.Normal)
        btnSearch.layer.borderColor = UIColor.addThemeContrast().CGColor
        btnSearch.layer.borderWidth = 1
        searchBar.backgroundColor = UIColor.clearColor()
    }
    
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
