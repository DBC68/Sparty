//
//  InviteTVC.swift
//  SpartyMock
//
//  Created by David Colvin on 8/7/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class InviteTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.estimatedRowHeight = 200.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    @IBAction func mapAction(sender: AnyObject) {

        let coordinate = CLLocationCoordinate2DMake(47.658938,-122.3151217)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = "Chili's Bar & Grill"
        mapItem.openInMapsWithLaunchOptions([MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
}
