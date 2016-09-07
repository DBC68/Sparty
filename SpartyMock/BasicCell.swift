//
//  BasicCell.swift
//  DynamicTableView
//
//  Created by David Colvin on 6/5/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class BasicCell: UITableViewCell {
    
    var cellDescriptor: CellDescriptor! {
        didSet {
            textLabel?.text = cellDescriptor.title
        }
    }
}
