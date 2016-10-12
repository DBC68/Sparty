//
//  RegisterVM.swift
//  Sparty
//
//  Created by David Colvin on 9/10/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import Firebase

class RegisterVM {
    
    //MARK: - Properties
    //--------------------------------------------------------------------------
    var controller: RegisterTVC!
    
    let ref = FIRDatabase.database().reference()
    
    var username: String! {
        return self.controller.screenNameField.text?.trim()
    }
    var isUniqueScreenName: Bool = false
    
    var motto: String? {
        return self.controller.mottoField.text?.trim()
    }

    var photo: UIImage?
    
    func createNewUser() -> User {
        let user = User()
        user.screenName = username
        user.motto = motto
        user.photo = photo
        
        FirebaseManager.providerProfile { (profile) in
            user.fullName = profile?.screenName
            user.email = profile?.email
        }
        
        return user
    }
    
    //MARK: - Validation
    //--------------------------------------------------------------------------
    var isValid: Bool {
        return isValidUsername && isValidMotto && isValidPhoto && isUniqueScreenName
    }
    
    var isValidUsername: Bool {
         return !(self.username ?? "").isEmpty
    }
    
    var isValidMotto: Bool {
        return !(self.motto ?? "").isEmpty
    }
    
    var isValidPhoto: Bool {
        return true
//        return self.photo != nil
    }
    
    //MARK: - Initializers
    //--------------------------------------------------------------------------
    init(controller:RegisterTVC) {
        self.controller = controller
    }
}
