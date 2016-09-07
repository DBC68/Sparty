//
//  FriendCell.swift
//  SpartyMock
//
//  Created by David Colvin on 8/20/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class FriendCell: UITableViewCell {
    
    var friend: Friend! {
        didSet {
            
            let user = DataStore.sharedInstance.userForUserId(friend.userId)
            
            self.nameLabel.text = user!.fullName + (friend.isVIP == true ? " 👑" : "")
            self.photoView.image = user!.photo
            
            let pointString = user!.pointsString + " points"
            self.pointsLabel.text = pointString
            
            self.accessoryType = .DisclosureIndicator

        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var photoView: RoundedImage!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
}
