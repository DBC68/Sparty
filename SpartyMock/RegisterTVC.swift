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
    
    //MARK: - Properties
    //--------------------------------------------------------------------------
    var vm: RegisterVM!

    //MARK: - Outlets
    //--------------------------------------------------------------------------
    @IBOutlet weak var screenNameField: UITextField!
    @IBOutlet weak var doneButton: UIBarButtonItem!
    @IBOutlet weak var mottoField: UITextField!
    @IBOutlet weak var photoView: UIImageView!
    
    //MARK: - View Lifecycle
    //--------------------------------------------------------------------------
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

    //MARK - Actions
    //--------------------------------------------------------------------------
    @IBAction func doneAction(sender: AnyObject) {
        
        self.view.endEditing(true)
        
        self.vm.screenName = self.screenNameField.text?.trim()
        self.vm.motto = self.mottoField.text?.trim()
        self.vm.photo = self.photoView.image
        
        guard self.vm.isValid() == true else {
            self.showHeaderView("Invalid Entry")
            return
        }
        
        FirbaseManager.isUniqueScreenName(self.vm.screenName) {
            
            result in
            
            dispatch_async(dispatch_get_main_queue(),{
                
                if result == true {
                    
                    FirbaseManager.saveUserInfo(self.vm.dict())
                    
                    AppState.isRegistered = true
                    
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    self.showMessagePrompt("The screenName \(self.vm.screenName) is already taken.  Please try again.")
                }
            })
        }
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
