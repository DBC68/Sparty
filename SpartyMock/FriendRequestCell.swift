//
//  FriendRequestCell.swift
//  Sparty
//
//  Created by David Colvin on 9/27/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

protocol FriendRequestCellDelegate: class {
    
    func addFriendRequest(friend: User)
}

class FriendRequestCell: UITableViewCell {
    
    weak var delegate: FriendRequestCellDelegate?
    
    var user: User! {
        didSet {
            self.usernameLabel.text = user.screenName
            self.photoView.image = user.photo
        }
    }

    @IBOutlet weak var photoView: RoundedImage!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    @IBAction func addAction(sender: AnyObject) {
        
        self.delegate?.addFriendRequest(self.user)
        self.addButton.enabled = false
    }
}
