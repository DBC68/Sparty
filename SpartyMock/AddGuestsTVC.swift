//
//  AddGuestsTVC.swift
//  SpartyMock
//
//  Created by David Colvin on 8/20/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class AddGuestsTVC: UITableViewController {
    
    //MARK - Properties
    //--------------------------------------------------------------------------
    var cellDescriptor:CellDescriptor!
    var friends: [Friend]!
    var checked: [Bool]!
    var tags = [Tag]()
    
    var user = DataStore.sharedInstance.user

    //MARK - View Lifecycle
    //--------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.friends = DataStore.sharedInstance.friends
        self.checked = [Bool](count: friends.count, repeatedValue: false)
        checkVIPs()
        loadTags()
        
        self.tableView.tableFooterView = UIView()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        NSNotification.selectionCallback(self.cellDescriptor)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Setup
    //--------------------------------------------------------------------------
    private func loadTags() {
        
        let allTag = Tag(name: "All", userId: self.user.userId)
        let noneTag = Tag(name: "None", userId: self.user.userId)
        let vipsTag = Tag(name: "VIPs", userId: self.user.userId)
        
        self.tags = [allTag, noneTag, vipsTag] + DataStore.sharedInstance.tagsForUserId(self.user.userId)
    }

    //MARK - TableView
    //--------------------------------------------------------------------------
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.friends.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        let friend = self.friends[indexPath.row]
        if let user = DataStore.sharedInstance.userForUserId(friend.userId) {
            cell.textLabel?.text = user.fullName + (friend.isVIP == true ? " 👑" : "")
            cell.detailTextLabel?.text = "\(user.credits) credits"
        }
        
        //configure you cell here.
        if !checked[indexPath.row] {
            cell.accessoryType = .None
        } else if checked[indexPath.row] {
            cell.accessoryType = .Checkmark
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            if cell.accessoryType == .Checkmark {
                cell.accessoryType = .None
                checked[indexPath.row] = false
            } else {
                cell.accessoryType = .Checkmark
                checked[indexPath.row] = true
            }
        }
        
        self.cellDescriptor.subtitle = checkCount() > 0 ? "Selected (\(checkCount()))" : "None"
    }
    
    //MARK - Checks
    //--------------------------------------------------------------------------
    func checkAll() {
        self.checked = [Bool](count: friends.count, repeatedValue: true)
        self.cellDescriptor.subtitle = "All (\(checkCount()))"
    }
    
    func clearAll() {
        self.checked = [Bool](count: friends.count, repeatedValue: false)
        self.cellDescriptor.subtitle = "None"
    }
    
    func checkVIPs () {
        for (i, friend) in self.friends.enumerate() {
            self.checked[i] = friend.isVIP
        }
        self.cellDescriptor.subtitle = "VIPs (\(checkCount()))"
    }
    
    func checkCount () -> Int {
        return self.checked.filter({$0 == true}).count
    }
    
    //MARK: - Actions
    //--------------------------------------------------------------------------
    @IBAction func checkAllAction(sender: AnyObject) {
        checkAll()
        self.tableView.reloadData()
    }
    
    @IBAction func clearAllAction(sender: AnyObject) {
        clearAll()
        self.tableView.reloadData()
    }
    
    @IBAction func checkVIPsAction(sender: AnyObject) {
        checkVIPs()
        self.tableView.reloadData()
    }

}


