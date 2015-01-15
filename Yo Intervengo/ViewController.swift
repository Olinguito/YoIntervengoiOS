//
//  ViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/11/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class ViewController: UIViewController,RMMapViewDelegate {
    weak var map: RMMapView!
    var animator:UIDynamicAnimator!
    var attachmentBeh: UIAttachmentBehavior!
    var snaBeh: UISnapBehavior!
    var initLoc: CGPoint!
    var menuView: LeftMenu!
    
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnLocal: UIButton!
    @IBOutlet weak var btnReport: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //let source = RMMapboxSource(mapID: "olinguito.c389ab51")
        //RMConfiguration(path: "pk.eyJ1Ijoib2xpbmd1aXRvIiwiYSI6IkVGeE41bE0ifQ.TrGnR7v_7HRJUsiM2h_3dQ")
        //let source = RMMapboxSource(mapID: "olinguito.knpn8bl7")
        //let source = RMMapboxSource(mapID: "olinguito.knpnoamp")
        let source = RMMapboxSource(mapID: "examples.map-z2effxa8")
        map = RMMapView(frame: view.frame, andTilesource: source)
        map.delegate = self
        view.insertSubview(map, belowSubview: listView)
        map.setCenterCoordinate(CLLocationCoordinate2DMake(4.6615,-74.0688), animated: true)
        map.setZoom(11, animated: true)
        map.showsUserLocation = true
        map.tintColor = UIColor.greenColor()
        let ann = RMAnnotation(mapView: map, coordinate: CLLocationCoordinate2DMake(4.6615,-74.0698), andTitle:"")
        let ann2 = RMAnnotation(mapView: map, coordinate: CLLocationCoordinate2DMake(4.6625,-74.0698), andTitle:"")
        map.addAnnotation(ann)
        map.addAnnotation(ann2)
        map.clusterAreaSize = CGSize(width: 30, height: 40)
        map.clusteringEnabled = true
        animator = UIDynamicAnimator(referenceView: view)
        initLoc = listView.center
        menuView = LeftMenu(frame: CGRect(x: -204, y: 0, width: 204, height: view.frame.height))
        view.insertSubview(menuView, belowSubview: btnMenu)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func mapView(mapView: RMMapView!, layerForAnnotation annotation: RMAnnotation!) -> RMMapLayer! {
        if annotation.isUserLocationAnnotation{
            return nil
        }
        if annotation.isClusterAnnotation
        {
            let layer = RMMarker(UIImage: UIImage(named: "circle"))
            layer.bounds = CGRect(x: 0, y: -10, width: 75, height: 75)
            layer.changeLabelUsingText(annotation.title, font: UIFont(name: "Roboto-light", size: 30), foregroundColor: UIColor.whiteColor(), backgroundColor: UIColor.clearColor())
            return layer
        }
        else
        {
            //map.setCenterCoordinate(annotation.coordinate, animated: true)
            let marker = RMMarker(UIImage: UIImage(named: "Pin"))
            marker.canShowCallout = true
            let top = CallOutTop(frame: CGRect(x: 0, y: 0, width: 269, height: 75))
            let bottom =  CallOutBottom(frame: CGRect(x: 0, y: 0, width: 269, height: 52))
            marker.topCalloutAccessoryView = top
            marker.bottomCalloutAccessoryView = bottom
            return marker
        }
    }
    @IBOutlet var gestureRecognizer: UIPanGestureRecognizer!
    @IBAction func HandleBorderGesture(sender: AnyObject) {
        let location = sender.locationInView(view)
        let view2 = sender.locationInView(listView)
        if sender.state == UIGestureRecognizerState.Began{
            animator.removeBehavior(snaBeh)
        }else if sender.state == UIGestureRecognizerState.Changed{
            listView.center = CGPoint(x: location.x+(listView.frame.width/2), y: listView.center.y)
        }else if sender.state == UIGestureRecognizerState.Ended{
            animator.removeBehavior(attachmentBeh)
            if location.x < view.frame.width/2{
                snaBeh = UISnapBehavior(item: listView, snapToPoint: view.center)
            }else{
                snaBeh = UISnapBehavior(item: listView, snapToPoint: initLoc)
            }
            animator.addBehavior(snaBeh)
        }
    }
    @IBAction func getMenu(sender: AnyObject) {
        menuView.interact()
    }
    @IBAction func getLocation(sender: AnyObject) {
    }
    @IBAction func search(sender: AnyObject) {
    }
    @IBAction func newReport(sender: AnyObject) {
    }
}

