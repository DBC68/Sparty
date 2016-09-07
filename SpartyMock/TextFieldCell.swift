//
//  TextFieldCell.swift
//  DynamicTableView
//
//  Created by David Colvin on 6/5/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell {
    
    @IBOutlet weak var field: UITextField!
    
    var cellDescriptor: CellDescriptor! {
        didSet {
            field.placeholder = self.cellDescriptor.placeholder
            
            if let item = cellDescriptor.value {
                field.text = item.title
            }
        }
    }
    @IBAction func textDidBeginEditing(sender: UITextField) {
        
        NSNotification.dataEntered()
    }
    
    @IBAction func textDidChange(sender: UITextField) {
        cellDescriptor.value = sender.text
        NSNotification.dataEntered()
    }
}
