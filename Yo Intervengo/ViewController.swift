//
//  ViewController.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 1/11/15.
//  Copyright (c) 2015 Olinguito. All rights reserved.
//

import UIKit


class ViewController: UIViewController,RMMapViewDelegate {

    
    @IBOutlet weak var map: RMMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //let source = RMMapboxSource(mapID: "olinguito.c389ab51")
        //RMConfiguration(path: "pk.eyJ1Ijoib2xpbmd1aXRvIiwiYSI6IkVGeE41bE0ifQ.TrGnR7v_7HRJUsiM2h_3dQ")
        //let source = RMMapboxSource(mapID: "olinguito.knpn8bl7")
        
        let source = RMMapboxSource(mapID: "examples.map-z2effxa8")
        map = RMMapView(frame: view.frame, andTilesource: source)
        map.delegate = self
        
        view.addSubview(map)
        map.setCenterCoordinate(CLLocationCoordinate2DMake(4.6615,-74.0688), animated: true)
        map.setZoom(11, animated: true)
        
        map.showsUserLocation = true
        map.tintColor = UIColor.greenColor()
        
        let ann = RMAnnotation(mapView: map, coordinate: CLLocationCoordinate2DMake(4.6615,-74.0698), andTitle:"Hola")
        ann.subtitle = "la con"
        
        let ann2 = RMAnnotation(mapView: map, coordinate: CLLocationCoordinate2DMake(4.6625,-74.0698), andTitle:"Hola")
        ann2.subtitle = "la con"
        
        map.addAnnotation(ann)
        map.addAnnotation(ann2)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func mapView(mapView: RMMapView!, layerForAnnotation annotation: RMAnnotation!) -> RMMapLayer! {

        if (annotation.isUserLocationAnnotation){
            return nil
        }
        let marker = RMMarker(UIImage: UIImage(named: "Pin"))
        marker.canShowCallout = true
        return marker
    }
    
}

