//
//  ActivityTVC.swift
//  SpartyMock
//
//  Created by David Colvin on 8/3/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit
import Firebase

class ActivityTVC: UITableViewController, MenuItemsDelegate, UIViewControllerTransitioningDelegate, UISearchBarDelegate {
    
    let MenuSegue = "MENU_SEGUE"
    
    var tableData: [Activity]!
    
    let customPresentAnimationController = CustomPresentAnimationController()
    let customDismissAnimationController = CustomDismissAnimationController()
    
    //MARK: - View Lifecycle
    //--------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        let activities = DataStore.sharedInstance.activities
        self.tableData = activities.sort({$0.date.isGreaterThanDate($1.date)})
        self.tableView.tableFooterView = UIView()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80.0
        
        self.navigationItem.titleView = self.filterMenuButton()
        
        tabBarController?.tabBar.items?[2].badgeValue = "1"
        
//        let notificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
//        UIApplication.sharedApplication().registerUserNotificationSettings(notificationSettings)
//        
//        let notification = UILocalNotification()
//        notification.alertBody = "Kate Colvin invited you to the Sparty: Dance Party!"
//        notification.fireDate = NSDate().dateByAddingTimeInterval(10)
//        UIApplication.sharedApplication().scheduleLocalNotification(notification)
        
       

    }
    
    private func filterMenuButton() -> UIButton {
        
        let titleLabel = UILabel()
        titleLabel.text = "Activity"
        titleLabel.font = UIFont.boldSystemFontOfSize(18)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        
        let arrow = UIImage(named: "arrowDown")!
        let arrowView: UIImageView = UIImageView(image: arrow)
        var frame = arrowView.frame
        
        frame.origin.x = titleLabel.frame.size.width + 5
        frame.size = CGSizeMake(20, 20)
        arrowView.frame = frame
        
        let view = UIView()
        view.addSubview(titleLabel)
        view.addSubview(arrowView)
        
        let button = UIButton(type: .Custom)
        button.frame = titleLabel.frame
        button.addSubview(view)
        
        button.addTarget(self, action: #selector(self.showMenu), forControlEvents: .TouchUpInside)
        
        //Center in nav bar
        var buttonFrame = button.frame
        buttonFrame.size.width += 18
        button.frame = buttonFrame
        
        return button
    }
    
    @objc private func showMenu() {
        
        if let nav = UIStoryboard.loadNavFromStoryboard("MenuNav"),
            controller = nav.topViewController as? MenuTVC {
            controller.delegate = self
            controller.navTitle = "Filter Activities"
            nav.transitioningDelegate = self
            self.presentViewController(nav, animated: true, completion: nil)
        }
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? ActivityCell
    
        let activity = self.tableData[indexPath.row]
        cell?.activity = activity
        
        return cell!
    }
    
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    //MARK: - Menu Delegate
    //--------------------------------------------------------------------------
    func itemsSelected() {
        //Filter items
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customPresentAnimationController
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return customDismissAnimationController
    }
    
    //MARK: - Navigation
    //--------------------------------------------------------------------------
    @IBAction func unwindToActivities(segue: UIStoryboardSegue) { }

}