//
//  MapKitViewController.swift
//  ProjectOvaltine
//
//  Created by Colin Walsh on 8/8/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//
// This makes the

import LFHeatMap
import Foundation
import MapKit

class MapKitViewController: UIViewController, MKMapViewDelegate {
    
    let mapView = MKMapView()
    let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
    var zipLocation : CLLocation! = nil
    let regionRadius: CLLocationDistance = 1000
    let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
    
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
        let api = CitySDKAPIClient()
        
        api.sendAPIRequest()
        
     
        mapView.frame = view.frame
        mapView.delegate = self
        view.addSubview(mapView)
        
       centerMapOnLocation(self.initialLocation)
       getLocationFromZipcode("08540")
        
       
       
       
        
    }
    
    //
    
    func centerMapOnLocation(location: CLLocation) {
       let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  self.regionRadius * 2.0, self.regionRadius * 2.0)
        
        self.mapView.setRegion(coordinateRegion, animated: true)
        
        
    }

    func getLocationFromZipcode(zipcode: String){
        var placemark: CLPlacemark!
        
        CLGeocoder().geocodeAddressString(zipcode, completionHandler: {(placemarks, error) in
            if ((error) != nil) {
                self.alert.title = "Zip not found!"
                self.alert.message = "You entered an invalid zip"
                self.alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                self.presentViewController(self.alert, animated: true, completion: nil)
                print("\(error)")
                } else {
                
                placemark = (placemarks?.last)!
                self.zipLocation = placemark?.location

                self.centerMapOnLocation(self.zipLocation)
                }
           
        })
    }
    
    



}
