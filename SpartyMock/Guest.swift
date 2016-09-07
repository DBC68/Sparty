//
//  Guest.swift
//  SpartyMock
//
//  Created by David Colvin on 8/13/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

enum RSVP: Int {
    case Unknown
    case Yes
    case No
    case Maybe
    
}

class Guest: NSObject {
    
    var spartyId:String!
    var friendId:String!
    var rsvp:RSVP = .Unknown
    var isCheckedIn = false
    
    init(dict:[String:AnyObject]) {
        
        guard let spartyId = dict["spartyId"] as? String,
            guestId = dict["guestId"] as? String,
            isCheckedIn = dict["isCheckedIn"] as? Bool,
            value = dict["rsvp"] as? Int else {
                abort()
        }
        
        self.spartyId = spartyId
        self.friendId = guestId
        self.isCheckedIn = isCheckedIn
        self.rsvp = RSVP(rawValue: value)!
    }
    
    //Returns index of self in array
    func index(array:[Guest]) -> Int? {
        var index:Int?
        for (i, object) in array.enumerate() {
            if object.isEqual(self) {
                index = i
                break
            }
        }
        return index
    }
    
    //Equatable
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? Guest else { return false }
        let lhs = self
        return lhs.friendId == rhs.friendId
    }
    
    //Exists
    func existsInArray(array:[Guest]) -> Bool {
        return self.index(array) != nil
    }

}
