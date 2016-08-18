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
    
    var window: UIWindow?
    
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
    
    var polygon: MKPolygon!
    
    var anotation = MKPointAnnotation()
    
    //Init searchBar
    let searchController = UISearchBar.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawInMapView()
        self.searchBar()
        
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
    
    func zoomToPolygon(map: MKPolygon, animated: Bool) {
        let insets = UIEdgeInsets.init(top: 5.0, left: 50.0, bottom: 5.0, right: 50.0)
        self.mapView.setVisibleMapRect(self.polygon.boundingMapRect, edgePadding: insets, animated: true)
        //self.mapView.setVisibleMapRect(self.polygon.boundingMapRect, animated: true)
    }
    
    //Delegate method from mapView in order to render the polyline
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let polygonRenderer = MKPolygonRenderer(overlay: overlay)
        
        polygonRenderer.lineWidth = 1
        polygonRenderer.fillColor = UIColor.cyanColor()
        polygonRenderer.alpha = 0.50
        return polygonRenderer
    }
    
    //Following two functions from: http://stackoverflow.com/questions/33123724/swift-adding-a-button-to-my-mkpointannotation
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        let annotationReuseId = "Place"
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(annotationReuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: annotationReuseId)
        } else {
            anView!.annotation = annotation
        }
        
        anView?.rightCalloutAccessoryView = UIButton(type: UIButtonType.DetailDisclosure)
        anView!.backgroundColor = UIColor.clearColor()
        anView!.canShowCallout = true
        let testImage = UIImage(named: "annotation_test")
        
        let scaledImage = UIImage.init(CGImage: (testImage?.CGImage)!, scale: 7, orientation: UIImageOrientation.Up)
        
        anView!.image = scaledImage
        return anView
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //I don't know how to convert this if condition to swift 1.2 but you can remove it since you don't have any other button in the annotation view
        if (control as? UIButton)?.buttonType == UIButtonType.DetailDisclosure {
            
            let detailVC = TabBarController()
            self.showViewController(detailVC, sender: nil)
            self.searchController.text?.removeAll()
        }
    }
    
    
    func populateCoordinateArray(completionHandler: (NSArray) -> ()){
        
        self.store.getCitySDKData({
            
            if let geo = self.store.cityDataPoints.first?.coordinates {
                completionHandler(geo)
            }
        })
        print(self.store.scoreData)
    }
    
    func convertArrayDataToPoints(array: [AnyObject]) {
        
        let longCoord = array[0] as! Double
        let latCoord = array[1] as! Double
        let point = CLLocationCoordinate2D(latitude: latCoord, longitude: longCoord)
        boundary.append(point)
        
    }
    
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  self.regionRadius * 2.0,
                                                                  self.regionRadius * 2.0)
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.mapView.removeOverlays(overlayArray)
        self.overlayArray.removeAll()
        self.getLocationFromZipcode(self.searchController.text!)
        self.view.endEditing(true)
        
        
        
    }
    
    //Takes a string of numbers and gets a lat/long - Async
    func getLocationFromZipcode(zipcode: String){
        // self.store.zip = zipcode
        var placemark: CLPlacemark!
        CLGeocoder().geocodeAddressString(zipcode, completionHandler: {[weak self] (placemarks, error) in
            if ((error) != nil) {
                self!.alert.title = "Zip not found!"
                self!.alert.message = "You entered an invalid zip"
                self!.alert.addAction(UIAlertAction(title: "PLEASE ENTER VALID LOCATION", style: UIAlertActionStyle.Default, handler: nil))
                self!.presentViewController(self!.alert, animated: true, completion: nil)
                print("\(error)")
                
            } else {
                
                
                placemark = (placemarks?.last)!
                print(placemark.subAdministrativeArea)
                print(placemark.administrativeArea)
                print(placemark.locality)
                self!.store.zip = (placemark.postalCode)!
                
                self!.populateCoordinateArray{[weak self] (someArray) in
                    self!.boundary.removeAll()
                    
                    for i in 0...someArray.count-1 {
                        self!.convertArrayDataToPoints(someArray[i] as! [AnyObject])
                    }
                    
                    
                    self!.polygon = MKPolygon(coordinates: &self!.boundary, count: self!.boundary.count)
                    
                    self!.polygon.title = "county_borders"
                    
                    self!.overlayArray.append(self!.polygon)
                    
                    self!.mapView.addOverlays(self!.overlayArray)
                    
                    self!.zoomToPolygon(self!.polygon, animated: true)
                }
                
                
                self!.zipLocation = placemark?.location
                self!.mapView.removeAnnotation(self!.anotation)
                
                self!.anotation.coordinate = (placemark?.location?.coordinate)!
                self!.anotation.title = placemark?.locality
                self!.anotation.subtitle = "\(placemark!.subAdministrativeArea!) County"
                self!.mapView.addAnnotation(self!.anotation)
                self!.mapView.selectAnnotation(self!.anotation, animated: true)
                //                self!.centerMapOnLocation(self!.zipLocation)
                
                
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

