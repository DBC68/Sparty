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

    //MARK: - View Lifecycle
    //--------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Setup
    //--------------------------------------------------------------------------
    private func setup() {
        self.signInButton.colorScheme = .Dark
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
                self.dismissViewControllerAnimated(true, completion: nil)
            })
        }

    }

}
