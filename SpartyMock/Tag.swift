//
//  Tag.swift
//  SpartyMock
//
//  Created by David Colvin on 8/21/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class Tag: NSObject {
    
    var name: String!
    var userId: String!

    
    init(name: String, userId: String) {
        self.name = name
        self.userId = userId
    }
}
