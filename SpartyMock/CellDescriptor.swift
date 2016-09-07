//
//  CellDescriptor.swift
//  DynamicTableView
//
//  Created by David Colvin on 6/5/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import UIKit

enum CellType:String {
    case BasicCell
    case RightDetailCell
    case DateCell
    case DatePickerCell
    case ItemPickerCell
    case TextFieldCell
    case TextViewCell
    case RightSegueCell
    case SubtitleCell
    case PhotoCell
}

class CellDescriptor {
    
    var description:String {
        return key
    }
    
    var key:String!
    var cellType:CellType!
    var title:String?
    var subtitle:String?
    var placeholder:String?
    var isExpanded:Bool = false
    var value:AnyObject!
    var defaultValue:AnyObject!
    var cellId:String!
    
    var segueId:String?
    
    var child:CellDescriptor?
    var parent:CellDescriptor?
//    var defaultValue:Titleable?
}

class DateDescriptor: CellDescriptor {
    
    var datePickerMode:UIDatePickerMode?
    var dateFormat:NSDateFormatterStyle?
    var timeFormat:NSDateFormatterStyle?
    var pickerDaysAhead:Int?
    var pickerDaysBehind:Int?
    var minuteInterval:Int?
}

class ItemDescriptor: CellDescriptor {
    var items:[AnyObject]?
}

class CellFactory {
    
    class func basicCell(key:String!, title:String?, child:CellDescriptor? = nil) -> CellDescriptor {
        let descriptor = CellDescriptor()
        descriptor.key = key
        descriptor.cellType = .BasicCell
        descriptor.title = title
        descriptor.child = child
        descriptor.cellId = CellType.BasicCell.rawValue
        return descriptor
    }
    
    class func textFieldCell(key:String!, placeholder:String?, value:AnyObject? = nil) -> CellDescriptor {
        let descriptor = CellDescriptor()
        descriptor.key = key
        descriptor.cellType = .TextFieldCell
        descriptor.placeholder = placeholder
        descriptor.cellId = CellType.TextFieldCell.rawValue
        return descriptor
    }
    
    class func textViewCell(key:String!, placeholder:String?) -> CellDescriptor {
        let descriptor = CellDescriptor()
        descriptor.key = key
        descriptor.cellType = .TextViewCell
        descriptor.placeholder = placeholder
        descriptor.cellId = CellType.TextViewCell.rawValue
        return descriptor
    }
    
    class func rightDetailCell(key:String!, title:String?, subtitle:String?, value:AnyObject? = nil, child:CellDescriptor? = nil) -> CellDescriptor {
        let descriptor = CellDescriptor()
        descriptor.key = key
        descriptor.cellType = .RightDetailCell
        descriptor.title = title
        descriptor.subtitle = subtitle
        descriptor.child = child
        descriptor.defaultValue = value
        descriptor.cellId = CellType.RightDetailCell.rawValue
        return descriptor
    }
    
    class func datePickerCell(key:String!,
                               title:String?,
                               defaultDate: NSDate?,
                               datePickerMode:UIDatePickerMode,
                               dateFormat:NSDateFormatterStyle,
                               timeFormat:NSDateFormatterStyle,
                               daysAhead:Int = 0,
                               daysBehind:Int = 365,
                               minuteInterval:Int = 1) -> CellDescriptor {
        
        let dateDecriptor = DateDescriptor()
        dateDecriptor.cellType = .DatePickerCell
        dateDecriptor.datePickerMode = datePickerMode
        dateDecriptor.dateFormat = dateFormat
        dateDecriptor.timeFormat = timeFormat
        dateDecriptor.pickerDaysAhead = daysAhead
        dateDecriptor.pickerDaysBehind = daysBehind
        dateDecriptor.minuteInterval = minuteInterval
        dateDecriptor.cellId = CellType.DatePickerCell.rawValue
        
        let descriptor = CellDescriptor()
        descriptor.key = key
        descriptor.cellType = .DateCell
        descriptor.title = title
        descriptor.subtitle = "Now"
        
        if let date = defaultDate {
            descriptor.defaultValue = Date(date: date, descriptor: dateDecriptor)
        }
        descriptor.child = dateDecriptor
        descriptor.cellId = CellType.RightDetailCell.rawValue
        
        dateDecriptor.parent = descriptor
        
        return descriptor
    }
    
    class func itemPickerCell(key:String!, title:String?, defaultItem: AnyObject, items:[AnyObject]) -> CellDescriptor {
        
        let pickerDescriptor = ItemDescriptor()
        pickerDescriptor.cellType = .ItemPickerCell
        pickerDescriptor.items = items
        pickerDescriptor.cellId = CellType.ItemPickerCell.rawValue

        let descriptor = CellDescriptor()
        descriptor.key = key
        descriptor.cellType = .RightDetailCell
        descriptor.defaultValue = defaultItem
        descriptor.cellId = CellType.RightDetailCell.rawValue
        descriptor.title = title
        descriptor.subtitle = "Select"
        
        descriptor.child = pickerDescriptor
        pickerDescriptor.parent = descriptor
        
        return descriptor
    }
    
    class func rightSegueCell(key:String!, title:String!, subtitle:String?, segueId:String!) -> CellDescriptor {
        let descriptor = CellDescriptor()
        descriptor.key = key
        descriptor.cellType = .RightDetailCell
        descriptor.title = title
        descriptor.subtitle = subtitle
        descriptor.segueId = segueId
        descriptor.cellId = CellType.RightDetailCell.rawValue
        return descriptor
    }
    
    class func photoCell(key:String!) -> CellDescriptor {
        let descriptor = CellDescriptor()
        descriptor.key = key
        descriptor.cellType = .PhotoCell
        descriptor.cellId = CellType.PhotoCell.rawValue
        return descriptor
    }
}