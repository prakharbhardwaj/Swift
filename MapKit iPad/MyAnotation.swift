//
//  MyAnotation.swift
//  MapKit iPad
//
//  Created by Ada Lovelace Code on 01/01/2018.
//  Copyright © 2018 Ada Lovelace Code. All rights reserved.
//

import UIKit
import MapKit

class MyAnotation: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    func getTitle() -> NSString{
        return self.title! as NSString
    }
    func getSubTitle() -> NSString {
        return self.subtitle! as NSString
    }
    init(c:CLLocationCoordinate2D, t:String, st: String){
        coordinate = c
        title = t
        subtitle = st
    }
}
