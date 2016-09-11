//
//  AppState.swift
//  Sparty
//
//  Created by David Colvin on 9/11/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation

class AppState: NSObject {
    
    private struct Key {
        static let SignedIn = "signedIn"
        static let HasRegistered = "hasRegistered"
        static let Units = "units"
        static let PhotoURL = "photoUrl"
        static let DisplayName = "displayName"
        static let Email = "email"
    }
    
    
    //MARK:  - Properties
    //--------------------------------------------------------------------------
    
    static let sharedInstance = AppState()
    
    var isRegistered = false
    var displayName: String?
    var photoUrl: NSURL?
    var units:Units = .Imperial
    
    func save() {
    }
    
    func load() {
        
    }
    
    func clear() {
        
    }
}