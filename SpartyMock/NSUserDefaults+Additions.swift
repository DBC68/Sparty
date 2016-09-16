//
//  NSUserDefaults+Additions.swift
//  Sparty
//
//  Created by David Colvin on 9/16/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation

struct Keys {
    static let IsRegistered = "IsRegistered"
}

extension NSUserDefaults {
    
    class func registerSpartyDefaults() {
        let defaults = [Keys.IsRegistered: false]
        standardUserDefaults().registerDefaults(defaults)
    }
    
    //Is Registered
    class func setIsRegistered(value: Bool) {
        standardUserDefaults().setBool(value, forKey: Keys.IsRegistered)
    }
    
    class func isRegistered() -> Bool {
        return standardUserDefaults().boolForKey(Keys.IsRegistered)
    }
}