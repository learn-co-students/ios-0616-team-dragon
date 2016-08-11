//
//  Mapable.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/11/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import MapKit
protocol Mapable {
    
}

extension Mapable {
    
    func initMapBlock() {
        let appController = AppController(coder: NSCoder.empty())
        let mapView = MKMapView()
        mapView.frame = CGRectMake(0, 66, appController!.view.frame.width, 700)
        mapView.mapType = MKMapType.Standard
        mapView.zoomEnabled = true
        mapView.scrollEnabled = true
        appController!.view.addSubview(mapView)
    }
}
