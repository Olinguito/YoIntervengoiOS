//
//  JOSideBarMenu.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/24/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

@objc protocol JOSideBarMenuDelegate{
    optional func buttoTapped(button:UIImageView!,withSideBar sideBar:JOSideBarMenu,label:String)
}


class JOSideBarMenu: UIView,UICollectionViewDataSource,UICollectionViewDelegate {
    var collectionView:UICollectionView!
    var data:NSMutableArray!
    var delegate:JOSideBarMenuDelegate?
    
    init(frame: CGRect, data: NSMutableArray?) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        
        let coll = UICollectionViewFlowLayout()
        coll.scrollDirection = UICollectionViewScrollDirection.Vertical
        //coll.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        coll.itemSize = CGSize(width: 320, height: 61)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: coll)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: 4, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Bottom, animated: true)
        
        collectionView.registerNib(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        self.addSubview(collectionView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //COLLECTION VIEW DELEGATE
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return data.count
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as CategoryCollViewCell
        cell.btnCategory.tag = indexPath.row
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 1.0)
        cell.btnCategory.addTarget(self, action: Selector("goSubCategory:"), forControlEvents: UIControlEvents.TouchUpInside)
        cell.alpha = 0
        return cell
    }
    
    func goSubCategory(sender:UIButton!){
        var a:CategoryCollViewCell = self.collectionView(self.collectionView, cellForItemAtIndexPath: NSIndexPath(forRow: sender.tag, inSection: 0)) as CategoryCollViewCell
        self.delegate?.buttoTapped!(a.imgCategory, withSideBar: self,label: a.lblTitle.text!)
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
