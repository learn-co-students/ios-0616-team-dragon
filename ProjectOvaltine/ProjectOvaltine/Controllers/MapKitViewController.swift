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
    
    let store = DataStore.sharedInstance
    let cityAPI = CitySDKAPIClient.sharedInstance
<<<<<<< HEAD
    //let jobsAPI = USAJobsAPIClient.sharedInstance
=======
    let jobsAPI = USAJobsAPIClient.sharedInstance
    let censusAPI = CensusAPIClient.sharedInstance
>>>>>>> 8331811d27ad8f90b328a34cb4827dc253948831
    
    
    var cityData: [CitySDKData] = []
    
    let mapView: MKMapView! = MKMapView()
    
    var zipLocation : CLLocation! = nil
    let regionRadius: CLLocationDistance = 1000
    let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
<<<<<<< HEAD
    let coordinates: [(Double, Double)] = [(34.4313,-118.59890),(34.4274,-118.60246), (34.4268,-118.60181), (34.4202,-118.6004), (34.42013,-118.59239), (34.42049,-118.59051), (34.42305,-118.59276), (34.42557,-118.59289), (34.42739,-118.59171), (34.4313,-118.59890)]
    var initialLocation : CLLocation {
        let newLocation = CLLocation.init(latitude: coordinates[0].0, longitude: coordinates[0].1)
        return newLocation}
    
    
    var midCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: 34.4248, longitude: -118.5971)
    var overlayTopLeftCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: 34.4311, longitude: -118.6012)
    var overlayTopRightCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: 34.4311, longitude: -118.5912)
    var overlayBottomLeftCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: 34.4194, longitude: -118.6012)
    
    var overlayBottomRightCoordinate: CLLocationCoordinate2D {
        get {
            return CLLocationCoordinate2DMake(self.overlayBottomLeftCoordinate.latitude,
                                              self.overlayTopRightCoordinate.longitude)
        }
    }
    
    var circle: MKCircle!
=======
    let coordinates = [["34.4313","-118.59890"],["34.4274","-118.60246"], ["34.4268","-118.60181"], ["34.4202","-118.6004"], ["34.42013","-118.59239"], ["34.42049","-118.59051"], ["34.42305","-118.59276"], ["34.42557","-118.59289"], ["34.42739","-118.59171"]]
    
//    var midCoordinate: CLLocationCoordinate2D
//    var overlayTopLeftCoordinate: CLLocationCoordinate2D
//    var overlayTopRightCoordinate: CLLocationCoordinate2D
//    var overlayBottomLeftCoordinate: CLLocationCoordinate2D
//    var overlayBottomRightCoordinate: CLLocationCoordinate2D
    
//    let midPoint = CGPointFromString(properties!["midCoord"] as! String)
//    midCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(midPoint.x), CLLocationDegrees(midPoint.y))
   
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    

    override func viewDidLoad() {
        super.viewDidLoad()
        //cityAPI.getAPIReques
        //self.store.getCitySDKData({
    
>>>>>>> 8331811d27ad8f90b328a34cb4827dc253948831
    
    var overlayBoundingMapRect: MKMapRect {
        get {
            let topLeft = MKMapPointForCoordinate(self.overlayTopLeftCoordinate)
            let topRight = MKMapPointForCoordinate(self.overlayTopRightCoordinate)
            let bottomLeft = MKMapPointForCoordinate(self.overlayBottomLeftCoordinate)
            
            return MKMapRectMake(topLeft.x,
                                 topLeft.y,
                                 fabs(topLeft.x-topRight.x),
                                 fabs(topLeft.y - bottomLeft.y))
        }
    }
    
<<<<<<< HEAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.store.getCitySDKData({
            
            if let age = self.store.cityDataPoints.first?.age {
                print(age)
            }
            
            if let name = self.store.cityDataPoints.first?.locationName {
                print(name)
            }
            
            if let commute = self.store.cityDataPoints.first?.walkingCommuteTime {
                print(commute)
            }
            
            if let income = self.store.cityDataPoints.first?.incomePerCapita {
                print(income)
            }
            
            if let education = self.store.cityDataPoints.first?.highSchoolEducation {
                print(education)
            }
            
        })
=======
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
 //       censusAPI.sendAPIRequest()
        
        self.store.sendCityAPITest()
        
//        jobsAPI.sendAPIRequest()
//        
//        self.store.getCitySDKData({
//            if let age = self.store.cityDataPoints.first?.age {
//                print(age)
//            }
//            
//            if let name = self.store.cityDataPoints.first?.locationName {
//                print(name)
//            }
//            
//            if let commute = self.store.cityDataPoints.first?.walkingCommuteTime {
//                print(commute)
//            }
//            
//            if let income = self.store.cityDataPoints.first?.incomePerCapita {
//                print(income)
//            }
//            
//            if let education = self.store.cityDataPoints.first?.highSchoolEducation {
//                print(education)
//            }
//            
//        })
>>>>>>> 8331811d27ad8f90b328a34cb4827dc253948831
        
        var boundary: [CLLocationCoordinate2D] = []
        
        
        for i in 0...coordinates.count-1 {
            
            let point = CLLocationCoordinate2D(latitude: coordinates[i].0, longitude: coordinates[i].1)
            boundary.append(point)
            
        }
        
        mapView.frame = view.frame
        mapView.delegate = self
        view.addSubview(mapView)
        

        
        let polyline = MKPolyline(coordinates: &boundary, count: boundary.count)
        mapView.addOverlay(polyline)
        
        centerMapOnLocation(self.initialLocation)
        
        
        
        // loadOverlayForRegionWithLatitude(initialLocation.coordinate.latitude, andLongitude: initialLocation.coordinate.longitude)
        
        
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
            let polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 5
            return polylineRenderer
        
    }
    //
    //    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
    //
    //        let circleRenderer = MKCircleRenderer(overlay: overlay)
    //        circleRenderer.fillColor = UIColor.blueColor().colorWithAlphaComponent(0.1)
    //        circleRenderer.strokeColor = UIColor.blueColor()
    //        circleRenderer.lineWidth = 1
    //        return circleRenderer
    //
    //
    //    }
    
    
    
    
    func loadOverlayForRegionWithLatitude(latitude: Double, andLongitude longitude: Double) {
        
        //1
        let coordinatesInMethod = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        //2
        self.circle = MKCircle(centerCoordinate: coordinatesInMethod, radius: 200000)
        //3
        self.mapView.setRegion(MKCoordinateRegion(center: coordinatesInMethod, span: MKCoordinateSpan(latitudeDelta: 7, longitudeDelta: 7)), animated: true)
        //4
        self.mapView.addOverlay(self.circle)
    }
    
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
