//
//  GoogleSignInVC.swift
//  Sparty
//
//  Created by David Colvin on 9/7/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class GoogleSignInVC: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    
    
    //MARK: - Outlets
    //--------------------------------------------------------------------------
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var indicator: UIActivityIndicatorView!

    //MARK: - View Lifecycle
    //--------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        self.signInButton.colorScheme = .Dark
        
        self.signInButton.hidden = false
        self.indicator.stopAnimating()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.signInButton.hidden = true
        self.indicator.startAnimating()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - Google
    //--------------------------------------------------------------------------
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        guard error == nil else {
            print(error.localizedDescription)
            assertionFailure()
            return
        }
        
        FirbaseManager.signInGoogle(user) { (result) in
            switch result {
            case .Success(let user):
                self.checkIfUserIsRegistered(user)
            case .Failure(let error):
                print(error)
                assertionFailure()
                return
            }
        }
    }
    
    func checkIfUserIsRegistered(user: FIRUser) {
        FirbaseManager.isRegistered(user.uid, completion: { (result) in
            
            dispatch_async(dispatch_get_main_queue(),{
                
                //If is registered, dismiss login else show register screen
                if result == true {
                    print("User exists")
                    NSUserDefaults.setIsRegistered(true)
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    print("User does not exist")
                    if let nav = UIStoryboard.loadNavFromStoryboard(StoryboardIDs.RegisterNav) {
                        nav.modalTransitionStyle = .CrossDissolve
                        self.presentViewController(nav, animated: true, completion: nil)
                    }
                }
            })
        })
    }
}
