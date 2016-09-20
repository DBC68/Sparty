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


class FirbaseManager: NSObject {
    
    struct Node {
        static let Users = "users"
        static let Usernames = "usernames"
    }
    
    struct Key {
        static let Username = "username"
    }
    

    static var ref = FIRDatabase.database().reference()
    
    static var user = FIRAuth.auth()?.currentUser
    
    
    //Username
    //--------------------------------------------------------------------------
    static func saveUsername(userName:String) {
        let path = ref.child(Node.Usernames).child(userName)
        path.setValue(self.user!.uid)
    }
    
    static func isUniqueScreenName(username:String, completion: (result:Bool) -> Void) {
        let path = ref.child(Node.Usernames).child(username)
        path.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            completion(result: snapshot.exists() == false)
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //User
    //--------------------------------------------------------------------------
    static func saveUserInfo(dict: [String:AnyObject]) {
        let path = ref.child(Node.Users).child(self.user!.uid)
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
        let path = ref.child(Node.Users).child(uid)
        path.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            completion(result: snapshot.exists())
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func observeUser(uid:String, completion:(result:User?) -> Void) {
        let path = ref.child(Node.Users).child(uid)
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
}