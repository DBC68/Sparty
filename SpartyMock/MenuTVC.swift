//
//  MenuTVC.swift
//  SpartyMock
//
//  Created by David Colvin on 8/14/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

protocol MenuItemsDelegate: class {
    func itemsSelected()
}

class MenuTVC: UITableViewController {
    
    var tableData:[[MenuItem]]!
    weak var delegate: MenuItemsDelegate?
    var navTitle:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTableData()

        self.navigationController!.lightNavBar()
        
        self.navigationItem.titleView = self.filterMenuButton()

    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadTableData()
        
        UIApplication.sharedApplication().statusBarStyle = .Default
    }
    
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let delegate = self.delegate {
            delegate.itemsSelected()
        }
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.LightContent
        
    }
    
    
    private func loadTableData() {
        var status = [MenuItem]()
        var ownership = [MenuItem]()
        
        for item in DataStore.sharedInstance.menuItems {
            
            switch item.section {
            case .Status:
                status.append(item)
            case .Ownership:
                ownership.append(item)
            }
        }
        
        self.tableData = [status, ownership]
    }
    
    @IBAction func refreshAction(sender: AnyObject) {
        
        DataStore.sharedInstance.resetMenuItems()
        self.tableView.reloadData()
        
        
    }
    
    @IBAction func doneAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    private func filterMenuButton() -> UIButton {
        
        let titleLabel = UILabel()
        titleLabel.text = self.navTitle
        titleLabel.font = UIFont.boldSystemFontOfSize(18)
        titleLabel.textColor = UIColor.primaryColor()
        titleLabel.sizeToFit()
        
        let arrow = UIImage(named: "arrowUp")!
        let arrowView: UIImageView = UIImageView(image: arrow)
        arrowView.tintColor = UIColor.primaryColor()
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
        
        button.addTarget(self, action: #selector(self.hideMenu), forControlEvents: .TouchUpInside)
        
        //Center in nav bar
        var buttonFrame = button.frame
        buttonFrame.size.width += 18
        button.frame = buttonFrame
        
        return button
    }
    
    @objc private func hideMenu() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.tableData.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        let menuItem = self.tableData[indexPath.section][indexPath.row]
        
        cell?.textLabel?.text = menuItem.title
        
        if menuItem.isSelected == true {
            cell?.accessoryType = .Checkmark
        } else {
            cell?.accessoryType = .None
        }
        
        return cell!
    }

    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let menuItem = self.tableData[indexPath.section][indexPath.row]
        menuItem.isSelected = !menuItem.isSelected
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


}
