//
//  DatePickerCell.swift
//  DynamicTableView
//
//  Created by David Colvin on 6/5/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class Date: NSObject, Titleable {
    
    var date:NSDate
    var descriptor:DateDescriptor
    
    func title() -> String {
        
        return date.stringify(dateFormat:descriptor.dateFormat, timeFormat:descriptor.timeFormat)
    }
    
    func data() -> AnyObject {
        return date
    }
    
    init(date:NSDate, descriptor:DateDescriptor) {
        self.date = date
        self.descriptor = descriptor
    }
    
    override var description : String {
        return title()
    }
}

class DatePickerCell: UITableViewCell {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var cellDescriptor: DateDescriptor! {
        didSet {
            datePicker.datePickerMode = cellDescriptor.datePickerMode!
            datePicker.minuteInterval = cellDescriptor.minuteInterval!
            datePicker.maximumDate = NSCalendar.currentCalendar().dateByAddingUnit(
                .Day,
                value: cellDescriptor.pickerDaysAhead!,
                toDate: NSDate(),
                options: NSCalendarOptions(rawValue: 0))
            
            datePicker.minimumDate = NSCalendar.currentCalendar().dateByAddingUnit(
                .Day,
                value: -cellDescriptor.pickerDaysBehind!,
                toDate: NSDate(),
                options: NSCalendarOptions(rawValue: 0))
        }
    }
    var date:NSDate!
    var parentIndexPath:NSIndexPath?
    
    @IBAction func valueChanged(sender: UIDatePicker) {
        
        let date = Date(date: datePicker.date, descriptor: cellDescriptor)
        
        cellDescriptor.value = date
        
        NSNotification.selectionCallback(cellDescriptor)

    }
}
