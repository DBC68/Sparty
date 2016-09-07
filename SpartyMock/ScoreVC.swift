//
//  ScoreVC.swift
//  SpartyMock
//
//  Created by David Colvin on 8/20/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class ScoreVC: UIViewController {
    
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var photoView: RoundedImage!
    @IBOutlet weak var mottoLabel: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let user = DataStore.sharedInstance.userForUserId("man0")

//        self.creditLabel.text = "\(user!.credits)"
//        self.scoreLabel.text = "\(user!.score)"
//        self.rankingLabel.text = user!.rankString
        self.nameLabel.text = user?.fullName
        self.screenNameLabel.text = user?.screenName
        self.photoView.image = user?.photo
        self.mottoLabel.text = user?.motto
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
