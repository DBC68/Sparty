//
//  Locator.swift
//  PetAlert
//
//  Created by David Colvin on 7/24/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import CoreLocation



class Locator: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance: Locator = Locator()
    
    typealias Callback = (Result <Locator>) -> Void
    
    var requests: Array <Callback> = Array <Callback>()
    
    var location: CLLocation? { return sharedLocationManager.location  }
    
    lazy var sharedLocationManager: CLLocationManager = {
        let newLocationmanager = CLLocationManager()
        newLocationmanager.delegate = self
        // ...
        return newLocationmanager
    }()
    
    // MARK: - Authorization
    //--------------------------------------------------------------------------
    class func authorize() { sharedInstance.authorize() }
    func authorize() { sharedLocationManager.requestWhenInUseAuthorization() }
    
    // MARK: - Helpers
    //--------------------------------------------------------------------------
    func locate(callback: Callback) {
        self.requests.append(callback)
        sharedLocationManager.startUpdatingLocation()
    }
    
    func reset() {
        self.requests = Array <Callback>()
        sharedLocationManager.stopUpdatingLocation()
    }
    
    // MARK: - Delegate
    //--------------------------------------------------------------------------
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        for request in self.requests { request(.Failure(error)) }
        self.reset()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: Array <CLLocation>) {
        for request in self.requests { request(.Success(self)) }
        self.reset()
    }
    
}
