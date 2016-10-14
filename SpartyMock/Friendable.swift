//
//  Friendable.swift
//  Sparty
//
//  Created by David Colvin on 10/14/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation

enum FriendType {
    case Request
    case Friend
}

protocol Friendable {
    var uid:String {get}
    var type: FriendType  {get}
}
