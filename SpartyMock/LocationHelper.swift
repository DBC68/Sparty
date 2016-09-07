//
//  LocationHelper.swift
//  PetAlert
//
//  Created by David Colvin on 6/28/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import CoreLocation

class LocationHelper: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = LocationHelper()
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    override init() {
        super.init()
        
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
    }
    
    func requestAuthorization() {
        self.locationManager.requestAlwaysAuthorization()
    }
    
    func startUpdating() {
            locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
    {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.currentLocation = locations.last!
    }
}