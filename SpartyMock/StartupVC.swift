//
//  StartupVC.swift
//  Sparty
//
//  Created by David Colvin on 9/11/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class StartupVC: UIViewController {
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //If user is not logged in, show GoogleSignInVC
        if FIRAuth.auth()?.currentUser == nil {
            if let controller:GoogleSignInVC = UIStoryboard.loadFromStoryboard() {
                controller.modalTransitionStyle = .CrossDissolve
                self.presentViewController(controller, animated: true, completion: nil)
            }
        }
            
        //If user is not registerd, show RegisterNav
        else if AppState.sharedInstance.isRegistered == false {
            if let nav = UIStoryboard.loadNavFromStoryboard("RegisterNav") {
                nav.modalTransitionStyle = .CrossDissolve
                self.presentViewController(nav, animated: true, completion: nil)
            }
        }
            
        //Show tab bar controller
        else {
            if let user = FIRAuth.auth()?.currentUser {
                print("Authenticated user with uid: \(user.uid)")
            }
            
            if let controller:TabBarController = UIStoryboard.loadFromStoryboard() {
                controller.modalTransitionStyle = .CrossDissolve
                self.presentViewController(controller, animated: true, completion: nil)
            }
        }
    }
    
}
