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
    var loc:[Report]!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(frame: CGRect, array:Array<Report>) {
        super.init(frame: frame)
        loc = array
        
        var v1 = UIView(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        v1.backgroundColor = UIColor(red:0.776, green:0.776, blue:0.776, alpha: 0.9)
        //self.addSubview(v1)
        
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.setTranslatesAutoresizingMaskIntoConstraints(false)
        blurView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        self.addSubview(blurView)
        
        let coll = LayoutPager()
        coll.scrollDirection = UICollectionViewScrollDirection.Horizontal
        coll.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        coll.itemSize = CGSize(width: 245, height: 150)

        collectionView = UICollectionView(frame: blurView.frame, collectionViewLayout: coll)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.pagingEnabled = true
        collectionView.registerNib(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CollectionViewCell")
        self.addSubview(collectionView)
        
        let shadowW = frame.width*0.10
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
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionViewCell", forIndexPath: indexPath) as! publicWCell
        var report:Report = loc[indexPath.row] as Report
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 1.0)
        cell.iconPublic.image = UIImage(named: report.category.icon)
        
        cell.imgPublic.image = UIImage(named: "image-placeholder")
        
        if (report.image == nil){
            dispatch_async(dispatch_get_global_queue(0, 0)) {
                var url = "http://res.cloudinary.com/demo/image/fetch/w_170,h_75,c_fill,e_saturation:50,f_auto/" + report.urlImage
                let image = UIImage(data: NSData(contentsOfURL: NSURL(string: url)!)!)
                dispatch_async(dispatch_get_main_queue()) {
                    (self.loc[indexPath.row] as Report).image = image
                    cell.imgPublic.image = image
                }
            }
        }else{
            cell.imgPublic.image = report.image
        }
        cell.imgPublic.layer.masksToBounds = true
        cell.lblTitle.text = report.title
        cell.subTitle.text = report.category.name
        cell.lblDescr.text = report.desc
        cell.goReport.addTarget(self, action: Selector("goReport:"), forControlEvents: UIControlEvents.TouchUpInside)
        cell.goReport.tag = 0//infoPin["num"] as! Int
        cell.bgIcon.backgroundColor = report.color
        cell.follower.setTitle(String(report.followers), forState: UIControlState.Normal)
        cell.follower.tag = indexPath.row
        cell.follower.addTarget(self, action: Selector("followReport:"), forControlEvents: UIControlEvents.TouchUpInside)
        cell.alpha = 0
        return cell
    }
    
    
    func goReport(sender:UIButton!){
        self.delegate?.goDetail!(sender)
    }
    
    func followReport(sender:UIButton!){
        var cell = collectionView(self.collectionView, cellForItemAtIndexPath: NSIndexPath(forRow: sender.tag, inSection: 0)) as! publicWCell
        var report:Report = loc[sender.tag] as Report
        cell.follower.backgroundColor = UIColor.greyLight()
        cell.follower.backgroundColor = report.color
        cell.follower.setTitle(String(report.followers+1), forState: UIControlState.Normal)
        cell.follower.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cell.follower.tintColor = UIColor.whiteColor()
        cell.follow()
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
        cell.alpha = 1
        cell.layer.shadowOffset = CGSizeMake(0, 0) 
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