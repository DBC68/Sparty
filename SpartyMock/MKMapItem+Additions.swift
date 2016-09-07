//
//  MKMapItem+Additions.swift
//  PetAlert
//
//  Created by David Colvin on 6/20/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import MapKit

let formattedAddressLinesKey = "FormattedAddressLines"
let nameKey = "Name"

extension MKMapItem {

    func coordinateForMapItem() -> CLLocationCoordinate2D {
        let lat = self.placemark.location!.coordinate.latitude
        let lon = self.placemark.location!.coordinate.longitude
        return CLLocationCoordinate2DMake(lat, lon)
    }

    
    func titleForMapItem() -> String {
        return self.addressArray().first!
    }

    func titleForAddressArray(addr: [String]) -> String {
        return addr.first!
    }

    
    func subtitleForMapItem() -> String {
        var addr = self.addressArray()
        addr.removeAtIndex(0)
        return addr.joinWithSeparator(" ")
    }

    
    func subtitleForAddressArray(array: [String]) -> String {
        var addr = array
        addr.removeAtIndex(0)
        return addr.joinWithSeparator(" ")
    }

    func addressArray() -> [String] {
        let dict = self.placemark.addressDictionary as? [String:AnyObject]
        return dict![formattedAddressLinesKey] as! [String]
    }
    
    func isValidMapItem() -> Bool {
        return self.addressArray().count > 1
    }

    func addressStringForAddressArray(addressArray: [String]) -> String {
        return addressArray.joinWithSeparator(" ")
    }
}