//
//  Sparty.swift
//  SpartyMock
//
//  Created by David Colvin on 8/13/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class Sparty: NSObject {
    
    struct FormKey {
        static let Title = "Title"
        static let Comment = "Comment"
        static let Date = "Date"
        static let Duration = "Duration"
        static let Location = "Location"
        static let Photo = "Photo"
    }

    //MARK: - Properties
    //--------------------------------------------------------------------------
    var spartyId: String!
    var title: String!
    var comment: String?
    var hostId: String!
    var date: NSDate!
    var duration: Double! //seconds
    var location: Location!
    var photo: UIImage?
    
    var guests: [Guest] {
        return DataStore.sharedInstance.guests.filter({$0.spartyId == spartyId})
    }
    
    var isMySparty: Bool {
        return hostId == DataStore.sharedInstance.user!.uid
    }
    
    var isPending: Bool {
        return NSDate().isLessThanDate(date)
    }
    
    var isActive: Bool {
        let hours = Int(self.duration / 60 / 60)
        let endDate = date.addHours(hours)
        return NSDate().isGreaterThanDate(date) && NSDate().isLessThanDate(endDate)
    }
    
    var isOver: Bool {
        let hours = Int(self.duration / 60 / 60)
        let endDate = date.addHours(hours)
        return NSDate().isGreaterThanDate(endDate)
    }
    
    var invitedCount: Int {
        return self.guests.count
    }
    
    var goingCount: Int {
        return self.guests.filter({$0.rsvp == .Yes}).count
    }
    
    var notGoingCount: Int {
        return self.guests.filter({$0.rsvp == .No}).count
    }
    
    var maybeCount: Int {
        return self.guests.filter({$0.rsvp == .Maybe}).count
    }
    
    var checkedInCount: Int {
        return self.guests.filter({$0.isCheckedIn == true}).count
    }
    
    static func spartyForDataDictionary(dict: [String:AnyObject]) -> Sparty {
        
        let sparty = Sparty()
        sparty.title = dict[FormKey.Title] as? String
        sparty.comment = dict[FormKey.Comment] as? String
        sparty.date = dict[FormKey.Date] as? NSDate
        sparty.duration = dict[FormKey.Duration] as? Double
        sparty.location = dict[FormKey.Location] as? Location
        sparty.hostId = DataStore.sharedInstance.user!.uid
        sparty.spartyId = NSUUID().UUIDString
        sparty.photo = dict[FormKey.Photo] as? UIImage
        
        return sparty
    }
    
    static func spartyForPlistDictionary(dict:[String:AnyObject]) -> Sparty {
        
        guard let spartyId = dict["spartyId"] as? String,
            title = dict["title"] as? String,
            comment = dict["comment"] as? String,
            hostId = dict["hostId"] as? String,
            date = dict["date"] as? NSDate,
            duration = dict["duration"] as? Double,
        location = dict["location"] as? [String:AnyObject] else { abort() }
        
        let sparty = Sparty()
        
        if let photoName = dict["photoName"] as? String {
            sparty.photo = UIImage(named: photoName)
        }
        
        sparty.spartyId = spartyId
        sparty.title = title
        sparty.comment = comment
        sparty.hostId = hostId
        sparty.date = date
        sparty.duration = duration
        sparty.location = Location(dict: location)
        
        return sparty
    }
    
    //Returns index of object in  array
    func index(array:[Sparty]) -> Int? {
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
        return lhs.date!.isEqualToDate(rhs.date)
    }
    
    //Exists
    func existsInArray(array:[Sparty]) -> Bool {
        return self.index(array) != nil
    }

    //MARK: - Validation
    //--------------------------------------------------------------------------
    func isValidTitle() -> Bool {
        return !(self.title.trim() ?? "").isEmpty
    }
    
    func isValidLocation() -> Bool {
        return self.location != nil
    }
}
