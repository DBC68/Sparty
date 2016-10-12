//
//  FriendRequestVC.swift
//  SpartyMock
//
//  Created by David Colvin on 8/19/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class FriendRequestVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Properties
    //--------------------------------------------------------------------------
    var tableData = [User]()

    //MARK: - Outlets
    //--------------------------------------------------------------------------
    @IBOutlet weak var screenNameField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!
    
    //MARK: - View Lifecycle
    //--------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.lightNavBar()
        self.tableView.tableFooterView = UIView()
        self.searchButton.state(false)
        self.searchButton.backgroundColor = UIColor.primaryColor()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.screenNameField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - TableView
    //--------------------------------------------------------------------------
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? FriendRequestCell
        
        cell?.user = self.tableData[indexPath.row]
        
        return cell!
    }

    
    //MARK: - Actions
    //--------------------------------------------------------------------------
    @IBAction func textDidChange(sender: UITextField) {
        self.searchButton.state(sender.text?.characters.count >= Constants.MinSearchCharacters)
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func searchAction(sender: AnyObject) {
        if let seachString = self.screenNameField.text {
            FirebaseManager.search(forScreenName: seachString, completion: { (foundUsers) in
                self.tableData = foundUsers
                self.tableView.reloadData()
            })
        }
    }
}
