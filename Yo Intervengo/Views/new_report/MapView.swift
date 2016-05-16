//
//  MapView.swift
//  Yo Intervengo
//
//  Created by Jorge Raul Ovalle Zuleta on 5/16/16.
//  Copyright © 2016 Olinguito. All rights reserved.
//

import UIKit
import Mapbox

class MapView {
    static let sharedInstance = MapView()
    var map:MGLMapView!
    
    init(){
        map                     = MGLMapView()
        map.backgroundColor     = UIColor.addThemeBg()
        map.zoomLevel           = 15
        map.minimumZoomLevel    = 15
        map.maximumZoomLevel    = 20
        map.layer.cornerRadius  = 15
        map.rotateEnabled       = false
        map.allowsTilting       = false
        map.layer.masksToBounds = true
        map.userTrackingMode    = MGLUserTrackingMode.None
        map.showsUserLocation   = true
        map.alpha               = 0
        map.tintColor           = UIColor.greenColor()
        map.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
    deinit{
        print("deinit???")
    }
}
