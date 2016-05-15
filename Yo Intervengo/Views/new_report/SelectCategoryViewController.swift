//
//  SelectCategoryViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/8/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit
import pop

public class SelectCategoryViewController: BlurredViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private var categoryList:UICollectionView!
    private var data:[Category]! = [Category]()
    private var connection:Connection!
    internal var type:Type?
    
    private var heightConstraint:NSLayoutConstraint!
    
    override public func viewDidLoad() {
        super.viewDidLoad()        
        self.addUIComponents()
        self.addUIConstraints()
    }
    
    public override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.connection = Connection()
        self.connection._getCategoriesByType(type!) { (data, error) in
            if error != nil{
                print(error)
            }else{
                self.data = data as! [Category]
                self.animatedReloadData()
            }
        }
    }
    
    private func addUIComponents(){
        let coll = UICollectionViewFlowLayout()
        coll.scrollDirection = UICollectionViewScrollDirection.Vertical
        coll.itemSize = CGSize(width: self.view.frame.size.width, height: QCategoryHeightCellSize)
        categoryList = UICollectionView(frame: self.view.frame, collectionViewLayout: coll)
        categoryList.dataSource = self
        categoryList.delegate = self
        categoryList.translatesAutoresizingMaskIntoConstraints = false
        categoryList.backgroundColor = UIColor.clearColor()
        categoryList.registerNib(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        self.view.addSubview(categoryList)
        categoryList.showsVerticalScrollIndicator = false
    }
    
    private func addUIConstraints(){
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[c]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["c":categoryList]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[c]-58-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["c":categoryList]))
        
        heightConstraint = NSLayoutConstraint(item: self.categoryList, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 0)
        self.view.addConstraint(heightConstraint)
    }
    
    private func animatedReloadData(){
        self.categoryList.reloadData()
        let freeSpace:CGFloat       = self.view.frame.height - QPostHeightWithSpace
        let estimatedHeight:CGFloat = CGFloat(self.data.count)*60 + (CGFloat(self.data.count) - 1)*10
        let an                      = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        an.toValue                  = min(estimatedHeight, freeSpace)
        heightConstraint.pop_addAnimation(an, forKey: "HeightAnimaiton")
    }
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data!.count
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CategoryCell", forIndexPath: indexPath) as! CategoryCollViewCell
        cell.imgCategory.tag = indexPath.row
        cell.layer.shadowColor = UIColor.blackColor().CGColor
        cell.lblTitle.text = ((data![indexPath.row]).name)
        cell.lblTitle?.font = UIFont(name: "Roboto-Regular", size: 15)
        cell.lblTitle.textColor = UIColor.addThemeContrast()
        cell.imgCategory.image = UIImage(named: ((data![indexPath.row]).icon)!)
        cell.alpha = 0
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.8)
        cell.alpha = 0
        UIView.commitAnimations()
    }
    
    public func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
        cell.layer.shadowColor  = UIColor.blackColor().CGColor
        cell.layer.shadowOffset = CGSizeMake(0, 0.5)
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.4)
        cell.alpha              = 1
        cell.layer.shadowOffset = CGSizeMake(0, 0)
        UIView.commitAnimations()
    }
    
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        (self.navigationController as! ReportNavigationViewController).setCategory(data[indexPath.row])
    }
}
