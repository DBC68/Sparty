//
//  SubtitleCell.swift
//  DynamicTableView
//
//  Created by David Colvin on 6/5/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class SubtitleCell: UITableViewCell {
    
    var cellDescriptor: CellDescriptor! {
        didSet {
            textLabel?.text = cellDescriptor.title
            detailTextLabel?.text = cellDescriptor.subtitle
        }
    }
}
