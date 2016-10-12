//
//  FriendsTVC.swift
//  SpartyMock
//
//  Created by David Colvin on 8/5/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit
import Firebase

class FriendsTVC: UITableViewController {
    
    //MARK: - Properties
    //--------------------------------------------------------------------------
    var _tableData: [[String]]!
    var _titles = ["Invites", "Friends"]
    var _selectedFriend: Friend!
    var _invites = [String]()
    var _friends = [String]()
    
    //MARK: - View LifeCycle
    //--------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _tableData = [_invites, _friends]
        
        setupUI()
        
        observeInvites()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    private func setupUI() {
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50.0
    }
    
    //MARK: - TableView
    //--------------------------------------------------------------------------
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return _tableData.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _tableData[section].count
    }
    

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return _tableData[section].count > 0 ? 30 : 0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return _tableData[section].count > 0 ? _titles[section] : nil
    }
    
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return nil
    }
    
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? FriendCell

        cell?.configure(_tableData[indexPath.section][indexPath.row])
        
        return cell!
    
    }
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
////        self.selectedFriend = self.tableData[indexPath.section][indexPath.row]
//        self.performSegueWithIdentifier("FRIEND_SEGUE", sender: self)
//    }
    
    //MARK: - Navigation
    //--------------------------------------------------------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let controller = segue.destinationViewController as? FriendVC
        controller?.friend = _selectedFriend
    }
    
    @IBAction func addFriendsAction(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "Add Friends", message: "How would you like to add friends?", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Search Sparty Users", style: .Default, handler: { (action) in
            self.view.endEditing(true)
            
            let storyboard = UIStoryboard(name: "FriendRequest", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("FriendRequestNav") as! UINavigationController
            self.presentViewController(vc, animated: true, completion: nil)
            
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
    
    /*
     You need to observer the requests which returns the uid of the person who sent the request.  Store this value as a string in self.invites.  Then pass this string to the FriendCell.  In friend cell you need to observe changes in the user record.
 */
    
    func observeInvites() {
    
        let path = FirebaseManager.ref.child(Node.Requests).child(FirebaseManager.user!.uid)
        path.observeEventType(.Value, withBlock: { snapshot in
            
            guard snapshot.exists() else { return }
            
            if let child = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in child {
                    self._invites.insert(snap.key, atIndex: 0)
                }
                self._tableData[0] = self._invites
                self.tableView.reloadData()
            }
        })
    }
}
