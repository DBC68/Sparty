//
//  Activity.swift
//  SpartyMock
//
//  Created by David Colvin on 8/13/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class Activity: NSObject {
    
    //MARK: - Properties
    //--------------------------------------------------------------------------
    var userId: String? //User
    var spartyId: String?
    var date: NSDate!
    var actionId: Action.ID!
    
    var user: User? {
        guard let userId = self.userId else { return nil }
        return DataStore.sharedInstance.userForUserId(userId)
    }
    
    var action: Action! {
        return DataStore.sharedInstance.actionForActionId(self.actionId)!
    }
    
    var sparty: Sparty? {
        guard let spartyId = self.spartyId else { return nil }
        return DataStore.sharedInstance.spartyForSpartyId(spartyId)
    }
    
    //MARK: - Initializers
    //--------------------------------------------------------------------------
    init(dict:[String:AnyObject]) {
        
        guard let userId = dict["userId"] as? String,
            spartyId = dict["spartyId"] as? String,
            date = dict["date"] as? NSDate,
            value = dict["actionId"] as? Int else {
                abort()
        }
        
        self.userId = userId
        self.date = date
        self.actionId = Action.ID(rawValue: value)
        self.spartyId = spartyId

    }
    
    //MARK: - Functions
    //--------------------------------------------------------------------------
    func activityText() -> String {
        

            let message = self.action?.actionString.stringByReplacingOccurrencesOfString("[USER]", withString: self.user?.fullName ?? "")
            return message!.stringByReplacingOccurrencesOfString("[SPARTY]", withString: self.sparty?.title ?? "")
    }
    
    func pointsText () -> String {
        
        switch action.calculation! {
        case .Points:
            return String(Int(action.value)) + " points"
        case .Percent:
            return String(Int((user?.score)! * action.value)) + " points"
        case .None:
            return ""
        }
        
        
    }
    
    func photo () -> UIImage? {
        if let spartyPhoto = self.sparty?.photo {
            return spartyPhoto
        } else {
            if let userPhoto = self.user?.photo {
                return userPhoto
            }
        }
        return nil
    }
    
    
    //Returns index of self in array
    func index(array:[Activity]) -> Int? {
        var index:Int?
        for (i, activity) in array.enumerate() {
            if activity.isEqual(self) {
                index = i
                break
            }
        }
        return index
    }
    
    //Equatable
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? Activity else { return false }
        let lhs = self
        return lhs.date.isEqualToDate(rhs.date)
    }
    
    //Exists
    func existsInArray(array:[Activity]) -> Bool {
        return self.index(array) != nil
    }

}
