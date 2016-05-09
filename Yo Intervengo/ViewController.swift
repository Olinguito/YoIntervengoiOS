//
//  ViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/11/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit
import Mapbox

class ViewController: GenericViewController,BottomPagerDelegate {
    var located:Bool = false
    
    
    var openedReport:Bool = false
    
    
    var map: MGLMapView!
    
    var animator:UIDynamicAnimator!
    var attachmentBeh: UIAttachmentBehavior!
    var snaBeh: UISnapBehavior!
    var initLoc: CGPoint!
    var test: BottomPager!
    var loc:[Report]! = []
    
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnLocal: UIButton!
    @IBOutlet weak var btnReport: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize(){
        APIManagerClass.getReports()
        loc = []
        map = MGLMapView(frame: view.frame)
        map.delegate = self
        view.insertSubview(map, belowSubview: btnReport)
        map.minimumZoomLevel  = 11
        map.showsUserLocation = true
        map.userTrackingMode  = .FollowWithHeading
        map.tintColor         = UIColor.greenColor()
        map.setZoomLevel(11, animated: true)
        
        animator = UIDynamicAnimator(referenceView: view)
        view.insertSubview(menuView, belowSubview: btnMenu)
        let fram = self.view.frame.size
        let grad1 = Gradient(frame: CGRect(x: 0, y: 0, width: fram.width, height: 64), type: "Top")
        self.view.insertSubview(grad1, aboveSubview: map)
        test = BottomPager(frame: CGRect(x: 0, y: fram.height, width: fram.width, height: 190), array: loc)
        self.view.insertSubview(test, belowSubview: menuView)
        
        
        map.logoView.alpha          = 0
        map.attributionButton.alpha = 0
    }
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        listView.center = CGPoint(x: ((self.view.frame.width*1.5)-4), y: self.view.frame.height/2)
        initLoc = listView.center
        actView = 0
        self.menuView.setColor(actView+3330)
    }
    
    
    func mapView(mapView: MGLMapView, didUpdateUserLocation userLocation: MGLUserLocation?) {
        if !located{
            self.map.setCenterCoordinate((userLocation?.coordinate)!, animated: true)
            located = true
        }
    }
    
    // MAP DELEGATE
    //    
    //    func longPressOnMap(map: RMMapView!, at point: CGPoint) {
    //        if self.map.zoom > 14{
    //            var thisMenu = JOaddReport(frame: self.view.frame, bttnClose: btnReport, labels: 0, coodinate: map.pixelToCoordinate(point))
    //            thisMenu.delegate = self
    //            self.view.addSubview(thisMenu)
    //            thisMenu.showMenu(1, atPoint: point)
    //        }else{
    //            alert.setText("Ups, acercate un poco más")
    //            self.view.addSubview(alert)
    //            alert.showAlert()
    //        }
    //    }
    //    
    //    func singleTapOnMap(map: RMMapView!, at point: CGPoint) {
    //        test.hide()
    //    }
    //    
    //    func mapView(mapView: RMMapView!, layerForAnnotation annotation: RMAnnotation!) -> RMMapLayer! {
    //        if annotation.isUserLocationAnnotation{
    //            return nil
    //        }
    //        if annotation.isClusterAnnotation
    //        {
    //            let layer = RMMarker(UIImage: UIImage(named: "circle"))
    //            var southwestCoordinate = annotation.coordinate
    //            var northeastCoordinate = annotation.coordinate
    //            for plot in annotation.clusteredAnnotations {
    //                var latititude = Float(plot.coordinate.latitude)
    //                var longitude =  Float(plot.coordinate.longitude)
    //                if Float(southwestCoordinate.latitude) > fabsf(latititude){ southwestCoordinate.latitude = CLLocationDegrees(latititude)}
    //                if Float(southwestCoordinate.longitude) > fabsf(longitude){ southwestCoordinate.longitude = CLLocationDegrees(longitude)}
    //                if Float(northeastCoordinate.latitude) < fabsf(latititude){ northeastCoordinate.latitude = CLLocationDegrees(latititude)}
    //                if Float(northeastCoordinate.longitude) < fabsf(longitude){ northeastCoordinate.longitude = CLLocationDegrees(longitude)}
    //            }
    //            var a = map.coordinateToPixel(southwestCoordinate).x - map.coordinateToPixel(northeastCoordinate).x
    //            var b = map.coordinateToPixel(northeastCoordinate).y - map.coordinateToPixel(southwestCoordinate).y
    //            var c = max(max(a, b),80)
    //            layer.bounds = CGRect(x: 0, y: -5, width: 80, height: 80)
    //            layer.changeLabelUsingText(annotation.title, font: UIFont(name: "Roboto-light", size: 38), foregroundColor: UIColor.whiteColor(), backgroundColor: UIColor.clearColor())
    //            return layer
    //        }
    //        else
    //        {
    //            var report = annotation.userInfo as! Report
    //            let marker = RMMarker(UIImage: UIImage.getPinByName(report.type, Category: report.category.icon))
    //            return marker
    //        }
    //    }
    //    
    @IBOutlet var gestureRecognizer: UIPanGestureRecognizer!
    @IBAction func HandleBorderGesture(sender: AnyObject) {
        let location = sender.locationInView(view)
        _ = sender.locationInView(listView)
        if sender.state == UIGestureRecognizerState.Began{
            animator.removeBehavior(snaBeh)
        }else if sender.state == UIGestureRecognizerState.Changed{
            listView.center = CGPoint(x: location.x+(listView.frame.width/2), y: listView.center.y)
        }else if sender.state == UIGestureRecognizerState.Ended{
            animator.removeBehavior(attachmentBeh)
            if location.x < view.frame.width/2{
                snaBeh = UISnapBehavior(item: listView, snapToPoint: CGPoint(x: view.center.x - 12, y: view.center.y))
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
        map.setCenterCoordinate(map.userLocation!.coordinate, animated: true);
    }
    
    @IBAction func search(sender: AnyObject) {
    }
    
    @IBAction func newReport(sender: AnyObject) {
        let view  = SelectReportTypeViewController()
        view.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
        view.modalTransitionStyle   = .CrossDissolve
        self.presentViewController(view, animated: true, completion: nil)
    }
    
    func pageSetted(index:NSIndexPath){
        //        map.setCenterCoordinate(map.pixelToCoordinate(CGPoint(x: map.coordinateToPixel(loc[index.row].location).x, y: map.coordinateToPixel(loc[index.row].location).y + (self.view.frame.size.height - test.frame.size.height)/2 - 100)), animated: true)
    }
    
    //MARK: DATA
    func goDetail(sender:UIButton){
        let view2 = DetailReportVC()
        view2.report = loc[sender.tag]
        view2.center = map.userLocation!.coordinate
        self.showViewController(view2, sender: self)
    }
    
    func reportCreated(report:Report){
        report.id = test.loc.count
        loc.append(report)
        test.loc.append(report)
        test.collectionView.reloadData()
        //        var annotation = RMAnnotation(mapView: self.map, coordinate: report.location, andTitle: "\(test.loc.count-1)")
        //        annotation.userInfo = report
        //        self.map.addAnnotation(annotation)
    }
    
    override func returnList(responseObject: AnyObject, url: String) {
        //        switch  url {
        //        case "reports":
        //            self.loader.dismissAnimate()
        //            var newANN:RMAnnotation!
        //            var counter = 0
        //            for report in responseObject as! NSMutableArray{
        //                let location  = report["location"] as! NSDictionary
        //                let lat       = location["lat"] as! CLLocationDegrees
        //                let lng       = location["lng"] as! CLLocationDegrees
        //                let photos    = report["photo"] as! NSDictionary
        //                let category  = report["category"] as! NSDictionary
        //                let imageIcon = category["icon"] as! String
        //                
        //                var rep           = Report(type: report["type"] as! Int)
        //                rep.id            = counter
        //                rep.idAPI         = report["id"] as! String
        //                rep.urlImage      = photos["thumbUrl"] as! String
        //                rep.followers     = 200
        //                rep.category.name = category["name"] as! String
        //                rep.category.icon = category["icon"] as! String
        //                rep.location      = CLLocationCoordinate2DMake(lat,lng)
        //                rep.title         = report["title"] as! String
        //                rep.desc          = report["description"] as! String
        //                newANN            = RMAnnotation(mapView: map, coordinate: rep.location, andTitle:(String(counter)));
        //                newANN.userInfo   = rep
        //                map.addAnnotation(newANN)
        //                loc.append(rep)
        //                counter++
        //            }
        //            test.loc = loc
        //            test.collectionView.reloadData()
        //        default: print("Any")
        //        }
    }
}

extension ViewController:MGLMapViewDelegate{
    func mapView(mapView: MGLMapView, didSelectAnnotation annotation: MGLAnnotation) {
        //        if !annotation.isUserLocationAnnotation{
        //            if annotation.isClusterAnnotation {
        //                var southwestCoordinate = annotation.coordinate
        //                var northeastCoordinate = annotation.coordinate
        //                for plot in annotation.clusteredAnnotations {
        //                    var latititude = Float(plot.coordinate.latitude)
        //                    var longitude =  Float(plot.coordinate.longitude)
        //                    if Float(southwestCoordinate.latitude) > fabsf(latititude){ southwestCoordinate.latitude = CLLocationDegrees(latititude)}
        //                    if Float(southwestCoordinate.longitude) > fabsf(longitude){ southwestCoordinate.longitude = CLLocationDegrees(longitude)}
        //                    if Float(northeastCoordinate.latitude) < fabsf(latititude){ northeastCoordinate.latitude = CLLocationDegrees(latititude)}
        //                    if Float(northeastCoordinate.longitude) < fabsf(longitude){ northeastCoordinate.longitude = CLLocationDegrees(longitude)}
        //                }
        //                map.zoomWithLatitudeLongitudeBoundsSouthWest(southwestCoordinate, northEast: northeastCoordinate, animated: true)
        //            }
        //            else{
        //                map.setCenterCoordinate(map.pixelToCoordinate(CGPoint(x: map.coordinateToPixel(annotation.coordinate).x, y: map.coordinateToPixel(annotation.coordinate).y + (self.view.frame.size.height - test.frame.size.height)/2 - 100)), animated: true)
        //                test.show()
        //                test.go2Page(NSIndexPath(forRow: annotation.title.toInt()!, inSection: 0))
        //            }
        //        }
    }
    
    
    
    
}