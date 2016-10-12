//
//  FriendVC.swift
//  SpartyMock
//
//  Created by David Colvin on 8/6/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class FriendVC: UIViewController {

    @IBOutlet weak var photoView: RoundedImage!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var rankingLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screenNameLabel: UILabel!
    @IBOutlet weak var mottoLabel: UILabel!
    @IBOutlet weak var vipSwitch: UISwitch!
    @IBOutlet weak var actionStack: UIStackView!
    @IBOutlet weak var vipLabel: UILabel!
    @IBOutlet weak var unfriendButton: UIButton!
    @IBOutlet weak var crownLabel: UILabel!
    
    var friend: Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        guard let user = DataStore.sharedInstance.userForUserId(friend.userId) else { return }
//        
//        self.photoView.image = user.photo
//        self.pointsLabel.text = "\(Int(user.score)) points"
//        self.rankingLabel.text = "\(self.friend.ranking)"
//        self.creditsLabel.text = "\(Int(user.credits)) credits"
//        self.nameLabel.text = user.fullName
//        self.screenNameLabel.text = user.screenName
//        self.mottoLabel.text = user.motto
//        
//        if self.friend.status == .Invite {
//            self.actionStack.hidden = false
//            self.unfriendButton.hidden = true
//        } else {
//            self.actionStack.hidden = true
//            self.unfriendButton.hidden = false
//        }
        
        self.vipSwitch.setOn(self.friend.isVIP, animated: true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func vipAction(sender: UISwitch) {
        self.friend.isVIP = (sender.on == true)
    }
    
    @IBAction func unfriendAction(sender: AnyObject) {

        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Unfriend", message: "Are you sure?", preferredStyle: .Alert)
        
        let cancelActionButton: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            print("Cancel")
        }
        
        
        let saveActionButton: UIAlertAction = UIAlertAction(title: "Yes", style: .Default)
        { action -> Void in
//            self.friend.status = .Rejected
            self.navigationController?.popViewControllerAnimated(true)
        }
        
        actionSheetControllerIOS8.addAction(saveActionButton)
        actionSheetControllerIOS8.addAction(cancelActionButton)

        self.presentViewController(actionSheetControllerIOS8, animated: true, completion: nil)
    }

    @IBAction func acceptAction(sender: AnyObject) {
        
//        self.friend.status = .Recent
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func denyAction(sender: AnyObject) {
        
//        self.friend.status = .Rejected}
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
