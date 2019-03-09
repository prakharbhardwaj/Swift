//
//  ViewController.swift
//  CoreLocation
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var myMap: MKMapView!
    @objc let locationManager: CLLocationManager = CLLocationManager()
    var myLatitude: CLLocationDegrees!
    var myLongitude: CLLocationDegrees!
    var finalLatitude: CLLocationDegrees!
    var finalLongitude: CLLocationDegrees!
    var distance: CLLocationDistance!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.action(_:)))
        
        myMap.addGestureRecognizer(tap)
    }
    
    @objc func action(_ gestureRecognizer:UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: self.myMap)
        let newCoord:CLLocationCoordinate2D = myMap.convert(touchPoint, toCoordinateFrom: self.myMap)
        let getLat: CLLocationDegrees = newCoord.latitude
        let getLon: CLLocationDegrees = newCoord.longitude
        
        //Convert to points to CLLocation. In this way we can measure distanceFromLocation
        let newCoord2: CLLocation = CLLocation(latitude: getLat, longitude: getLon)
        let newCoord3: CLLocation = CLLocation(latitude: myLatitude, longitude: myLongitude)
        
        finalLatitude = newCoord2.coordinate.latitude
        finalLongitude = newCoord2.coordinate.longitude
        print("Original Latitude: \(myLatitude)")
        print("Original Longitude: \(myLongitude)")
        print("Final Latitude: \(finalLatitude)")
        print("Final Longitude: \(finalLongitude)")
        
        //distance between our position and the new point created
        let distance = newCoord2.distance(from: newCoord3)
        print("Distance between two points: \(distance)")
        
        let newAnnotation = MKPointAnnotation()
        newAnnotation.coordinate = newCoord
        newAnnotation.title = "My target"
        newAnnotation.subtitle = ""
        myMap.addAnnotation(newAnnotation)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                print("Reverse geocoder failed with error" + error!.localizedDescription)
                return
            }
            
            if placemarks!.count > 0 {
                let pm = placemarks![0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    @objc func displayLocationInfo(_ placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            //stop updating location to save battery life
            locationManager.stopUpdatingLocation()
            
            //get data from placemark
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            myLongitude = (containsPlacemark.location!.coordinate.longitude)
            myLatitude = (containsPlacemark.location!.coordinate.latitude)
            
            // testing show data
            print("The current value of friendlyWelcome is \(locality as String!)")
            print("Locality: \(locality as String!)")
            print("PostalCode: \(postalCode as String!)")
            print("Area: \(administrativeArea as String!)")
            print("Country: \(country as String!)")
            print(myLatitude)
            print(myLongitude)
            
            //update map with my location
            let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(0.1 , 0.1)
            let location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: myLatitude, longitude: myLongitude)
            let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(location, theSpan)
            
            myMap.setRegion(theRegion, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    //distance between two points
    @objc func degreesToRadians(_ degrees: Double) -> Double { return degrees * .pi / 180.0 }
    @objc func radiansToDegrees(_ radians: Double) -> Double { return radians * 180.0 / .pi }
    
    @objc func getBearingBetweenTwoPoints1(_ point1 : CLLocation, point2 : CLLocation) -> Double {
        let lat1 = degreesToRadians(point1.coordinate.latitude)
        let lon1 = degreesToRadians(point1.coordinate.longitude)
        let lat2 = degreesToRadians(point2.coordinate.latitude);
        let lon2 = degreesToRadians(point2.coordinate.longitude);
        
        print("Start latitude: \(point1.coordinate.latitude)")
        print("Start longitude: \(point1.coordinate.longitude)")
        print("Final latitude: \(point2.coordinate.latitude)")
        print("Final longitude: \(point2.coordinate.longitude)")
        
        let dLon = lon2 - lon1;
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        let radiansBearing = atan2(y, x);
        
        return radiansToDegrees(radiansBearing)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
