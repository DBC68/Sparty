//
//  UIViewController+Additions.swift
//  Sparty
//
//  Created by David Colvin on 9/9/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
    
    func showMessagePrompt(message:String) {
        
        let alertController = UIAlertController(title: "ERROR", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler:nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }

}