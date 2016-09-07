//
//  CLLocationCoordinate2D+Additions.swift
//  PetAlert
//
//  Created by David Colvin on 6/26/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation


extension CLLocationCoordinate2D {
    
    func distanceInMetersFrom(otherCoord : CLLocationCoordinate2D) -> CLLocationDistance {
        let firstLoc = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let secondLoc = CLLocation(latitude: otherCoord.latitude, longitude: otherCoord.longitude)
        return firstLoc.distanceFromLocation(secondLoc)
    }
    
    func isNotEmpty() -> Bool {
        return !self.isEmpty()
    }
    
    func isEmpty() -> Bool {
        return self.latitude == 0.0 || self.longitude == 0.0
    }
    
    func isEqual(coordinate:CLLocationCoordinate2D) -> Bool {
        
        let multipler = 1000.0
        
        let lat1 = Int(self.latitude * multipler)
        let lon1 = Int(self.longitude * multipler)
        
        let lat2 = Int(coordinate.latitude * multipler)
        let lon2 = Int(coordinate.longitude * multipler)
        
        print("Coord: \(lat1), \(lon1) Prev: \(lat2) \(lon2)")
        
        return (lat1 == lat2) && (lon1 == lon2)
    }
    
    func coordinateString() -> String {
        
        let latitude = self.latitude
        let longitude = self.longitude
        
        var latSeconds = Int(latitude * 3600)
        let latDegrees = latSeconds / 3600
        latSeconds = abs(latSeconds % 3600)
        let latMinutes = latSeconds / 60
        latSeconds %= 60
        var longSeconds = Int(longitude * 3600)
        let longDegrees = longSeconds / 3600
        longSeconds = abs(longSeconds % 3600)
        let longMinutes = longSeconds / 60
        longSeconds %= 60
        return String(format:"(%d°%d'%d\"%@, %d°%d'%d\"%@)",
                      abs(latDegrees),
                      latMinutes,
                      latSeconds,
                      {return latDegrees >= 0 ? "N" : "S"}(),
                      abs(longDegrees),
                      longMinutes,
                      longSeconds,
                      {return longDegrees >= 0 ? "E" : "W"}() )
    }
}