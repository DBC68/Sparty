//
//  Request.swift
//  Sparty
//
//  Created by David Colvin on 10/7/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation

class Request: Friendable {
    
    struct FBKey {
        static let toUserId = "toUserId"
        static let fromUserId = "fromUserId"
        static let status = "status"
        static let date = "date"
    }
    
    enum Status: String {
        case Pending
        case Accepted
        case Rejected
    }
    
    var fromUserId: String
    var toUserId: String
    var status:Status
    var date: NSDate
    
    init(fromUserId: String, toUserId: String) {
        self.fromUserId = fromUserId
        self.toUserId = toUserId
        self.date = NSDate()
        self.status = .Pending
    }
}
