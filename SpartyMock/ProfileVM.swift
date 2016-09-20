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

    var motto: String!
    {
        didSet {
            self.controller.mottoLabel.text = motto
        }
    }
    
    var screenName: String! {
        didSet {
            self.controller.screenNameLabel.text = screenName
        }
    }
    
    var photo: UIImage! {
        didSet {
            self.controller.photoView.image = photo
        }
    }
    
    var fullName: String! {
        didSet {
            self.controller.nameLabel.text = fullName
        }
    }
    
    //MARK: - Initializers
    //--------------------------------------------------------------------------
    init(controller:ProfileVC) {
        self.controller = controller
        
        if let user = FirbaseManager.user {
        
            FirbaseManager.observeUser(user.uid) { (result) in
                
                self.screenName = result?.screenName
                
                if let motto = result?.motto {
                    self.motto = motto
                }
                
                if let photo = result?.photo {
                    self.photo = photo
                }
                
                if let fullName = result?.fullName {
                    self.fullName = fullName
                }
            }
        }
    }
}