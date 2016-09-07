//
//  FriendsTVC.swift
//  SpartyMock
//
//  Created by David Colvin on 8/5/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class FriendsTVC: UITableViewController, UISearchBarDelegate, FriendUpdateDelegate {

//    @IBOutlet weak var searchBar: UISearchBar!
    
    var tableData = [[Friend]]()
    var titles = ["Recent", "Invites", "Friends"]
    var selectedFriend: Friend!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50.0
        
        tabBarController?.tabBar.items?[2].badgeValue = nil
        
        loadFriends()

    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
//        cancelSearchBar()
    }
    
    private func loadFriends() {
        let friends = DataStore.sharedInstance.friends
        
        let invites = friends.filter({$0.status == .Invite})
        let recent = friends.filter({$0.status == .Recent})
        let current = friends.filter({$0.status == .Friend})
        
        self.tableData = [recent, invites, current]
    }
    
    
    //MARK: - TableView
    //--------------------------------------------------------------------------
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.tableData.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData[section].count
    }
    

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return self.tableData[section].count > 0 ? 30 : 0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return self.tableData[section].count > 0 ? self.titles[section] : nil
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return nil
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? FriendCell

        cell?.friend = self.tableData[indexPath.section][indexPath.row]
        
        return cell!
    
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedFriend = self.tableData[indexPath.section][indexPath.row]
        self.performSegueWithIdentifier("FRIEND_SEGUE", sender: self)
    }
    
    //MARK: - Navigation
    //--------------------------------------------------------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as? FriendVC
        controller?.friend = self.selectedFriend
        controller?.delegate = self
    }
    
    @IBAction func addFriendsAction(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Add Friends", message: "How would you like to add friends?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Search Sparty Users", style: .Default, handler: { (action) in
            self.view.endEditing(true)
            
        }))
        
        alertController.addAction(UIAlertAction(title: "From Contacts", style: .Default, handler: { (action) in
            self.view.endEditing(true)
            
        }))
        alertController.addAction(UIAlertAction(title: "From Faceook", style: .Default, handler: { (action) in
            self.view.endEditing(true)
            
        }))
        alertController.addAction(UIAlertAction(title: "By Email", style: .Default, handler: { (action) in
            self.view.endEditing(true)
            
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler:nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: - FriendCellDelegate
    //--------------------------------------------------------------------------
    func friendUpdated() {
        
        loadFriends()
        self.tableView.reloadData()
    }

}
