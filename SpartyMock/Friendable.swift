//
//  Friendable.swift
//  Sparty
//
//  Created by David Colvin on 10/9/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation

protocol Friendable {
    var fromUserId: String {get set}
    var toUserId: String {get set}
    var date: NSDate {get set}
}
