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
    
    var score: Int! {
        didSet {
            self.controller.scoreLabel.text = String(score)
            self.credits = Int(Double(score) * Constants.creditPercent)
        }
    }
    
    var credits: Int! {
        didSet {
            self.controller.creditLabel.text = String(credits)
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
        
        //Set current user info
        let dataStore = DataStore.sharedInstance
        
        if let user = dataStore.user {
            self.fullName = user.fullName
            self.screenName = user.screenName
            self.motto = user.motto
            self.score = user.score
            self.photo = user.photo
        }
        
    }
    
    func observeUser(uid:String) {
        let path = FirebaseManager.ref.child(Node.Users).child(uid)
        path.observeEventType(.Value, withBlock: { (snapshot) in
            
            guard snapshot.exists() else { return }
            
            if let dict = snapshot.value as? [String:AnyObject],
                let user = User(dict: dict) {
                
                self.screenName = user.screenName
                
                if let motto = user.motto {
                    self.motto = motto
                }
                
                self.score = user.score
                
                
                if let photo = user.photo {
                    self.photo = photo
                }
                
                if let fullName = user.fullName {
                    self.fullName = fullName
                }
            }
            
        })

    }
}
