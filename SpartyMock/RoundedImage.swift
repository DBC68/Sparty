//
//  RoundedImage.swift
//  SpartyMock
//
//  Created by David Colvin on 8/6/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class RoundedImage: UIImageView {

    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)!
        
        let width = self.frame.size.width
        
        self.layer.cornerRadius = width/2
        self.layer.borderColor = UIColor.lightGrayColor().CGColor
        self.layer.borderWidth = 0.5
        self.clipsToBounds = true
    }
    
}
