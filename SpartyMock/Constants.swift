//
//  Constants.swift
//  SpartyMock
//
//  Created by David Colvin on 8/13/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

enum Units:Int {
    case Imperial = 0
    case Metric = 1
}

class Constants {

    static let creditPercent: Double = 0.1
    
    static let ImageBorderRadius:CGFloat = 5.0
    static let ImageBorderWidth:CGFloat = 1.0
    
    static let MinSearchCharacters = 3
    
    static let PhotoSize: CGFloat = 200.0
    
    static let ServerStringFormat = "MM/dd/yy h:mm a"
}
