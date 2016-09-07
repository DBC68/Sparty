//
//  NSNotification+SelectionCallback.swift
//  DynamicTableView
//
//  Created by David Colvin on 6/12/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

struct DynamicTableView {

    struct Notification {
        static let SelectionCallback = "DynamicTableViewSelectionCallbackNotification"
        static let DataEntered = "DynamicTableViewDataEnteredNotification"
    }
    
    struct Key {
        static let SelectionCallback = "DynamicTableViewSelectionCallbackKey"
        static let ItemSelectedKey = "DynamicTableViewItemSelectedKey"
        static let ItemSelectedValue = "DynamicTableViewItemSelectedValue"
        static let SelectedItemDescriptor = "DynamicTableViewSelectedItemDescriptor"
    }
}


extension NSNotification {
    

    class func selectionCallback(descriptor:CellDescriptor) {
        
        NSNotificationCenter.defaultCenter().postNotificationName(DynamicTableView.Notification.SelectionCallback, object: self, userInfo: [DynamicTableView.Key.SelectedItemDescriptor:descriptor])
    }
    
    class func dataEntered() {
        NSNotificationCenter.defaultCenter().postNotificationName(DynamicTableView.Notification.DataEntered, object: self)
    }
    
    
    
}