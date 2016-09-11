//
//  RegisterTVC.swift
//  Sparty
//
//  Created by David Colvin on 9/10/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit
import Firebase

class RegisterTVC: UITableViewController {
    
    var vm: RegisterVM!

    @IBOutlet weak var screenNameField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var mottoField: UITextField!
    @IBOutlet weak var photoView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.lightNavBar()
        self.screenNameField.becomeFirstResponder()
        self.vm = RegisterVM(controller: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func doneAction(sender: AnyObject) {
        
        self.view.endEditing(true)
    }
   
    @IBAction func addPhotoAction(sender: AnyObject) {
        
        self.view.endEditing(true)
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        let alertController = UIAlertController(title: "Are you sure?", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        
        alertController.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { action in
            do {
                try! FIRAuth.auth()!.signOut()
                
                GIDSignIn.sharedInstance().signOut()
                
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }))
        
        alertController.addAction(UIAlertAction(title: "No", style: .Cancel, handler:nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
