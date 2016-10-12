//
//  SpartiesTVC.swift
//  SpartyMock
//
//  Created by David Colvin on 8/6/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

class SpartiesTVC: UITableViewController, MenuItemsDelegate, UIViewControllerTransitioningDelegate, UISearchBarDelegate, NewSpartyDelegate {
    
    enum Segues: String {
        case Menu = "MENU_SEGUE"
        case MySparty = "MY_SPARTY_SEGUE"
        case OverSparty = "OVER_SPARTY_SEGUE"
        case ActiveSparty = "ACTIVE_SPARTY_SEGUE"
        case NewSparty = "NEW_SPARTY_SEGUE"
    }

    //MARK: - Outlets
    //--------------------------------------------------------------------------
//    @IBOutlet weak var searchBar: UISearchBar!

    //MARK: - Properties
    //--------------------------------------------------------------------------
    var tableData = [[Sparty]]()
    
    var scrolled = false
    
    let sectionTitles = ["My Sparties", "Invites", "Over"]
    
    let customPresentAnimationController = CustomPresentAnimationController()
    let customDismissAnimationController = CustomDismissAnimationController()
    
    //MARK: - View Life Cycle
    //--------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadSparties()
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100.0
    
        self.navigationItem.titleView = self.filterMenuButton()

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
//        cancelSearchBar()
    }
    
    private func loadSparties() {
        let sparties = DataStore.sharedInstance.sparties.sort({$0.date.isGreaterThanDate($1.date)})
        
        let mySparties = sparties.filter({$0.isMySparty == true})
        
        let invites = sparties.filter({$0.isMySparty == false})
        
        let comingUp = invites.filter({$0.isPending == true})
        let over = invites.filter({$0.isOver == true})
        
        self.tableData = [mySparties, invites]
        
    }
    
    //MARK: - Filter
    //--------------------------------------------------------------------------
    private func filterMenuButton() -> UIButton {
        
        let titleLabel = UILabel()
        titleLabel.text = "Sparties"
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
            controller.navTitle = "Filter Sparties"
            nav.transitioningDelegate = self
            self.presentViewController(nav, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func newSpartyAction(sender: AnyObject) {
        
        self.performSegueWithIdentifier(Segues.NewSparty.rawValue, sender: self)
    }
    
    //MARK: - Table View
    //--------------------------------------------------------------------------
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.tableData.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData[section].count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as? SpartyCell
        
        let sparty = self.tableData[indexPath.section][indexPath.row]
        
        cell?.sparty = sparty
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.tableData[section].count > 0 ? self.sectionTitles[section] : ""
    }
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.tableData[section].count > 0 ? 30 : 0.1
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let sparty = self.tableData[indexPath.section][indexPath.row]
        
        if sparty.isMySparty {
            self.performSegueWithIdentifier(Segues.MySparty.rawValue, sender: self)
        } else {
            self.performSegueWithIdentifier(Segues.ActiveSparty.rawValue, sender: self)
        }
        
    }
    
    
    //MARK: - Navigation
    //--------------------------------------------------------------------------
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        guard let id = Segues(rawValue: segue.identifier!) else { return }
        
        switch id {
            
        case .NewSparty:
            
            if let nav = segue.destinationViewController as? UINavigationController,
                controller = nav.topViewController as? NewSpartyTVC {
                controller.delegate = self
            }
        default:
            break
        }
    }
    
    func newSpartyCreated() {
//        loadSparties()
        
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
    
//    //MARK: - Search Bar Delegate
//    //--------------------------------------------------------------------------
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//        cancelSearchBar()
//    }
//    
//    private func cancelSearchBar () {
//        self.tableView.setContentOffset(CGPointMake(0, -20), animated: true)
//        self.searchBar.resignFirstResponder()
//    }
}
