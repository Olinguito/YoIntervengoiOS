//
//  SelectSubcategoryViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/9/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit
import pop

public class SelectSubcategoryViewController: BlurredViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    internal var category:Category?
    
    private var subcategories:[Category] = [Category]()
    
    private var subcategoryList:UICollectionView!
    private var delegate:JOCentralMenuDelegate?
    private var type:Int!
    
    private var heightConstraint:NSLayoutConstraint!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.addUIComponents()
        self.addUIConstraints()
    }
    
    private func addUIComponents(){
        let coll = UICollectionViewFlowLayout()
        coll.scrollDirection = UICollectionViewScrollDirection.Vertical
        coll.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        coll.itemSize = CGSize(width: 130, height: 57)
        
        subcategoryList = UICollectionView(frame: self.view.frame, collectionViewLayout: coll)
        subcategoryList.backgroundColor = UIColor.redColor()
        subcategoryList.dataSource = self
        subcategoryList.delegate = self
        subcategoryList.backgroundColor = UIColor.clearColor()
        subcategoryList.registerNib(UINib(nibName: "SubCategoryCell", bundle: nil), forCellWithReuseIdentifier: "SubCategoryCell")
        self.view.addSubview(subcategoryList)
    }
    
    private func addUIConstraints(){
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[c]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["c":subcategoryList]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[c]-58-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["c":subcategoryList]))
        
        heightConstraint = NSLayoutConstraint(item: self.subcategoryList, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 0)
        self.view.addConstraint(heightConstraint)
    }
    
    //COLLECTION VIEW DELEGATE
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subcategories.count
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SubCategoryCell", forIndexPath: indexPath) as! SubCategoryCell
        
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 1.0)
        cell.btnSubCat.addTarget(self, action: #selector(JOCentralMenu.goSubCategory(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        cell.lblSubCat.text = (subcategories[indexPath.row]).name
        cell.lblSubCat.textColor = UIColor.addThemeContrast()
        cell.alpha = 0
        cell.type = self.type
        cell.btnSubCat.tag = Int((subcategories[indexPath.row]).id!)
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.8)
        cell.alpha = 0
        UIView.commitAnimations()
    }
    
    public func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 0.5)
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.4)
        cell.alpha = 1
        cell.layer.shadowOffset = CGSizeMake(0, 0)
        UIView.commitAnimations()
    }
    
}