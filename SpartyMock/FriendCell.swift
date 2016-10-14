//
//  FriendCell.swift
//  SpartyMock
//
//  Created by David Colvin on 8/20/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit
import Firebase

class FriendCell: UITableViewCell {
    
    //MARK: - Outlets
    //--------------------------------------------------------------------------
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    //MARK: - Setup
    //--------------------------------------------------------------------------
    func configure(item: Friendable) {
        
        FirebaseManager.user(forUserID: item.uid) { user in
    
            dispatch_async(dispatch_get_main_queue(),{
                self.nameLabel.text = user.fullName
                
                self.photoView.image = user.photo ?? UIImage(named: "user")
                
                let pointString = user.pointsString + " points"
                self.pointsLabel.text = pointString
            })
        }

    }
    
}
