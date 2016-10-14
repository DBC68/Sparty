//
//  Friend.swift
//  SpartyMock
//
//  Created by David Colvin on 8/20/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit



class Friend {
    
    var isVIP = false
    var owner: User!
    var friend: User!
}

extension Friend: Friendable {
    var uid: String {
        return owner.uid
    }
    
    var type: FriendType {
        return .Friend
    }
}
