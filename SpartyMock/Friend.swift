//
//  Friend.swift
//  SpartyMock
//
//  Created by David Colvin on 8/20/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

enum FriendStatus: Int {
    case Invite = 2
    case Recent = 1
    case Friend = 3
    case Rejected = 4
}

class Friend: NSObject {
    
    var ownerId: String!
    var userId: String!
    var status:FriendStatus!
    var ranking: String!
    var isVIP = false
    
    init(dict:[String:AnyObject]) {
        
        guard let ownerId = dict["ownerId"] as? String,
            userId = dict["userId"] as? String,
            status = dict["status"] as? Int,
            ranking = dict["ranking"] as? String,
            isVIP = dict["isVIP"] as? Bool else { abort() }
        
        self.status = FriendStatus(rawValue: status)
        self.ownerId = ownerId
        self.userId = userId
        self.ranking = ranking
        self.isVIP = isVIP
    }

}
