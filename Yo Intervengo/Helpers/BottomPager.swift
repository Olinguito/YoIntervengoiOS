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
        coll.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        coll.itemSize = CGSize(width: 90, height: 90)
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
    
    
}