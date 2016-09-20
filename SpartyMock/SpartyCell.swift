//
//  SpartyCell.swift
//  SpartyMock
//
//  Created by David Colvin on 8/13/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class SpartyCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var sparty: Sparty! {
        didSet {
            
            self.titleLabel.text = sparty.title
            self.commentLabel.text = sparty.comment
            self.dateLabel.text = sparty.date.stringify()
            self.locationLabel.text = sparty.location.title
            
            let user = DataStore.sharedInstance.userForUserId(sparty.hostId)
            
            var hostString = "Hosted by You"
//
//            if sparty.isMySparty == false {
//                
                if let fullName = user?.fullName {
                    hostString = "Hosted by \(fullName)"
                }
//            }
            
            self.hostedLabel.text = hostString
            self.photoView.image = sparty.photo ?? user?.photo
//            self.guestStats.text = "\(sparty.invitedCount) Invited, \(sparty.goingCount) Going, \(sparty.checkedInCount) Checked In"
        }
    }

    @IBOutlet weak var photoView: RoundedImage!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var hostedLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var guestStats: UILabel!
    
    
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
