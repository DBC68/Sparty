//
//  FirebaseManager.swift
//  Sparty
//
//  Created by David Colvin on 9/11/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import Firebase

struct ProviderProfile {
    var providerID: String
    var uid: String
    var screenName: String?
    var email: String?
    var photoURL: NSURL?
    
    init(profile: FIRUserInfo) {
        providerID = profile.providerID
        uid = profile.uid;  // Provider-specific UID
        screenName = profile.displayName
        email = profile.email
        photoURL = profile.photoURL
    }
}

enum Result<T> {
    case Success(T)
    case Failure(ErrorType)
}


class FirbaseManager: NSObject {
    
    struct Node {
        static let Users = "users"
        static let Usernames = "usernames"
        static let Emails = "emails"
    }
    
    struct Key {
        static let Username = "username"
    }
    

    static var ref = FIRDatabase.database().reference()
    
    static var user = FIRAuth.auth()?.currentUser
    
    
    //Username
    //--------------------------------------------------------------------------
    static func saveUsername(userName:String) {
        let path = self.ref.child(Node.Usernames).child(userName.toBase64())
        path.setValue(self.user!.uid)
    }
    
    static func isUniqueScreenName(username:String, completion: (result:Bool) -> Void) {
        let path = self.ref.child(Node.Usernames).child(username.toBase64())
        path.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            completion(result: snapshot.exists() == false)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //Email
    //--------------------------------------------------------------------------
    static func saveEmail(email:String) {
        let path = self.ref.child(Node.Emails).child(email.toBase64())
        path.setValue(self.user!.uid)
    }
    
    //User
    //--------------------------------------------------------------------------
    static func saveUserInfo(dict: [String:AnyObject]) {
        let path = self.ref.child(Node.Users).child(self.user!.uid)
        path.setValue(dict)
    }
    
    static func providerProfile(completion:(profile: ProviderProfile?) -> Void) {
        if let user = FIRAuth.auth()?.currentUser {
            for data in user.providerData {
                completion(profile: ProviderProfile(profile: data))
            }
        } else {
            completion(profile: nil)
        }
    }
    
    static func isRegistered(uid:String, completion:(result:Bool) -> Void) {
        let path = self.ref.child(Node.Users).child(uid)
        path.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            completion(result: snapshot.exists())
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func observeUser(uid:String, completion:(result:User?) -> Void) {
        let path = self.ref.child(Node.Users).child(uid)
        path.observeEventType(.Value, withBlock: { (snapshot) in
            
            guard snapshot.exists() else {
                completion(result: nil)
                return
            }
            
            if let dict = snapshot.value as? [String:AnyObject],
                let user = User(dict: dict) {
                completion(result: user)
            }
            
        }) { (error) in
            completion(result: nil)
            print(error.localizedDescription)
        }
    }
    
    static func loadUser(uid:String, completion:(result:User?) -> Void) {
        let path = self.ref.child(Node.Users).child(uid)
        path.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            guard snapshot.exists() else {
                completion(result: nil)
                return
            }
            
            if let dict = snapshot.value as? [String:AnyObject],
                let user = User(dict: dict) {
                completion(result: user)
            }
            
        }) { (error) in
            completion(result: nil)
            print(error.localizedDescription)
        }
    }
    
    static func signInGoogle(user:GIDGoogleUser, completion:(Result<FIRUser>) -> Void) {
        
        let authentication = user.authentication
        let credential = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken,
                                                                     accessToken: authentication.accessToken)
        FIRAuth.auth()?.signInWithCredential(credential) { (user, error) in
            
            if let error = error {
                completion(.Failure(error))
                return
            }
            completion(.Success(user!))
        }
    }
    
    static func logOut() {
        
        self.ref.removeAllObservers()
        
        try! FIRAuth.auth()!.signOut()
        
        GIDSignIn.sharedInstance().signOut()
        
        NSUserDefaults.setIsRegistered(false)
        
        NSNotificationCenter.defaultCenter().postNotificationName(Notifications.ShowLogin, object: nil)
    }
}
