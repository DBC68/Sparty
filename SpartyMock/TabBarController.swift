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
            
            //Go to first tab after logging out
            self.selectedIndex = 0
            
            if let controller:GoogleSignInVC = UIStoryboard.loadFromStoryboard() {
                self.presentViewController(controller, animated: false, completion: nil)
            }
        }
        
        NSNotificationCenter.defaultCenter().addObserverForName(Notifications.ShowRegistration, object: nil, queue: nil) { (notification) in
            if let nav = UIStoryboard.loadNavFromStoryboard("RegisterNav") {
                nav.modalTransitionStyle = .CrossDissolve
                self.presentViewController(nav, animated: false, completion: nil)
            }
        }
        
    }
}
