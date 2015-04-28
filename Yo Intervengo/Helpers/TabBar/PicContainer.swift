//
//  PicContainer.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 2/24/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import Foundation
import UIKit

@objc protocol PicContainerDelegate{
    optional func picTapped(index:Int)
}


class PicContainer: UIView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    var delegate:PicContainerDelegate?
    var data:NSMutableArray!
    
    var collectionView:UICollectionView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, array:NSMutableArray) {
        super.init(frame: frame)
        data = array
        let coll = UICollectionViewFlowLayout()
        coll.scrollDirection = UICollectionViewScrollDirection.Vertical
        coll.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        coll.itemSize = CGSize(width: 90, height: 90)
        collectionView = UICollectionView(frame: CGRect(x: 0,y: 0,width: 320,height: frame.height) , collectionViewLayout: coll)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.registerNib(UINib(nibName: "PicContainerCell", bundle: nil), forCellWithReuseIdentifier: "PicContainerCell")
        self.addSubview(collectionView)
    }
    
    
    func go2Page (page:NSIndexPath){
        collectionView.scrollToItemAtIndexPath(page, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
    }
    
    //Collection delegate
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PicContainerCell", forIndexPath: indexPath) as! PicContainerCell
        cell.alpha = 0
        cell.layer.cornerRadius = 5
        cell.imageBtn.addTarget(self, action: Selector("goPicture:"), forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    
    func goPicture(sender:UIButton!){
        self.delegate?.picTapped!(sender.tag)
    }
    
    func followReport(sender:UIButton!){
        var cell = collectionView(self.collectionView, cellForItemAtIndexPath: NSIndexPath(forRow: sender.tag, inSection: 0)) as! publicWCell
        cell.follower.backgroundColor = UIColor.greyLight()
        cell.follower.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cell.follower.tintColor = UIColor.whiteColor()
        cell.follow()
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
        var s = CGFloat((90.0*M_PI)/180)
        var rotation = CATransform3DMakeRotation(s, 0.0, 0.7, 0.4)
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 0.5)
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.8)
        cell.alpha = 1
        cell.layer.shadowOffset = CGSizeMake(0, 0)
        UIView.commitAnimations()
    }
}