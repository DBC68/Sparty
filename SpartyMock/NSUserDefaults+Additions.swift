//
//  NSUserDefaults+Additions.swift
//  PetAlert
//
//  Created by David Colvin on 5/22/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

//import MapKit

//private struct Key {
//    static let Latitude = "Latitude"
//    static let Longitude = "Longitude"
//    static let MapType = "MapType"
//    static let DistanceIdentifier = "DistanceIdentifier"
//    static let MapItem = "MapItem"
//    static let LatitudeDelta = "LatitudeDelta"
//    static let LongitudeDelta = "LongitudeDelta"
//    static let Units = "Units"
//    static let DisplayName = "DisplayName"
//    static let Email = "Email"
//    static let DisplayPassword = "DisplayPassword"
//    static let CurrentLocation = "CurrentLocation"
//    static let ViewMode = "ViewMode"
//}

import Foundation

extension NSUserDefaults {
    
//    class func email() -> String? {
//        return loadStringForKey(Key.Email)
//    }
//    
//    class func setEmail(email: String) {
//        saveString(email, forKey: Key.Email)
//    }
//    
//    class func displayName() -> String? {
//        return loadStringForKey(Key.DisplayName)
//    }
//    
//    class func setDisplayName(displayName: String) {
//        saveString(displayName, forKey: Key.DisplayName)
//    }
//    
//    class func mapType() -> MKMapType {
//        
//        if let type = loadIntegerForKey(Key.MapType) {
//            return MKMapType(rawValue: UInt(type))!
//        }
//        else {return .Standard}
//        
//    }
//    
//    class func setMapType(mapType: MKMapType) {
//        saveInteger(Int(mapType.rawValue), forKey: Key.MapType)
//    }
//    
//    class func longitudeDelta() -> Double? {
//        return loadDoubleForKey(Key.LongitudeDelta)
//    }
//    
//    class func setLongitudeDelta(longitudeDelta: Double) {
//        saveDouble(longitudeDelta, forKey: Key.LongitudeDelta)
//    }
//    
//    class func latitudeDelta() -> Double? {
//        return loadDoubleForKey(Key.LatitudeDelta)
//    }
//    
//    class func setLatitudeDelta(latitudeDelta: Double) {
//        saveDouble(latitudeDelta, forKey: Key.LatitudeDelta)
//    }
//    
//    class func units() -> Units? {
//        guard let units = loadIntegerForKey(Key.Units) else {return nil}
//        return Units(rawValue:units)
//    }
//    
//    class func setUnits(units: Units) {
//        saveInteger(units.rawValue, forKey: Key.Units)
//    }
    
    
//    class func defaultCoordinates() -> CLLocationCoordinate2D? {
//        guard let latitude = loadDoubleForKey(Key.Latitude) else {return nil}
//        guard let longitude = loadDoubleForKey(Key.Longitude) else {return nil}
//        return CLLocationCoordinate2DMake(latitude, longitude)
//    }
//    
//    class func setDefaultCoordinates(coordinates: CLLocationCoordinate2D) {
//        saveDouble(coordinates.latitude, forKey: Key.Latitude)
//        saveDouble(coordinates.longitude, forKey: Key.Longitude)
//    }
    
//    class func viewMode() -> ViewMode? {
//        guard let viewMode = loadIntegerForKey(Key.ViewMode) else {return .Map}
//        return ViewMode(rawValue:viewMode)
//    }
//    
//    class func setViewMode(viewMode: ViewMode) {
//        saveInteger(viewMode.rawValue, forKey: Key.ViewMode)
//    }
    
    
    //MARK: Shared
    //--------------------------------------------------------------------------
    class func saveString(string: String, forKey key: String) {
        if string.isEmpty {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        } else {
            NSUserDefaults.standardUserDefaults().setObject(string, forKey: key)
        }
    }
    
    class func loadStringForKey(key: String) -> String? {
        return NSUserDefaults.standardUserDefaults().stringForKey(key)
    }
    
    class func saveInteger(integer: Int, forKey key: String) {
        NSUserDefaults.standardUserDefaults().setInteger(integer, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func loadIntegerForKey(key: String) -> Int? {
        return NSUserDefaults.standardUserDefaults().integerForKey(key)
    }
    
    class func saveDouble(number: Double, forKey key: String) {
        NSUserDefaults.standardUserDefaults().setDouble(number, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func loadDoubleForKey(key: String) -> Double? {
        return NSUserDefaults.standardUserDefaults().doubleForKey(key)
    }
    
    class func saveBool(value: Bool, forKey key: String) {
        NSUserDefaults.standardUserDefaults().setBool(value, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func loadBoolForKey(key: String) -> Bool? {
        return NSUserDefaults.standardUserDefaults().boolForKey(key)
    }
}