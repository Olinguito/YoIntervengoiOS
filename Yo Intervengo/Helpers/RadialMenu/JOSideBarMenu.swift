//
//  JOSideBarMenu.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/24/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit
import pop

@objc protocol JOSideBarMenuDelegate{
    optional func buttoTapped(button:UIImageView!,withSideBar sideBar:JOSideBarMenu,label:String, id:Int)
}


class JOSideBarMenu: UIView,UICollectionViewDataSource,UICollectionViewDelegate {
    var collectionView:UICollectionView!
    var data:[AnyObject]?
    var delegate:JOSideBarMenuDelegate?
    
    init(frame: CGRect, data: [AnyObject]?) {
        super.init(frame: frame)
        self.data = data
        self.layer.masksToBounds = true
        
        let coll = UICollectionViewFlowLayout()
        coll.scrollDirection = UICollectionViewScrollDirection.Vertical
        //coll.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        coll.itemSize = CGSize(width: 320, height: 61)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: coll)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
        //        collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: 4, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Bottom, animated: true)
        
        collectionView.registerNib(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        self.addSubview(collectionView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //COLLECTION VIEW DELEGATE
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data!.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCollViewCell
        
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 1.0)
        cell.lblTitle.text = ((data![indexPath.row] as! Category).name)
        cell.lblTitle.textColor = UIColor.addThemeContrast()
        cell.imgCategory.image = UIImage(named: ((data![indexPath.row] as! Category).icon)!)
        cell.alpha = 0
        return cell
    }
    
    func goSubCategory(sender:UIButton!){
        let a:CategoryCollViewCell = self.collectionView(self.collectionView, cellForItemAtIndexPath: NSIndexPath(forRow: sender.tag, inSection: 0)) as! CategoryCollViewCell
        self.delegate?.buttoTapped!(a.imgCategory, withSideBar: self,label: a.lblTitle.text!, id: Int((sender.titleLabel?.text)!) ?? 1)
    }
    
    func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.8)
        cell.alpha = 0
        UIView.commitAnimations()
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
        let s = CGFloat((90.0*M_PI)/180)
        _ = CATransform3DMakeRotation(s, 0.0, 0.7, 0.4)
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 0.5)
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.4)
        cell.alpha = 1
        cell.layer.shadowOffset = CGSizeMake(0, 0)        
        UIView.commitAnimations()
    }
    
    func closeSideView(){
        let pop     = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
        pop.toValue = 0
        self.pop_addAnimation(pop, forKey: "Animation")
        removeFromSuperview()
    }
}