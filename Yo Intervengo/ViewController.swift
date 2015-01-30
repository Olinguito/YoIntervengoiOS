//
//  ViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/11/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit

class ViewController: UIViewController,RMMapViewDelegate,BottomPagerDelegate {
    weak var map: RMMapView!
    var openedReport:Bool = false
    var animator:UIDynamicAnimator!
    var attachmentBeh: UIAttachmentBehavior!
    var snaBeh: UISnapBehavior!
    var initLoc: CGPoint!
    var menuView: LeftMenu!
    var test: BottomPager!
    var loc:[RMAnnotation]! = []
    

    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var btnLocal: UIButton!
    @IBOutlet weak var btnReport: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let source = RMMapboxSource(mapID: "olinguito.c389ab51") //GRIS BONITO
        //let source = RMMapboxSource(mapID: "olinguito.knpn8bl7")
        //let source = RMMapboxSource(mapID: "olinguito.knpnoamp")
        //let source = RMMapboxSource(mapID: "examples.map-z2effxa8")
        map = RMMapView(frame: view.frame, andTilesource: source)
        map.delegate = self
        view.insertSubview(map, belowSubview: btnReport)
        map.setCenterCoordinate(CLLocationCoordinate2DMake(4.6615,-74.0688), animated: true)
        map.setZoom(11, animated: true)
        map.minZoom = 11
        map.showsUserLocation = true
        map.tintColor = UIColor.greenColor()
        loc.append(RMAnnotation(mapView: map, coordinate: CLLocationCoordinate2DMake(4.6015,-74.0698), andTitle:"0"))
        loc[0].userInfo = "Pin2"
        loc.append(RMAnnotation(mapView: map, coordinate: CLLocationCoordinate2DMake(4.6625,-74.0628), andTitle:"1"))
        loc[1].userInfo = "Pin"
        loc.append(RMAnnotation(mapView: map, coordinate: CLLocationCoordinate2DMake(4.6135,-74.0638), andTitle:"2"))
        loc[2].userInfo = "Pin2"
        loc.append(RMAnnotation(mapView: map, coordinate: CLLocationCoordinate2DMake(4.6245,-74.0658), andTitle:"3"))
        loc[3].userInfo = "Pin2"
        loc.append(RMAnnotation(mapView: map, coordinate: CLLocationCoordinate2DMake(4.6355,-74.0678), andTitle:"4"))
        loc[4].userInfo = "Pin"
        loc.append(RMAnnotation(mapView: map, coordinate: CLLocationCoordinate2DMake(4.6665,-74.0728), andTitle:"5"))
        loc[5].userInfo = "Pin"
        loc.append(RMAnnotation(mapView: map, coordinate: CLLocationCoordinate2DMake(4.6675,-74.0698), andTitle:"6"))
        loc[6].userInfo = "Pin2"
        loc.append(RMAnnotation(mapView: map, coordinate: CLLocationCoordinate2DMake(4.8385,-74.0598), andTitle:"7"))
        loc[7].userInfo = "Pin2"
        
        for ann in loc{
            map.addAnnotation(ann)
        }
        // hide MapBox logo
        self.map.showLogoBug = false
        // hide bottom right "i" icon
        self.map.hideAttribution = true
        
