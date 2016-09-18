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
    
    struct FBKey {
        static let DisplayName = "displayName"
        static let Motto = "motto"
        static let PhotoString = "photoString"
        static let Score = "score"

    }
    
    //MARK: - Properties
    //--------------------------------------------------------------------------
    var uid: String!
    var firstName:String!
    var lastName:String!
    var displayName:String!
    var email:String!
    var photo:UIImage?
    var motto:String?
    var score:Int = 0
    
    var photoString: String? {
        if let image = self.photo {
            let resized = image.resize(200.0)
            if let imageData = UIImagePNGRepresentation(resized) {
                return imageData.base64EncodedStringWithOptions([])
            }
        }
        return nil
    }
    
    //MARK: - Initializer
    //--------------------------------------------------------------------------
    override init() {}
    
    init?(dict:[String:AnyObject]) {
        
        guard let
//            uid = dict["uid"] as? String,
//            firstName = dict["first"] as? String,
//            lastName = dict["last"] as? String,
            displayName = dict[FBKey.DisplayName] as? String,
//            email = dict["email"] as? String,
            motto = dict[FBKey.Motto] as? String,
            photoString = dict[FBKey.PhotoString] as? String,
            score = dict[FBKey.Score] as? Int
            else {
        
                print("Could not parse user object")
                assertionFailure()
                return
        }
        
//        self.uid = uid
//        self.firstName = firstName
//        self.lastName = lastName
        self.displayName = displayName
//        self.email = email
        self.motto = motto
        self.score = score
        
        if let image = UIImage.stringToImage(photoString) {
            self.photo = image
        }
    }
    
    func dict() -> [String:AnyObject] {
        
        var dict = [String:AnyObject]()
        
        dict[FBKey.DisplayName] = self.displayName
        
        if let motto = self.motto {
            dict[FBKey.Motto] = motto
        }
        
        if let image = self.photo {
            let resized = image.resize(200.0)
            if let str = UIImage.imageToString(resized) {
                dict[FBKey.PhotoString] = str
            }
        }
        
        dict[FBKey.Score] = self.score
        
        return dict
    }
    
    //MARK: - Utilities
    //--------------------------------------------------------------------------
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
        return lhs.uid == rhs.uid
    }
    
    //Exists
    func existsInArray(array:[User]) -> Bool {
        return self.index(array) != nil
    }
    
    /*
    //MARK: - Coder
    //---------------------------------------------------------------------------
    
    struct CodingKey {
        static let UID = "uid"
        static let FirstName = "first"
        static let LastName = "last"
        static let DisplayName = "displayName"
        static let Email = "email"
        static let Motto = "motto"
        static let PhotoString = "photoString"
        static let Score = "score"
    }
    
    func encodeWithCoder(archiver: NSCoder) {
        archiver.encodeObject(self.uid, forKey: CodingKey.UID)
        archiver.encodeObject(self.firstName, forKey: CodingKey.FirstName)
        archiver.encodeObject(self.lastName, forKey: CodingKey.LastName)
        archiver.encodeObject(self.displayName, forKey: CodingKey.DisplayName)
        archiver.encodeObject(self.email, forKey: CodingKey.Email)
        archiver.encodeObject(self.motto, forKey: CodingKey.Motto)
        archiver.encodeObject(self.photoString, forKey: CodingKey.PhotoString)
        archiver.encodeInteger(self.score, forKey: CodingKey.Score)
    }
    
    required init(coder unarchiver:NSCoder) {
        
        super.init()
        
        self.uid = unarchiver.decodeObjectForKey(CodingKey.UID) as! String
        self.firstName = unarchiver.decodeObjectForKey(CodingKey.FirstName) as! String
        self.lastName = unarchiver.decodeObjectForKey(CodingKey.LastName) as! String
        self.displayName = unarchiver.decodeObjectForKey(CodingKey.DisplayName) as! String
        self.email = unarchiver.decodeObjectForKey(CodingKey.Email) as! String
        self.motto = unarchiver.decodeObjectForKey(CodingKey.Motto) as? String
        self.score = Int(unarchiver.decodeObjectForKey(CodingKey.Score) as! Int)
        
        if let photoString = unarchiver.decodeObjectForKey(CodingKey.PhotoString) as? String,
            photoData = NSData(base64EncodedString: photoString, options: []){
            self.photo = UIImage(data: photoData)
        }
        
    }
*/
}


extension User {
    
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
    
}