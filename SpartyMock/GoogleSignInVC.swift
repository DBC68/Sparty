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
        if let error = error {
            showMessagePrompt(error.localizedDescription)
            return
        }
        
        let authentication = user.authentication
        let credential = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken,
                                                                     accessToken: authentication.accessToken)
        
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            
            if let error = error {
                self.showMessagePrompt(error.localizedDescription)
                return
            }
            
            dispatch_async(dispatch_get_main_queue(),{
                
                if AppState.isRegistered == false {
                    if let nav = UIStoryboard.loadNavFromStoryboard("RegisterNav") {
                        nav.modalTransitionStyle = .CrossDissolve
                        self.presentViewController(nav, animated: true, completion: nil)
                    }
                } else {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            })
        }

    }
    
    

}
