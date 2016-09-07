//
//  TextViewCell.swift
//  DynamicTableView
//
//  Created by David Colvin on 6/5/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class TextViewCell: UITableViewCell, UITextViewDelegate {
    
    @IBOutlet weak var textView: UITextView!
    
    var cellDescriptor: CellDescriptor! {
        didSet {
            showHidePlaceholder()
            textView.delegate = self
        }
    }
    
    func showHidePlaceholder() {
        if textView.text.characters.count > 0 {
            textView.hidePlaceholder()
        }
        else {
            if let placeholder = cellDescriptor.placeholder {
                textView.showPlaceholder(placeholder)
            }
        }
    }
    
    func textViewDidChange(textView: UITextView) {
        
        showHidePlaceholder()
        if let text = textView.text {
            cellDescriptor.value = text
        }
    }
    
//    public func textViewDidBeginEditing(textView: UITextView) {
//        NSNotification.dataEntered()
//    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        NSNotification.dataEntered()
        return true
    }
}
