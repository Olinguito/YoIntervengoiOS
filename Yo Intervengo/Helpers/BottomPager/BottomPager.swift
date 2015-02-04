//
//  BottomPager.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/18/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import Foundation
import UIKit

@objc protocol BottomPagerDelegate{
    optional func pageSetted(index:NSIndexPath)
    optional func goDetail(sender:UIButton)
}

class BottomPager:  UIView,UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    var delegate:BottomPagerDelegate?
    var opened = false
    let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.Dark)
    var collectionView:UICollectionView!
    var loc:[RMAnnotation]!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, array:Array<RMAnnotation>) {
        super.init(frame: frame)
        loc = array
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
        blurView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.addSubview(blurView)
        
        let coll = LayoutPager()
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
        
        let shadowW = frame.width*0.07
        
        var left = Gradient(frame: CGRect(x: 0, y: 0, width: shadowW, height: frame.size.height), type: "Left")
        addSubview(left)
        
        var right = Gradient(frame: CGRect(x: frame.size.width - shadowW, y: 0, width: shadowW , height: frame.size.height), type: "Right")
        addSubview(right)
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
    
    //Collection delegate
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return loc.count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as publicWCell
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 1.0)
        cell.goReport.addTarget(self, action: Selector("goReport:"), forControlEvents: UIControlEvents.TouchUpInside)
        cell.follower.tag = indexPath.row
        cell.follower.addTarget(self, action: Selector("followReport:"), forControlEvents: UIControlEvents.TouchUpInside)
        cell.alpha = 0
        return cell
    }
    
    
    func goReport(sender:UIButton!){
        println("going there")
        self.delegate?.goDetail!(sender)
    }
    
    func followReport(sender:UIButton!){
        println("Following")
        var cell = collectionView(self.collectionView, cellForItemAtIndexPath: NSIndexPath(forRow: sender.tag, inSection: 0)) as publicWCell
        cell.follower.backgroundColor = UIColor.greyLight()
        cell.follower.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cell.follower.tintColor = UIColor.whiteColor()
        cell.follow()
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
        var s = CGFloat((90.0*M_PI)/180)
        var rotation = CATransform3DMakeRotation(s, 0.0, 0.7, 0.4)
        //var fg = CATransform3DMakeScale(0.0, 0.23, 0.34)
        //rotation.m34 = -1.0/600.0
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 0.5)
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.8)
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
        go2Page(visibleIndexPath!)
        self.delegate?.pageSetted!(visibleIndexPath!)
    }
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate{
            var visibleRect = CGRect(x: self.collectionView.contentOffset.x, y: self.collectionView.contentOffset.y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            var visiblePoint = CGPointMake(CGRectGetMidX(visibleRect), CGRectGetMidY(visibleRect));
            var visibleIndexPath = self.collectionView.indexPathForItemAtPoint(visiblePoint)
            go2Page(visibleIndexPath!)
            self.delegate?.pageSetted!(visibleIndexPath!)
        }
    }
}