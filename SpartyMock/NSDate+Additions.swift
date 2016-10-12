

import Foundation

extension NSDate {
    
    
    
    func stringify() -> String {
        
        guard self.timeIntervalSinceNow < 0 else {
            return self.shortString()
        }
        
        let seconds = self.timeIntervalSinceNow * -1.0
        let minutes = Int(seconds / 60.0)
        let hours = Int(seconds / 3600.0)
        let days =  Int(seconds / 86400.0)
        
        if seconds < 60 {
            return "\(Int(seconds)) sec ago"
        }
        
        if minutes < 60 {
            return "\(minutes) min ago"
        }
        
        if hours < 24 {
            return "\(hours) hr ago"
        }
        
        if days < 7 {
            return "\(days) days ago"
        }
        
        return self.mediumString()
        
    }
    
    func stringify(dateFormat dateFormat:NSDateFormatterStyle!, timeFormat:NSDateFormatterStyle!) -> String {
        let formatter = NSDateFormatter()
        formatter.dateStyle = dateFormat
        formatter.timeStyle = timeFormat
        return formatter.stringFromDate(self)
    }
    
    
    func shortString() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM/dd/yy h:mm a"
        return dateFormatter.stringFromDate(self)
    }
    
    func mediumString() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .MediumStyle
        dateFormatter.timeStyle = .ShortStyle
        return dateFormatter.stringFromDate(self)
    }
    
    func longString() -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM dd, yyyy h:mm a"
        return dateFormatter.stringFromDate(self)
    }
    
    func serverString(format: String) -> String {
        let dateformatter = NSDateFormatter()
        dateformatter.dateFormat = format
        return dateformatter.stringFromDate(self)
    }
    
    class func UTCOffSet () -> Int {
        return -1 * NSTimeZone.localTimeZone().secondsFromGMT / 60
    }
    
    func isGreaterThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isGreater = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
    
    func equalToDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isEqualTo = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedSame {
            isEqualTo = true
        }
        
        //Return Result
        return isEqualTo
    }
    
    func addDays(daysToAdd: Int) -> NSDate {
        let secondsInDays: NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
        let dateWithDaysAdded: NSDate = self.dateByAddingTimeInterval(secondsInDays)
        
        //Return Result
        return dateWithDaysAdded
    }
    
    func addHours(hoursToAdd: Int) -> NSDate {
        let secondsInHours: NSTimeInterval = Double(hoursToAdd) * 60 * 60
        let dateWithHoursAdded: NSDate = self.dateByAddingTimeInterval(secondsInHours)
        
        //Return Result
        return dateWithHoursAdded
    }
}
