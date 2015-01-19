//
//  BottomPager.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/18/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import Foundation
import UIKit


class BottomPager:  UIView,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var opened = false
    let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    var collectionView:UICollectionView!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
        blurView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.addSubview(blurView)
        
        let coll = UICollectionViewFlowLayout()
        coll.scrollDirection = UICollectionViewScrollDirection.Horizontal
        coll.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        coll.itemSize = CGSize(width: 274, height: 180)
        
        collectionView = UICollectionView(frame: blurView.frame, collectionViewLayout: coll)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.pagingEnabled = true
        collectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.addSubview(collectionView)
    }
    
    func show(){
        if !opened{
            let popBasicAn = POPSpringAnimation(propertyNamed: kPOPViewCenter)
            popBasicAn.toValue = NSValue(CGPoint: CGPointMake(self.center.x, self.center.y-self.frame.size.height))
            self.pop_addAnimation(popBasicAn, forKey: "center")
            opened = true
        }
    }
    
    func hide(){
        if opened{
            let popBasicAn = POPSpringAnimation(propertyNamed: kPOPViewCenter)
            popBasicAn.toValue = NSValue(CGPoint: CGPointMake(self.center.x, self.center.y+self.frame.size.height))
            self.pop_addAnimation(popBasicAn, forKey: "center")
            opened = false
        }
    }
    
    func go2Page (page:NSIndexPath){
        collectionView.scrollToItemAtIndexPath(page, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
    }
    
    //collection delegate
        
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as UICollectionViewCell
//        cell.backgroundColor = UIColor.greenColor()
       /* cell.textLabel?.text = "\(indexPath.section):\(indexPath.row)"
        cell.imageView?.image = UIImage(named: "Pin")*/
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
        var s = CGFloat((90.0*M_PI)/180)
        var rotation = CATransform3DMakeRotation(s, 0.0, 0.7, 0.4)
        rotation.m34 = -1.0/600.0
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 0.5)
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.8)
        cell.layer.transform = CATransform3DIdentity
        cell.alpha = 1
        cell.layer.shadowOffset = CGSizeMake(0, 0)
        UIView.commitAnimations()
    }
    
    
}