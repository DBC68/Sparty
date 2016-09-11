//
//  RegisterVM.swift
//  Sparty
//
//  Created by David Colvin on 9/10/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation

class RegisterVM: NSObject {
    
    /* See here:
 http://grokbase.com/t/gg/firebase-talk/165nfjzyjy/firebase-ios-swift-most-efficient-way-to-save-a-unique-username-value-to-new-user-at-registration
 */
    
    //MARK: - Properties
    //--------------------------------------------------------------------------
    var controller: RegisterTVC!
    
    var screenName: String?
    var motto: String?
    var photo: UIImage?
    
    //MARK: - Validation
    //--------------------------------------------------------------------------
    func isValid() -> Bool {
        return isValidScreenName() && isValidMotto() && isValiPhoto()
    }
    
    func isValidScreenName() -> Bool {
         return !(self.screenName ?? "").isEmpty
    }
    
    func isUniqueScreenName(completion:Bool) {
        //TODO: Check server
    }
    
    func isValidMotto() -> Bool {
        return !(self.motto ?? "").isEmpty
    }
    
    func isValiPhoto() -> Bool {
        return self.photo != nil
    }
    
    //MARK: - Initializers
    //--------------------------------------------------------------------------
    init(controller:RegisterTVC) {
        super.init()
        self.controller = controller
    }
    
    func saveUserInfo() {
        //TODO: Save to server
    }
}
