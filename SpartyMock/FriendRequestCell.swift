//
//  FriendRequestCell.swift
//  Sparty
//
//  Created by David Colvin on 9/27/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class FriendRequestCell: UITableViewCell {
    
    var user: User! {
        didSet {
            self.usernameLabel.text = user.screenName
            self.photoView.image = user.photo ?? UIImage(named: "user")
        }
    }

    @IBOutlet weak var photoView: RoundedImage!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addAction(sender: AnyObject) {
    
        self.addButton.enabled = false
        FirebaseManager.saveFriendRequest(user)
    }
}
