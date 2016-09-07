//
//  Person.swift
//  SpartyMock
//
//  Created by David Colvin on 8/13/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import UIKit

class User: NSObject {
    
    var userId: String!
    var firstName:String!
    var lastName:String!
    var screenName:String!
    var email:String!
    var photo:UIImage?
    var motto:String?
    var score:Double!
 
    
    var fullName: String {
        return "\(self.firstName) \(self.lastName)"
    }
    
    var credits: Int {
        return Int(Double(score) * Constants.creditPercent)
    }
    
    var pointsString: String {
        return "\(Int(self.score)) points"
    }
    
    var creditsString: String {
        return "\(Int(self.credits)) credits"
    }
    
    var rank: Double {

        let users = DataStore.sharedInstance.users.sort({$0.score < $1.score})
        let rank = users.indexOf(self)! + 1
        return 100.0 - (Double(rank) / Double(users.count)) * 100.0
    }
    
    var rankString: String {
        
        return String(format: "%0.1f %", self.rank)
    }
    
    init(dict:[String:AnyObject]) {
        
        guard let userId = dict["userId"] as? String,
            firstName = dict["first"] as? String,
            lastName = dict["last"] as? String,
            screenName = dict["screenName"] as? String,
            email = dict["email"] as? String,
            motto = dict["motto"] as? String,
            photoName = dict["photoName"] as? String,
            score = dict["score"] as? Double else { abort() }
        
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.screenName = screenName
        self.email = email
        self.motto = motto
        self.photo = UIImage(named: photoName)
        self.score = score
    }
    
    //Returns index of self in person array
    func index(array:[User]) -> Int? {
        var index:Int?
        for (i, user) in array.enumerate() {
            if user.isEqual(self) {
                index = i
                break
            }
        }
        return index
    }
    
    //Equatable
    override func isEqual(object: AnyObject?) -> Bool {
        guard let rhs = object as? User else { return false }
        let lhs = self
        return lhs.userId == rhs.userId
    }
    
    //Exists
    func existsInArray(array:[User]) -> Bool {
        return self.index(array) != nil
    }

}