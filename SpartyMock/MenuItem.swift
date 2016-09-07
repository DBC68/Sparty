//
//  MenuItem.swift
//  SpartyMock
//
//  Created by David Colvin on 8/14/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation

enum MenuSection {
    case Status
    case Ownership
}


class MenuItem: NSObject {
    var title: String
    var section: MenuSection
    var isSelected: Bool = true
    
    init(title: String, section: MenuSection) {
        self.title = title
        self.section = section
    }
}