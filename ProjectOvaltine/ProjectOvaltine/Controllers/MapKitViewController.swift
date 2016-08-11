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

class MapKitViewController: UIViewController, MKMapViewDelegate, UISearchControllerDelegate, UISearchBarDelegate {
    
    //Data store instances
    let store = DataStore.sharedInstance
    let cityAPI = CitySDKAPIClient.sharedInstance
    let jobsAPI = USAJobsAPIClient.sharedInstance
    
    //Array of citySDK data
    var cityData: [CitySDKData] = []
    
    //Initialized mapView
    let mapView: MKMapView! = MKMapView()
    
    //Set zipLocation (used in GeoCoder function), region radius
    var zipLocation : CLLocation! = nil
    let regionRadius: CLLocationDistance = 1000
    
    //Initialize alert - used in GeoCoder function when user enters an invalid zipcode
    let alert = UIAlertController(title: "Alert", message: "Message", preferredStyle: UIAlertControllerStyle.Alert)
    //Hardcoded array of coordinates to test drawing a bounding box
    let coordinates: [(Double, Double)] = [(34.4313,-118.59890),(34.4274,-118.60246), (34.4268,-118.60181), (34.4202,-118.6004), (34.42013,-118.59239), (34.42049,-118.59051), (34.42305,-118.59276), (34.42557,-118.59289), (34.42739,-118.59171), (34.4313,-118.59890)]
    
    //Calculates a location from array of location data - will be deprecated eventually
    var initialLocation : CLLocation {
        let newLocation = CLLocation.init(latitude: 40.28683599971092, longitude: -75.26431999998206)
        return newLocation}
    
    //Necessary to convert point data to CLLocationCoordinate2D array
    var boundary: [CLLocationCoordinate2D] = []
    
    //Init searchBar
    let searchController = UISearchBar.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.testPrint()
        self.drawInMapView()
        
        self.searchBar()
        
        
        
        self.populateCoordinateArray{(someArray) in
            
            for i in 0...someArray.count-1 {
                
                self.convertArrayDataToPoints(someArray[i] as! [AnyObject])
            }
            
            
            print(self.boundary)
            
        }
        
        self.centerMapOnLocation(self.initialLocation)
    }
    
    func drawInMapView(){
        mapView.frame = view.frame
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    func populateCoordinateArray(completionHandler: (NSArray) -> ()){
        
        self.store.getCitySDKData({
            
            if let geo = self.store.cityDataPoints.first?.coordinates {
                completionHandler(geo)
            }
        })
    }
    
    func testPrint(){
        self.store.getCitySDKData({
            if let geo = self.store.cityDataPoints.first?.coordinates {
                print(geo)}
            
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
    }
    
    func convertArrayDataToPoints(array: [AnyObject]) {
        
        let longCoord = array[0] as! Double
        let latCoord = array[1] as! Double
        
        let point = CLLocationCoordinate2D(latitude: latCoord, longitude: longCoord)
        boundary.append(point)
        
    }
    
    func drawPolylines(){
        let polyline = MKPolyline(coordinates: &boundary, count: boundary.count)
        mapView.addOverlay(polyline)
    }
    
    //Delegate method from mapView in order to render the polyline
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        polylineRenderer.strokeColor = UIColor.blueColor()
        polylineRenderer.lineWidth = 5
        return polylineRenderer
        
    }
    
    //Centers Map on a given coordinate
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  self.regionRadius * 2.0,
                                                                  self.regionRadius * 2.0)
        

        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.getLocationFromZipcode(self.searchController.text!)
        self.drawPolylines()
    }
    
//    func getLocationFromSearchField(userSearch: String) {
//        var placemark: CLPlacemark!
//        CLGeocoder().geocodeAddressString(userSearch, completionHandler: {(placemarks, error) in })}
    
    //Takes a string of numbers and gets a lat/long - Async
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
            
                //print(placemarks)
               self.zipLocation = placemark?.location
            self.centerMapOnLocation(self.zipLocation)
            }
        })
    }
    
    func searchBar() {
        self.searchController.placeholder = "Enter Location"
        self.searchController.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 66)
        let topConstraint = NSLayoutConstraint(item: searchController, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        self.searchController.delegate = self
        self.view.addSubview(self.searchController)
        self.view.addConstraint(topConstraint)
        
    }
}
