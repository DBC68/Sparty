//
//  UINavigationController+Additions.swift
//  SpartyMock
//
//  Created by David Colvin on 8/17/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func darkNavBar() {
        self.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationBar.barTintColor = UIColor.primaryColor()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.opaque = true
    }
    
    func lightNavBar() {
        
        self.navigationBar.barTintColor = UIColor.modalBarColor()
        self.navigationBar.tintColor = UIColor.primaryColor()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.primaryColor()]
        self.navigationController?.navigationBar.opaque = true
    }
}