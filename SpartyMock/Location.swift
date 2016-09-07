//
//  Location.swift
//  DynamicTableView
//
//  Created by David Colvin on 6/12/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import MapKit

class Location: NSObject {
    
    
    var street: String = ""
    var city: String = ""
    var state: String = ""
    var zip: String = ""
    var country: String = ""
    
    var title:String? {
        
        if street.trim().characters.count > 0 {
            return street
        }
        else {
            return city + ", " + state + "  " + zip
        }
    }
    
    var subtitle:String? {
        if street.trim().characters.count > 0 {
            return city + ", " + state + "  " + zip
        }
        else {
            return nil
        }
    }
    
    var address:String? {
        
        if let title = self.title,
            subtitle = self.subtitle {
        
            return title + "\n" + subtitle
        }
        else {
            return coordinate.coordinateString()
        }
    }
    
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    
    
    convenience init(coordinate: CLLocationCoordinate2D?, placemark: CLPlacemark? = nil) {
        
        self.init()
        
        self.coordinate = coordinate!
        
        if let pm = placemark {
        
            let thoroughfare = pm.thoroughfare ?? ""
            let subThoroughfare = pm.subThoroughfare ?? ""
            self.street = subThoroughfare + " " + thoroughfare
        
            self.city = pm.locality ?? ""
            self.zip = pm.postalCode ?? ""
            self.state = pm.administrativeArea ?? ""
        }
    }
    
    convenience init(mapItem: MKMapItem?) {
        self.init(coordinate: mapItem!.coordinateForMapItem(), placemark: mapItem!.placemark)
    }
    
    convenience init(dict: [String:AnyObject]) {
        self.init()
        self.street = dict["street"] as! String
        self.city = dict["city"] as! String
        self.state = dict["state"] as! String
        self.zip = dict["zip"] as! String
        self.country = dict["country"] as! String
        self.coordinate = CLLocationCoordinate2DMake(dict["latitude"] as! Double, dict["longitude"] as! Double)
    }
    
    func sameAs(location:Location) -> Bool {
        return (self.title == location.title && self.subtitle == location.subtitle)
    }
}