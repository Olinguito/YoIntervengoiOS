//
//  SelectLocationViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/15/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit
import Mapbox
import pop
import DGActivityIndicatorView

class SelectLocationViewController: BlurredViewController, MGLMapViewDelegate {
    
    private var map: MGLMapView!
    private var located:Bool = false
    private var actionBtn:HorizontalButtonsView!
    private var activityIndicatorView:DGActivityIndicatorView!
    private var imgPin:UIImageView!
    var type:Type!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addUIComponents()
        self.addUIConstraints()
    }
    
    private func addUIComponents(){
        map = MapView.sharedInstance.map
        self.view.addSubview(map)
        
        
        actionBtn          = HorizontalButtonsView()
        actionBtn.delegate = self
        actionBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(actionBtn)
        
        imgPin       = UIImageView(image: UIImage(named: "new_pin_\(type!.slug!)"))
        imgPin.alpha = 0
        imgPin.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imgPin)
        
        
        let tintColor = type!.slug! == "report" ? UIColor.orangeYI() : UIColor.blueYI()
        activityIndicatorView = DGActivityIndicatorView(type: DGActivityIndicatorAnimationType.NineDots, tintColor: tintColor)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(activityIndicatorView)
        self.activityIndicatorView.startAnimating()
        
        map.delegate = self
    }
    
    private func addUIConstraints(){
        let space   = QPostHeightWithSpace
        let metrics = ["s":space]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-50-[map]-10-[a(s)]-83-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["map":map,"a":actionBtn]))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[map]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["map":map]))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[a]-10-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: metrics, views: ["a":actionBtn]))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.activityIndicatorView, attribute: .CenterX, relatedBy: .Equal, toItem: self.map, attribute: .CenterX, multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.activityIndicatorView, attribute: .CenterY, relatedBy: .Equal, toItem: self.map, attribute: .CenterY, multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.imgPin, attribute: .CenterX, relatedBy: .Equal, toItem: self.map, attribute: .CenterX, multiplier: 1, constant: 0))
        
        self.view.addConstraint(NSLayoutConstraint(item: self.imgPin, attribute: .CenterY, relatedBy: .Equal, toItem: self.map, attribute: .CenterY, multiplier: 1, constant: -10))
    }
    
    func mapView(mapView: MGLMapView, didUpdateUserLocation userLocation: MGLUserLocation?) {
        if !located{
            self.map.setCenterCoordinate((userLocation?.coordinate)!, animated: true)
            located = true
        }
    }
    
    func mapViewDidFinishLoadingMap(mapView: MGLMapView) {
        let an     = POPSpringAnimation(propertyNamed: kPOPViewAlpha)
        an.toValue = 1
        self.map.pop_addAnimation(an, forKey: "MapAlpha")
        self.imgPin.pop_addAnimation(an, forKey: "MapAlpha")
        self.activityIndicatorView.stopAnimating()
        self.activityIndicatorView.removeFromSuperview()
        self.map.setCenterCoordinate((map.userLocation?.coordinate)!, zoomLevel: 18, animated: true)
    }
}

extension SelectLocationViewController: HorizontalButtonsViewDelegate{
    
    func tappedLeftButton(horizontalView: HorizontalButtonsView) {
        (self.navigationController as! ReportNavigationViewController)._goBack()
    }
    
    func tappedRightButton(horizontalView: HorizontalButtonsView) {
        
    }
    
}