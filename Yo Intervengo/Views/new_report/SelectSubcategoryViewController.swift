//
//  SelectSubcategoryViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/9/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit
import pop

public class SelectSubcategoryViewController: BlurredViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    internal var category:Category?
    private var subcategories:[Category] = [Category]()
    private var subcategoryList:UICollectionView!
    private var delegate:JOCentralMenuDelegate?
    private var connection:Connection!
    private var heightConstraint:NSLayoutConstraint!
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.addUIComponents()
        self.addUIConstraints()
        
    }
    
    public override func viewDidAppear(animated: Bool) {
        self.connection = Connection()
        self.connection._getSubcategoriesByCategory(category!) { (data, error) in
            if error != nil{
                print(error)
            }else{
                self.subcategories = data as! [Category]
                self.animatedReloadData()
            }
        }
    }
    
    private func addUIComponents(){
        let coll             = UICollectionViewFlowLayout()
        coll.scrollDirection = UICollectionViewScrollDirection.Vertical
        coll.sectionInset    = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let w = (self.view.frame.width - 60)/2
        
        coll.itemSize        = CGSize(width: w, height: 57)
        
        subcategoryList                 = UICollectionView(frame: self.view.frame, collectionViewLayout: coll)
        subcategoryList.dataSource      = self
        subcategoryList.delegate        = self
        subcategoryList.backgroundColor = UIColor.clearColor()
        subcategoryList.translatesAutoresizingMaskIntoConstraints = false
        subcategoryList.registerNib(UINib(nibName: "SubCategoryCell", bundle: nil), forCellWithReuseIdentifier: "SubCategoryCell")
        self.view.addSubview(subcategoryList)
    }
    
    private func addUIConstraints(){
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[c]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["c":subcategoryList]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[c]-58-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["c":subcategoryList]))
        
        heightConstraint = NSLayoutConstraint(item: self.subcategoryList, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: 0)
        self.view.addConstraint(heightConstraint)
    }
    
    private func animatedReloadData(){
        self.subcategoryList.reloadData()
        let freeSpace:CGFloat       = (self.view.frame.height - QPostHeightWithSpace) - 20
        let estimatedHeight:CGFloat = (self.view.frame.height - QPostHeightWithSpace) - 60
        let an                      = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        an.toValue                  = min(estimatedHeight, freeSpace)
        heightConstraint.pop_addAnimation(an, forKey: "HeightAnimaiton")
    }
    
    
    //COLLECTION VIEW DELEGATE
    
    public func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subcategories.count
    }
    
    public func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SubCategoryCell", forIndexPath: indexPath) as! SubCategoryCell
        
        cell.lblSubCat.text = (subcategories[indexPath.row]).name
        cell.lblSubCat.textColor = UIColor.addThemeContrast()
        cell.alpha = 0
        cell.btnSubCat.tag = Int((subcategories[indexPath.row]).id!)
        cell.btnSubCat.tintColor = self.category?.type?.slug == "report" ? UIColor.orangeYI() : UIColor.blueYI()
        
        if let cat = self.category{
            if let type = cat.type{
                if let slug = type.slug{
                    cell.btnSubCat.setImage(UIImage(named: "btn_sub_\(slug)_off"), forState: .Normal)
                    cell.btnSubCat.setImage(UIImage(named: "btn_sub_\(slug)_on"), forState: .Selected)
                }
            }
        }
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.8)
        cell.alpha = 0
        UIView.commitAnimations()
    }
    
    public func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let an     = POPSpringAnimation(propertyNamed: kPOPLayoutConstraintConstant)
        an.toValue = 20
        heightConstraint.pop_addAnimation(an, forKey: "HeightAnimaiton")
        _ = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(self.sendCategory(_:)), userInfo: subcategories[indexPath.row], repeats: false)
    }
    
    @objc private func sendCategory(sender:NSTimer){
        let category = (sender.userInfo as! Category)
        (self.navigationController as! ReportNavigationViewController)._setSubcategory(category)
    }
    
    public func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath){
        UIView.beginAnimations("rotation", context: nil)
        UIView.setAnimationDuration(0.4)
        cell.alpha = 1
        UIView.commitAnimations()
    }
}