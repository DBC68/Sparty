//
//  SettingsTVC.swift
//  Sparty
//
//  Created by David Colvin on 9/9/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SettingsTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Actions
    //--------------------------------------------------------------------------
    @IBAction func signOutAction(sender: UIBarButtonItem) {
        
        
        let alertController = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .Default, handler: { action in
            
            try! FIRAuth.auth()!.signOut()
            
            GIDSignIn.sharedInstance().signOut()
            
            NSUserDefaults.setIsRegistered(false)
            
//            if let controller:GoogleSignInVC = UIStoryboard.loadFromStoryboard() {
//                controller.modalTransitionStyle = .CrossDissolve
//                self.presentViewController(controller, animated: true) {
            
                    //Go to first tab after logging out
                    dispatch_async(dispatch_get_main_queue(),{
                        if let tabBarController = self.tabBarController {
                            tabBarController.selectedIndex = 0
                        }
                    })
            
            NSNotificationCenter.defaultCenter().postNotificationName(Notifications.ShowLogin, object: nil)
                    
                    
//                }
//            }
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler:nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    
    }

    
}