        map.clusterAreaSize = CGSize(width: 5, height: 5)
        map.positionClusterMarkersAtTheGravityCenter = true
        map.clusteringEnabled = true
        animator = UIDynamicAnimator(referenceView: view)
        menuView = LeftMenu(frame: CGRect(x: -204, y: 0, width: 204, height: view.frame.height))
        view.insertSubview(menuView, belowSubview: btnMenu)
        let fram = self.view.frame.size
        let grad1 = Gradient(frame: CGRect(x: 0, y: 0, width: fram.width, height: 64), type: "Top")
        self.view.insertSubview(grad1, aboveSubview: map)
        let grad2 = Gradient(frame: CGRect(x: 0, y: fram.height-64, width: fram.width, height: 64), type: "Bottom")
        self.view.insertSubview(grad2, aboveSubview: map)
        test = BottomPager(frame: CGRect(x: 0, y: fram.height, width: fram.width, height: 240), array: loc)
        test.delegate = self
        self.view.insertSubview(test, belowSubview: listView)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(animated: Bool) {
        listView.center = CGPoint(x: ((self.view.frame.width*1.5)-4), y: self.view.frame.height/2)
        initLoc = listView.center
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    
    // MAP DELEGATE
    
    func tapOnAnnotation(annotation: RMAnnotation!, onMap map: RMMapView!) {
        if annotation.isClusterAnnotation {
            var southwestCoordinate = annotation.coordinate
            var northeastCoordinate = annotation.coordinate
            for plot in annotation.clusteredAnnotations {
                var latititude = Float(plot.coordinate.latitude)
                var longitude =  Float(plot.coordinate.longitude)
                if Float(southwestCoordinate.latitude) > fabsf(latititude){ southwestCoordinate.latitude = CLLocationDegrees(latititude)}
                if Float(southwestCoordinate.longitude) > fabsf(longitude){ southwestCoordinate.longitude = CLLocationDegrees(longitude)}
                if Float(northeastCoordinate.latitude) < fabsf(latititude){ northeastCoordinate.latitude = CLLocationDegrees(latititude)}
                if Float(northeastCoordinate.longitude) < fabsf(longitude){ northeastCoordinate.longitude = CLLocationDegrees(longitude)}
            }
            map.zoomWithLatitudeLongitudeBoundsSouthWest(southwestCoordinate, northEast: northeastCoordinate, animated: true)
        }
        else{
            map.setCenterCoordinate(map.pixelToCoordinate(CGPoint(x: map.coordinateToPixel(annotation.coordinate).x, y: map.coordinateToPixel(annotation.coordinate).y + (self.view.frame.size.height - test.frame.size.height)/2 - 30)), animated: true)
            test.show()
            test.go2Page(NSIndexPath(forRow: annotation.title.toInt()!, inSection: 0))
        }
    }
    
    func longPressOnMap(map: RMMapView!, at point: CGPoint) {
        //if map.zoom > 15{
            /*var thisMenu = LNERadialMenu(fromPoint: point, withDataSource: self, andDelegate: self, withFrame: self.view.frame, andLabels:0)
            self.view.insertSubview(thisMenu, belowSubview: btnReport)
            thisMenu.radialMenuIdentifier = "hide"

            thisMenu.showMenu()*/
        var thisMenu = JOaddReport(frame: self.view.frame, bttnClose: btnReport, labels: 0)
            //self.view.insertSubview(thisMenu, belowSubview: btnReport)
            self.view.addSubview(thisMenu)
            thisMenu.showMenu(1, atPoint: point)
            
       // }
    }
    
    func singleTapOnMap(map: RMMapView!, at point: CGPoint) {
        test.hide()
    }
    
    
    func mapView(mapView: RMMapView!, layerForAnnotation annotation: RMAnnotation!) -> RMMapLayer! {
        if annotation.isUserLocationAnnotation{
            return nil
        }
        if annotation.isClusterAnnotation
        {
            let layer = RMMarker(UIImage: UIImage(named: "circle"))
            var southwestCoordinate = annotation.coordinate
            var northeastCoordinate = annotation.coordinate
            for plot in annotation.clusteredAnnotations {
                
                var latititude = Float(plot.coordinate.latitude)
                var longitude =  Float(plot.coordinate.longitude)
                
                if Float(southwestCoordinate.latitude) > fabsf(latititude){ southwestCoordinate.latitude = CLLocationDegrees(latititude)}
                if Float(southwestCoordinate.longitude) > fabsf(longitude){ southwestCoordinate.longitude = CLLocationDegrees(longitude)}
                if Float(northeastCoordinate.latitude) < fabsf(latititude){ northeastCoordinate.latitude = CLLocationDegrees(latititude)}
                if Float(northeastCoordinate.longitude) < fabsf(longitude){ northeastCoordinate.longitude = CLLocationDegrees(longitude)}
            }
            var a = map.coordinateToPixel(southwestCoordinate).x - map.coordinateToPixel(northeastCoordinate).x
            var b = map.coordinateToPixel(northeastCoordinate).y - map.coordinateToPixel(southwestCoordinate).y
            var c = max(max(a, b),80)
            layer.bounds = CGRect(x: 0, y: -10, width: c, height: c)
            layer.changeLabelUsingText(annotation.title, font: UIFont(name: "Roboto-light", size: 30), foregroundColor: UIColor.whiteColor(), backgroundColor: UIColor.clearColor())
            return layer
        }
        else
        {
            let marker = RMMarker(UIImage: UIImage(named: annotation.userInfo as String))
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
        map.setCenterCoordinate(map.userLocation.coordinate, animated: true);
    }
    @IBAction func search(sender: AnyObject) {
    }
    @IBAction func newReport(sender: AnyObject) {        
        var thisMenu = JOaddReport(frame: self.view.frame, bttnClose: btnReport, labels: 1)
        //self.view.insertSubview(thisMenu, belowSubview: btnReport)
        self.view.addSubview(thisMenu)
        thisMenu.showMenu(1, atPoint: sender.center)
        
    }
    
    func pageSetted(index:NSIndexPath){
        map.setCenterCoordinate(map.pixelToCoordinate(CGPoint(x: map.coordinateToPixel(loc[index.row].coordinate).x, y: map.coordinateToPixel(loc[index.row].coordinate).y + (self.view.frame.size.height - test.frame.size.height)/2 - 30)), animated: true)
    }
    
    func goDetail(sender:UIButton){
        //var view2 = self.storyboard?.instantiateViewControllerWithIdentifier("DetailReport") as UIViewController
        var view2 = DetailReportVC()
        self.showViewController(view2, sender: self)
    }
}

