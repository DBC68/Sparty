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
    }
    
    struct Key {
        static let ScreenName = "screenName"
    }
    

    static func ref() -> FIRDatabaseReference {
        return FIRDatabase.database().reference()
    }
    
    
    static func isUniqueScreenName(userName:String, completion: (result:Bool) -> Void) {
        
        ref().child(Node.Users).child(userName).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            completion(result: snapshot == nil)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func saveUserInfo(dict: [String:AnyObject]) {
        let user = FIRAuth.auth()?.currentUser
        ref().child(Node.Users).child(user!.uid).setValue(dict)
    }
    
//    private func loadUser() {
//        
//        let userID = FIRAuth.auth()?.currentUser?.uid
//        ref.child(Key.Users).child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
//            // Get user value
//            let username = snapshot.value![Key.Username] as! String
////            let user = User.init(username: username)
//            
//            // ...
//        }) { (error) in
//            print(error.localizedDescription)
//        }
//    }

}