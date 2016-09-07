//
//  UITextView+Placeholder.swift
//  DynamicTableView
//
//  Created by David Colvin on 6/5/16.
//  Copyright © 2016 Distal Industries. All rights reserved.

import UIKit

extension UITextView {
    
    
    var hasPlaceholder:Bool {
        
        get {
            for subview in self.subviews{
                if subview is UILabel {
                    return true
                }
            }
            return false
        }
    }
    
    
    func showPlaceholder(text:String) {
        
        if !self.hasPlaceholder {
            let placeholderLabel = UILabel(frame: CGRectMake(4,6,0,0))
            placeholderLabel.text = text
            placeholderLabel.sizeToFit()
            placeholderLabel.textColor = UIColor.placeholderTextColor()
            placeholderLabel.font = UIFont(name: "HelveticaNeue", size: 14)
            self.addSubview(placeholderLabel)
        }
    }
    
    
    func hidePlaceholder() {
        if self.hasPlaceholder {
            for subview in self.subviews{
                if let label = subview as? UILabel {
                    label.removeFromSuperview()
                    break
                }
            }
        }
    }
}