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


class FirebaseManager: NSObject {
    
    static let shared = FirebaseManager()
    
    struct Key {
        static let Username = "username"
    }
    

    static var ref = FIRDatabase.database().reference()
    
    static var user: FIRUser? {
        return FIRAuth.auth()?.currentUser
    }
    
    
    //MARK: - Username
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
    
    static func search(forScreenName screenName:String, completion: (foundUsers:[User]) -> Void) {
        //Get all users and screen for screenName
        //Will need to be refactored later to accomondate lots of users
        self.ref.child(Node.Users).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            if snapshot.exists() {
                let value = snapshot.value as! [String:AnyObject]
                var users = [User]()
                for (key, dict) in value {
                    if let user = User(dict: dict as! [String:AnyObject]) {
                        user.uid = key
                        users.append(user)
                    }
                }
                let found = users.filter{$0.screenName.containsString(screenName)}
                //Exclude current user from results
                let notMe = found.filter{$0.screenName != DataStore.sharedInstance.user!.screenName}
                completion(foundUsers:notMe)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }

    
    //MARK: - Email
    //--------------------------------------------------------------------------
    static func saveEmail(email:String) {
        let path = self.ref.child(Node.Emails).child(email.toBase64())
        path.setValue(self.user!.uid)
    }
    
    //MARK: - User
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
    
    static func user(forUserID uid:String, completion:(User) -> Void) {
        
        let path = FirebaseManager.ref.child(Node.Users).child(uid)
        
        path.observeEventType(.Value, withBlock: { snapshot in
            
            if let value = snapshot.value as? [String:AnyObject],
                let user = User(dict: value) {
                completion(user)
            }
        })
    }
    
    //MARK: - Friend Request
    //--------------------------------------------------------------------------
    static func saveFriendRequest(user: User) {
        let request = Request(fromUserId: FirebaseManager.user!.uid, toUserId: user.uid)
        let path = self.ref.child(Node.Requests).child(request.toUserId).child(request.fromUserId)
        path.setValue(request.status.rawValue)
    }
    
    static func acceptFriendRequest() {
        
    }
    
    //MARK: - Sign In
    //--------------------------------------------------------------------------
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
    
    //MARK: - Sign Out
    //--------------------------------------------------------------------------
    static func logOut() {
        
        self.ref.removeAllObservers()
        
        try! FIRAuth.auth()!.signOut()
        
        GIDSignIn.sharedInstance().signOut()
        
        NSUserDefaults.setIsRegistered(false)
        
        NSNotificationCenter.defaultCenter().postNotificationName(Notifications.ShowLogin, object: nil)
    }
}
