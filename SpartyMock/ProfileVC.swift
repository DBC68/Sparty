//
//  ProfileVC.swift
//  SpartyMock
//
//  Created by David Colvin on 8/20/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {
    
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var mottoLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _ = ProfileVM(controller: self)
    }
}
