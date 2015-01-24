//
//  JOSideBarMenu.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/24/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class JOSideBarMenu: UIView,UICollectionViewDataSource,UICollectionViewDelegate {
    var collectionView:UICollectionView!
    var data:NSMutableArray!

    
    init(frame: CGRect, data: NSMutableArray?) {
        super.init(frame: frame)
        
        let coll = UICollectionViewFlowLayout()
        coll.scrollDirection = UICollectionViewScrollDirection.Vertical
        coll.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 40, right: 0)
        coll.itemSize = CGSize(width: 320, height: 61)
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: coll)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
        //collectionView.pagingEnabled = true
        collectionView.scrollToItemAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.Top, animated: true)
        collectionView.registerNib(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        self.addSubview(collectionView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //COLLECTION VIEW DELEGATE
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return data.count
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as UICollectionViewCell
 //       cell.lblTitle.text = (data[indexPath.row])["Text"] as NSString
 //       cell.imgCategory.image = UIImage(named: (data[indexPath.row])["Image"] as NSString)
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 1.0)
        
        cell.alpha = 0
        return cell
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
        //var fg = CATransform3DMakeScale(0.0, 0.23, 0.34)
        //rotation.m34 = -1.0/600.0
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 0.5)
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.4)
        //cell.layer.transform = fg
        cell.alpha = 1
        cell.layer.shadowOffset = CGSizeMake(0, 0)
        //        var transform = CGAffineTransformMakeScale(1, 0.9)
        //      cell.transform = transform;
        
        UIView.commitAnimations()
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        var visibleRect = CGRect(x: self.collectionView.contentOffset.x, y: self.collectionView.contentOffset.y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
        var visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
        var visibleIndexPath = self.collectionView.indexPathForItemAtPoint(visiblePoint)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            var visibleRect = CGRect(x: self.collectionView.contentOffset.x, y: self.collectionView.contentOffset.y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            var visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
            var visibleIndexPath = self.collectionView.indexPathForItemAtPoint(visiblePoint)
        }
    }
    
}
