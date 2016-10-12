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
        setupGoogle()
        setupButton()
        self.indicator.stopAnimating()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        //Hide button and start indicater when screen transistions to Google authentication
        self.signInButton.hidden = true
        self.indicator.startAnimating()
    }
    
    //MARK: - Setup
    //--------------------------------------------------------------------------
    private func setupGoogle() {
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    private func setupButton() {
        self.signInButton.hidden = false
        self.signInButton.colorScheme = .Dark
    }
    
    //MARK - Google
    //--------------------------------------------------------------------------
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!, withError error: NSError!) {
        guard error == nil else {
            print(error.localizedDescription)
            assertionFailure()
            return
        }
        
        //Sign in using Google API
        FirebaseManager.signInGoogle(user) { (result) in
            switch result {
            case .Success(let user):
                
                //If successful, check if user exists in Firebase
                self.checkIfUserIsRegistered(user)
            case .Failure(let error):
                print(error)
                assertionFailure()
                return
            }
        }
    }
    
    func checkIfUserIsRegistered(user: FIRUser) {
        
        //Check if user exists in Firebase
        FirebaseManager.isRegistered(user.uid, completion: { (result) in
            
            dispatch_async(dispatch_get_main_queue(),{
                
                //If user is registered, dismiss
                if result == true {
                    print("User exists")
                    NSUserDefaults.setIsRegistered(true)
                    self.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    //If user is not registered, show registration screen
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
