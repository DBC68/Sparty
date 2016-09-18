//
//  NewSpartyVM.swift
//  SpartyMock
//
//  Created by David Colvin on 8/29/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class NewSpartyVM {
    
    //MARK: - Properties
    //--------------------------------------------------------------------------
    var sparty: Sparty!
    var controller: NewSpartyTVC!
    
    var date:NSDate? {
        didSet {
            self.controller.dateLabel.text = dateString(date!)
            self.sparty.date = date!
        }
    }
    
    var duration:Double? {
        didSet {
            self.controller.durationLabel.text = durationString(duration!)
            self.sparty.duration = duration!
        }
    }
    
    //MARK: - Initializers
    //--------------------------------------------------------------------------
    init(sparty:Sparty?, controller:NewSpartyTVC) {
        self.sparty = sparty
        self.controller = controller
        self.controller.photoView.image = DataStore.sharedInstance.user.photo
    }
    
    //MARK: - Formatters
    //--------------------------------------------------------------------------
    private func durationString(duration:Double) -> String {
        
        let hr = Int(duration/60/60)
        let min = Int((duration/60/60 - Double(hr)) * 60)
        
        return "\(hr) hours" + (min > 0 ? " \(min) min" : "")
    }
    
    private func dateString(date:NSDate) -> String {
        
        let interval = date.timeIntervalSinceNow
        if interval < (7.5 * 60) {
            return "Now"
        }
        
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .ShortStyle
        return formatter.stringFromDate(date)
    }


}
