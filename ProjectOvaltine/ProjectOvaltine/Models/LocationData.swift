//
//  LocationData.swift
//  ProjectOvaltine
//
//  Created by Christopher Webb-Orenstein on 8/10/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//

import UIKit
import MapKit

struct LocationData {
    let initialLocation = CLLocation(latitude: 34.4248, longitude: -118.5971)
    var zipLocation : CLLocation! = nil
    let regionRadius: CLLocationDistance = 1000
    let coordinates = [["34.4313","-118.59890"],["34.4274","-118.60246"], ["34.4268","-118.60181"], ["34.4202","-118.6004"], ["34.42013","-118.59239"], ["34.42049","-118.59051"], ["34.42305","-118.59276"], ["34.42557","-118.59289"], ["34.42739","-118.59171"]]
//    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
//                                                              self.regionRadius * 2.0, self.regionRadius * 2.0)
}

