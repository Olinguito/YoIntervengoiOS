//
//  JOSideBarMenu.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/24/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

@objc protocol JOCentralMenuDelegate{
    optional func buttoTapped(button:UIButton!,withCentralBar sideBar:JOCentralMenu)
}


class JOCentralMenu: UIView,UICollectionViewDataSource,UICollectionViewDelegate,JOSideBarMenuDelegate {
    var collectionView:UICollectionView!
    var data:NSMutableArray!
    var delegate:JOCentralMenuDelegate?
    var type:Int!
    
    init(frame: CGRect, data: NSMutableArray?, type:Int) {
        super.init(frame: frame)
        self.data = data
        self.type = type
        
        let coll = UICollectionViewFlowLayout()
        coll.scrollDirection = UICollectionViewScrollDirection.Vertical
        coll.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        coll.itemSize = CGSize(width: 130, height: 57)
        collectionView = UICollectionView(frame: frame, collectionViewLayout: coll)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Top, animated: true)
        collectionView.registerNib(UINib(nibName: "SubCategoryCell", bundle: nil), forCellWithReuseIdentifier: "SubCategoryCell")
        self.addSubview(collectionView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //COLLECTION VIEW DELEGATE
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SubCategoryCell", forIndexPath: indexPath) as! SubCategoryCell
        
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 1.0)
        cell.btnSubCat.addTarget(self, action: Selector("goSubCategory:"), forControlEvents: UIControlEvents.TouchUpInside)
        cell.lblSubCat.text = (data.objectAtIndex(indexPath.row) as! Category).name
        cell.lblSubCat.textColor = UIColor.addThemeContrast()
        cell.alpha = 0
        cell.type = self.type
        cell.btnSubCat.tag = (data.objectAtIndex(indexPath.row) as! Category).id
        return cell
    }
    
    func goSubCategory(sender:UIButton!){
        self.delegate?.buttoTapped!(sender, withCentralBar: self)
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.8)
        cell.alpha = 0
        UIView.commitAnimations()
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
        var s = CGFloat((90.0*M_PI)/180)
        var rotation = CATransform3DMakeRotation(s, 0.0, 0.7, 0.4)
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 0.5)
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.4)
        cell.alpha = 1
        cell.layer.shadowOffset = CGSizeMake(0, 0)
        UIView.commitAnimations()
    }
    
    func closeSideView(){
        var pop = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
        pop.toValue = 0
        self.pop_addAnimation(pop, forKey: "Animation")
        removeFromSuperview()
    }
}
