//
//  RightDetailCell.swift
//  DynamicTableView
//
//  Created by David Colvin on 6/5/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class RightDetailCell: UITableViewCell {
    
    var cellDescriptor: CellDescriptor! {
        didSet {
            titleLabel?.text = cellDescriptor.title
            subtitleLabel?.text = cellDescriptor.subtitle
            isSelected = cellDescriptor.isExpanded
        }
    }
    
    var isSelected:Bool! {
        didSet {
            subtitleLabel.textColor = (cellDescriptor.isExpanded == true) ? selectColor : UIColor.lightGrayColor()
        }
    }

    
    var selectColor:UIColor!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
}
