//
//  ActivityCell.swift
//  SpartyMock
//
//  Created by David Colvin on 8/13/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var pointsCell: UILabel!
    
    var activity: Activity! {
        didSet {
            self.activityLabel.text = activity.activityText()
            self.dateLabel.text = activity.date.stringify()
            self.pointsCell.text = activity.pointsText()
            
            if let photo = activity.photo() {
                self.photoView.image = photo
            }
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
    
}
