//
//  ProfileVM.swift
//  Sparty
//
//  Created by David Colvin on 9/18/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation

class ProfileVM {
    
    var controller: ProfileVC!
    var firstName: String!
    var lastName: String!
    var motto: String!
    {
        didSet {
            self.controller.mottoLabel.text = motto
        }
    }
    
    var displayName: String! {
        didSet {
            self.controller.screenNameLabel.text = displayName
        }
    }
    
    var photo: UIImage! {
        didSet {
            self.controller.photoView.image = photo
        }
    }
    
    var fullName: String {
        return firstName + " " + lastName
    }
    
    //MARK: - Initializers
    //--------------------------------------------------------------------------
    init(controller:ProfileVC) {
        self.controller = controller
        
        if let user = FirbaseManager.user {
        
            FirbaseManager.observeUser(user.uid) { (result) in
                
                self.displayName = result?.displayName
                
                if let motto = result?.motto {
                    self.motto = motto
                }
                
                if let photo = result?.photo {
                    self.photo = photo
                }
            }
        }
    }
}