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
    optional func picTapped(index:UIButton)
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
        coll.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)

        coll.minimumLineSpacing = 0
        coll.minimumInteritemSpacing = 0
        
        
        coll.itemSize = CGSize(width: 104, height: 104)
        collectionView = UICollectionView(frame: CGRect(x: 0,y: 0,width: frame.width,height: frame.height) , collectionViewLayout: coll)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.registerNib(UINib(nibName: "PicContainerCell", bundle: nil), forCellWithReuseIdentifier: "PicContainerCell")
        self.addSubview(collectionView)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1
    }
    
    
    func go2Page (page:NSIndexPath){
        collectionView.scrollToItemAtIndexPath(page, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated: true)
    }
    
    //Collection delegate
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PicContainerCell", forIndexPath: indexPath) as! PicContainerCell
        var pic = data.objectAtIndex(indexPath.row) as! Picture
        cell.alpha = 0
        cell.layer.cornerRadius = 2
        cell.imageBtn.setImage(UIImage(named: "image-placeholder"), forState: UIControlState.Normal)
        cell.imageBtn.tag = pic.id
        if (pic.image == nil){
            dispatch_async(dispatch_get_global_queue(0, 0)) {
                var url = "http://res.cloudinary.com/demo/image/fetch/w_104,h_104,c_fill,e_saturation:50,f_auto/" + pic.urlImage
                let image = UIImage(data: NSData(contentsOfURL: NSURL(string: url)!)!)
                dispatch_async(dispatch_get_main_queue()) {
                    (self.data.objectAtIndex(indexPath.row) as! Picture).image = image
                    cell.imageBtn.setImage(image, forState: UIControlState.Normal)
                }
            }
        }else{
            cell.imageBtn.setImage(pic.image, forState: UIControlState.Normal)
        }
        cell.imageBtn.addTarget(self, action: Selector("goPicture:"), forControlEvents: UIControlEvents.TouchUpInside)
        return cell
    }
    
    func goPicture(sender:UIButton!){
        self.delegate?.picTapped!(sender)
    }
    
    func followReport(sender:UIButton!){
        var cell = collectionView(self.collectionView, cellForItemAtIndexPath: NSIndexPath(forRow: sender.tag, inSection: 0)) as! publicWCell
        cell.follower.backgroundColor = UIColor.greyLight()
        cell.follower.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        cell.follower.tintColor = UIColor.whiteColor()
        cell.follow()
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
        cell.alpha = 1
        UIView.commitAnimations()
    }
}