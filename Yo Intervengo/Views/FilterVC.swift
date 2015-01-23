//
//  FilterVC.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/21/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class FilterVC: UIViewController,UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnErase: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        btnErase.titleLabel?.font = UIFont(name: "Roboto-Light", size: 18)
        btnErase.layer.borderColor = UIColor(red:0.878, green:0.886, blue:0.894, alpha: 1).CGColor
        btnErase.layer.borderWidth = 1
        btnSearch.titleLabel?.font = UIFont(name: "Roboto-Light", size: 18)
        searchBar.keyboardAppearance = UIKeyboardAppearance.Dark
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
