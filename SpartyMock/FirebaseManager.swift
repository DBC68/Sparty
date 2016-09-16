//
//  FirebaseManager.swift
//  Sparty
//
//  Created by David Colvin on 9/11/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import Firebase

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
        path.setValue(user!.uid)
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
        let path = ref.child(Node.Users).child(user!.uid)
        path.setValue(dict)
    }
    
    static func isRegistered(uid:String, completion: (result:Bool) -> Void) {
        let path = ref.child(Node.Users).child(uid)
        path.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            completion(result: snapshot.exists())
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}