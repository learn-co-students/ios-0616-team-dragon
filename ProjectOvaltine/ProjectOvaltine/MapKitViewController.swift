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
    let initialLocation = CLLocation(latitude: 34.4248, longitude: -118.5971)
    var zipLocation : CLLocation! = nil
    let regionRadius: CLLocationDistance = 1000
    let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
    let coordinates = [["34.4313","-118.59890"],["34.4274","-118.60246"], ["34.4268","-118.60181"], ["34.4202","-118.6004"], ["34.42013","-118.59239"], ["34.42049","-118.59051"], ["34.42305","-118.59276"], ["34.42557","-118.59289"], ["34.42739","-118.59171"]]
    
    var midCoordinate: CLLocationCoordinate2D
    var overlayTopLeftCoordinate: CLLocationCoordinate2D
    var overlayTopRightCoordinate: CLLocationCoordinate2D
    var overlayBottomLeftCoordinate: CLLocationCoordinate2D
    var overlayBottomRightCoordinate: CLLocationCoordinate2D
    
//    let midPoint = CGPointFromString(properties!["midCoord"] as! String)
//    midCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(midPoint.x), CLLocationDegrees(midPoint.y))
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        <key>midCoord</key>
//        <string>{34.4248,-118.5971}</string>
//        <key>overlayTopLeftCoord</key>
//        <string>{34.4311,-118.6012}</string>
//        <key>overlayTopRightCoord</key>
//        <string>{34.4311,-118.5912}</string>
//        <key>overlayBottomLeftCoord</key>
//        <string>{34.4194,-118.6012}</string>
//        <key>boundary</key>
//        <array>
//        <string>{34.4313,-118.59890}</string>
//        <string>{34.4274,-118.60246}</string>
//        <string>{34.4268,-118.60181}</string>
//        <string>{34.4202,-118.6004}</string>
//        <string>{34.42013,-118.59239}</string>
//        <string>{34.42049,-118.59051}</string>
//        <string>{34.42305,-118.59276}</string>
//        <string>{34.42557,-118.59289}</string>
//        <string>{34.42739,-118.59171}</string>
//        </array>
        
        
        
        let api = CitySDKAPIClient()
        
        api.sendAPIRequest()
        
        
        mapView.frame = view.frame
        mapView.delegate = self
        view.addSubview(mapView)
        
        centerMapOnLocation(self.initialLocation)
        //getLocationFromZipcode("08540")
        
        
      
        
        
    }
    
    var overlayBoundingMapRect: MKMapRect {
        get {
            let topLeft = MKMapPointForCoordinate(overlayTopLeftCoordinate)
            let topRight = MKMapPointForCoordinate(overlayTopRightCoordinate)
            let bottomLeft = MKMapPointForCoordinate(overlayBottomLeftCoordinate)
            
            return MKMapRectMake(topLeft.x,
                                 topLeft.y,
                                 fabs(topLeft.x-topRight.x),
                                 fabs(topLeft.y - bottomLeft.y))
        }
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
