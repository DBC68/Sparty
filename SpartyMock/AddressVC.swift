//
//  AddressVC.swift
//  PetAlert
//
//  Created by David Colvin on 7/6/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit
import MapKit

class AddressVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    //MARK: - Properties
    //--------------------------------------------------------------------------
    var tableData = [MKMapItem]()
    var currentCoordinate: CLLocationCoordinate2D!
    var parent: LocationVC {
        return self.parentViewController as! LocationVC
    }
    var selectedLocation:Location!

    //MARK: - Outlets
    //--------------------------------------------------------------------------
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - Search
    //--------------------------------------------------------------------------
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.performSearch(searchBar.text!.trim())
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        self.tableData.removeAll()
        self.tableView.reloadData()
        return true
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchBar.resignFirstResponder()
        self.tableData.removeAll()
        self.tableView.reloadData()
    }
    
    func performSearch(query: String) {
        
        let request: MKLocalSearchRequest = MKLocalSearchRequest()
        request.naturalLanguageQuery = query
        
        let search: MKLocalSearch = MKLocalSearch(request: request)
        
        search.startWithCompletionHandler { (response, error) in
            
            guard let addresses = response else {return}
            
            guard error == nil else {
                self.showInternetError(error!)
                return
            }
            
            if addresses.mapItems.count > 0 {
                self.tableData = addresses.mapItems
                self.tableView.reloadData()
            }
        }
    }
    
    private func showInternetError(error:NSError) {
        var title = "Internet Connection Error"
        var message = "Make sure your device is connected to the Internet and try again."
        
        switch error.code {
        case -1001:
            title = "Timeout Error"
            message = "The call to the server has timed out.  Please try again."
        default:
            break
            
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.view.tintColor = UIColor.alertTextColor()
        alertController.addAction(UIAlertAction(title: "OK", style: .Cancel, handler:nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    //MARK: - Table View
    //--------------------------------------------------------------------------
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let mapItem = self.tableData[indexPath.row]
        self.currentCoordinate = mapItem.coordinateForMapItem()
        
        cell.textLabel!.text = mapItem.titleForMapItem()
        cell.detailTextLabel!.text = mapItem.subtitleForMapItem()
        cell.accessoryType = .None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        clearCheckmarks()
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        cell.accessoryType = .Checkmark
        cell.tintColor = UIColor.primaryColor()
        
        let mapItem = self.tableData[indexPath.row]
        self.selectedLocation = Location(mapItem: mapItem)
        performSelector(#selector(self.selectLocation), withObject: nil, afterDelay: 0.3)
        
    }
    
    @objc private func selectLocation() {
        self.parent.selectLocation(self.selectedLocation)
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func clearCheckmarks() {
        
        for (i, _) in self.tableData.enumerate() {
            let indexPath = NSIndexPath(forRow: i, inSection: 0)
            let cell = self.tableView.cellForRowAtIndexPath(indexPath)
            cell!.accessoryType = .None
        }
    }


}
