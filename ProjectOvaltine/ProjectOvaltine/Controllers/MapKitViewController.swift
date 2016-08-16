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
import SwiftSpinner

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
    var boundary: [CLLocationCoordinate2D] = []
    
    //Initialized array of MKOverlays
    var overlayArray: [MKOverlay] = []
    
    //Init searchBar
    let searchController = UISearchBar.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.testPrint()
        self.drawInMapView()
        self.searchBar()
        
        //self.initHeaderBanner()
        centerMapOnLocation(self.initialLocation)
    }
    
    override func viewDidAppear(animated: Bool) {
        SwiftSpinner.showWithDuration(0.9, title: "TEAM DRAGON")
        SwiftSpinner.setTitleFont(UIFont(name: "Futura", size: 33.0))
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
    
    func convertArrayDataToPoints(array: [AnyObject]) {
        
        let longCoord = array[0] as! Double
        let latCoord = array[1] as! Double
        let point = CLLocationCoordinate2D(latitude: latCoord, longitude: longCoord)
        boundary.append(point)
        
    }
    
    //Delegate method from mapView in order to render the polyline
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let polygonRenderer = MKPolygonRenderer(overlay: overlay)
        polygonRenderer.lineWidth = 3
        polygonRenderer.fillColor = UIColor.greenColor()
        polygonRenderer.alpha = 0.15
        
        //        let polylineRenderer = MKPolylineRenderer(overlay: overlay)
        //        polylineRenderer.strokeColor = UIColor.greenColor()
        //        polylineRenderer.lineWidth = 5
        return polygonRenderer}
    
    //Centers Map on a given coordinate
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  self.regionRadius * 2.0,
                                                                  self.regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        mapView.removeOverlays(overlayArray)
        self.overlayArray.removeAll()
        self.getLocationFromZipcode(self.searchController.text!)
        
                let time = dispatch_time(dispatch_time_t(DISPATCH_TIME_NOW), 5 * Int64(NSEC_PER_SEC))
                dispatch_after(time, dispatch_get_main_queue()) {
        
                    let detailVC = TabBarController()
                    self.showViewController(detailVC, sender: nil)
                    self.searchController.text?.removeAll()
                }
    }
    
    //    func getLocationFromSearchField(userSearch: String) {
    //        var placemark: CLPlacemark!
    //        CLGeocoder().geocodeAddressString(userSearch, completionHandler: {(placemarks, error) in })}
    
    //Takes a string of numbers and gets a lat/long - Async
    func getLocationFromZipcode(zipcode: String){
        self.store.zip = zipcode
        var placemark: CLPlacemark!
        CLGeocoder().geocodeAddressString(zipcode, completionHandler: {[weak self] (placemarks, error) in
            if ((error) != nil) {
                self!.alert.title = "Zip not found!"
                self!.alert.message = "You entered an invalid zip"
                self!.alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
                self!.presentViewController(self!.alert, animated: true, completion: nil)
                print("\(error)")
            } else {
                placemark = (placemarks?.last)!
                print(placemark)
                
                
                self!.populateCoordinateArray{[weak self] (someArray) in
                    self!.boundary.removeAll()
                    
                    for i in 0...someArray.count-1 {
                        
                        self!.convertArrayDataToPoints(someArray[i] as! [AnyObject])
                    }
                    
                    let polygon = MKPolygon(coordinates: &self!.boundary, count: self!.boundary.count)
                    
                    self!.overlayArray.append(polygon)
                    self!.mapView.addOverlays(self!.overlayArray)
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
    
    //    func initHeaderBanner() {
    //        let projectName = UIButton(frame: CGRectMake(20, 630, self.view.frame.width-40, 40))
    //        projectName.backgroundColor=UIColor.lightGrayColor()
    //        projectName.setTitle("PROJECT OVALTINE", forState: .Normal)
    //        projectName.setTitleColor(UIColor.blackColor(), forState: .Normal)
    //        projectName.alpha = 0.3
    //        projectName.layer.zPosition = 3
    //        projectName.layer.borderWidth = 0.3
    //        projectName.layer.cornerRadius = 2
    //        self.view.addSubview(projectName)
    //    }
}

