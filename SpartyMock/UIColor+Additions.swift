//
//  UIColor+Additions.swift
//  SpartyMock
//
//  Created by David Colvin on 8/3/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    class func primaryColor() -> UIColor {
        return UIColor(red:0.23, green:0.11, blue:0.35, alpha:1.00)
    }
    
    class func secondColor() -> UIColor {
        return UIColor(red:0.92, green:0.84, blue:1.00, alpha:1.00)
    }
    
    class func thirdColor() -> UIColor {
        return UIColor(red:0.78, green:0.54, blue:1.00, alpha:1.00)
    }
    
    class func fourthColor() -> UIColor {
        return UIColor(red:0.46, green:0.42, blue:0.50, alpha:1.00)
    }
    
    class func backgroundColor() -> UIColor {
        return UIColor(red:0.93, green:0.93, blue:1.00, alpha:1.00) //#EEEEFF
    }
    
    class func darkTypeColor() -> UIColor {
        return UIColor(red:0.47, green:0.47, blue:0.53, alpha:1.00) //#777788
    }
    
    class func lightTypeColor() -> UIColor {
        return UIColor(red:0.67, green:0.67, blue:0.73, alpha:1.00) //#AAAABB
    }
    
    class func navBarColor() -> UIColor {
        return UIColor.primaryColor()
    }
    
    class func modalBarColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    class func navTextColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    class func pageControlColor() -> UIColor {
        return UIColor(red:0.95 , green:0.95, blue:0.95, alpha:1.00)
    }
    
    class func imageBorderColor() -> UIColor {
        return UIColor.groupTableViewBackgroundColor()
    }
    
    class func placeholderTextColor() -> UIColor {
        return UIColor(red:0.78, green:0.78, blue:0.80, alpha:1.00)
    }
    
    class func alertTextColor() -> UIColor {
        return UIColor.primaryColor()
    }
    
    class func errorColor () -> UIColor {
        return UIColor.redColor()
    }
}