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
    
    struct Key {
        static let Users = "users"
        static let Username = "Username"
    }
    
    //MARK: - Properties
    //--------------------------------------------------------------------------
    var ref = FIRDatabase.database().reference()
    
    private func loadUser() {
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child(Key.Users).child(userID!).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            // Get user value
            let username = snapshot.value![Key.Username] as! String
//            let user = User.init(username: username)
            
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}