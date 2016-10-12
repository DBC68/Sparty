//
//  UIButton+Additions.swift
//  Sparty
//
//  Created by David Colvin on 10/4/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func off() {
        self.alpha = 0.5
        self.enabled = false
    }
    
    func on() {
        self.alpha = 1.0
        self.enabled = true
    }
    
    func state(isActive:Bool) {
        if isActive {
            self.on()
        } else {
            self.off()
        }
    }
}
