//
//  TabBarController.swift
//  Sparty
//
//  Created by David Colvin on 9/11/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit
import Firebase

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserverForName(Notifications.ShowLogin, object: nil, queue: nil) { (notification) in
            if let controller:GoogleSignInVC = UIStoryboard.loadFromStoryboard() {
                self.presentViewController(controller, animated: false, completion: nil)
            }
        }
        
    }
}
