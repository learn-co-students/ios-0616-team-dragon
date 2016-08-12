//
//  MapKitViewController.swift
//  ProjectOvaltine
//
//  Created by Colin Walsh on 8/8/16.
//  Copyright © 2016 Christopher Webb-Orenstein. All rights reserved.
//
// This makes the

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
    
    //Calculates a location from array of location data - will be deprecated eventually
    var initialLocation : CLLocation {
        let newLocation = CLLocation.init(latitude: 40.28683599971092, longitude: -75.26431999998206)
        return newLocation}
    
    //Necessary to convert point data to CLLocationCoordinate2D array
    var homeBoundary: [CLLocationCoordinate2D] = []
    
    var destinationBoundary: [CLLocationCoordinate2D] = []
    
    var polyline : MKPolyline!
    
    var polylineArray : [MKPolyline] = []
    
    var canDraw : Bool = false
    
    //Init searchBar
    let searchController = UISearchBar.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawInMapView()
        
        self.searchBar()
        
        centerMapOnLocation(self.initialLocation)
    }
    
    //    func somefunc(){
    //        self!.polyline = MKPolyline(coordinates: &self!.boundary, count: self!.boundary.count)
    //        self!.polylineArray.append(self!.polyline)
    //
    //        if self!.polylineArray.count <= 1 {
    //            self!.mapView.addOverlay(self!.polylineArray[0])
    //            print(self!.polylineArray[0])
    //        } else {
    //            self!.mapView.removeOverlay(self!.polylineArray[0])
    //            self!.mapView.addOverlay(self!.polylineArray[1])
    //            print(self!.polylineArray)
    //        }}
    
    
    
    func drawInMapView(){
        mapView.frame = view.frame
        mapView.delegate = self
        
        getPlacemarkFromCoordinates(initialLocation)
        view.addSubview(mapView)
    }
    
    func populateCoordinateArrayForInitalLocation(completionHandler: (NSArray) -> ()){
        self.store.getCitySDKData({
            
            if let geo = self.store.cityDataPoints.first?.coordinates {
                completionHandler(geo)
            }
        })
    }
    
    func populateCoordinateArrayForDestinationLocation(completionHandler: (NSArray) -> ()){
        self.store.getCitySDKData({
            
            if let geo = self.store.cityDataPoints.first?.coordinates {
                completionHandler(geo)
            }
        })
    }
    
    func convertHomeArrayDataToPoints(array: [AnyObject]) {
        let longCoord = array[0] as! Double
        let latCoord = array[1] as! Double
        let point = CLLocationCoordinate2D(latitude: latCoord, longitude: longCoord)
        homeBoundary.append(point)
        
    }
    
    func convertDestinationArrayToPoints(array: [AnyObject]) {
        let longCoord = array[0] as! Double
        let latCoord = array[1] as! Double
        let point = CLLocationCoordinate2D(latitude: latCoord, longitude: longCoord)
        destinationBoundary.append(point)}
    
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
        self.getPlacemarkFromUserInformation(self.searchController.text!)
    }
    
    func getPlacemarkFromCoordinates(location: CLLocation) {
            //CLGeocoder().reverseGeocodeLocation(initialLocation, completionHandler: {[weak self] in })
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {[weak self] (placemarks,error) in
            var placemark : CLPlacemark!
            
            if ((error) != nil) {
                self!.alert.title = "Zip not found!"
                self!.alert.message = "You entered an invalid zip"
                self!.alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                self!.presentViewController(self!.alert, animated: true, completion: nil)
                print("\(error)")
            } else {
                placemark = (placemarks?.last)!
                print(self!.store.zip)
                self!.store.zip = placemark.postalCode!
                print(self!.store.zip)
                
                self!.populateCoordinateArrayForInitalLocation{(homeArray) in
                    
                    for i in 0...homeArray.count-1 {
                        
                        self!.convertHomeArrayDataToPoints(homeArray[i] as! [AnyObject])
                    }
                    
                }
                
                self!.zipLocation = placemark?.location
                self!.centerMapOnLocation(self!.zipLocation)
                
            }
        })
    }
    
    //Takes a string of numbers and gets a lat/long - Async
    func getPlacemarkFromUserInformation(userInput: String){
        
        var placemark: CLPlacemark!
    
        CLGeocoder().geocodeAddressString(userInput, completionHandler: {[weak self] (placemarks, error) in
            if ((error) != nil) {
                self!.alert.title = "Zip not found!"
                self!.alert.message = "You entered an invalid zip"
                self!.alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                self!.presentViewController(self!.alert, animated: true, completion: nil)
                print("\(error)")
            } else {
                placemark = (placemarks?.last)!
                print(self!.store.zip)
                self!.store.zip = placemark.postalCode!
                print(self!.store.zip)
                    
                
                    self!.populateCoordinateArrayForDestinationLocation{(destinationArray) in
                        
                        for i in 0...destinationArray.count-1 {
                            
                            self!.convertDestinationArrayToPoints(destinationArray[i] as! [AnyObject])
                        }
                }
                
                    self!.zipLocation = placemark?.location
                    self!.centerMapOnLocation(self!.zipLocation)
                    
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
