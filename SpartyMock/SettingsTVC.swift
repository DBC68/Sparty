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

    //MARK: - Outlets
    //--------------------------------------------------------------------------
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var mottoLabel: UILabel!
    
    //MARK: - View Lifecycle
    //--------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        let _ = SettingsVM(controller: self)
    }
    
    //MARK: - Actions
    //--------------------------------------------------------------------------
    @IBAction func signOutAction(sender: UIBarButtonItem) {
        
        
        let alertController = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Log Out", style: .Default, handler: { action in
            
            FirbaseManager.logOut()
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler:nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    
    }

    
}
