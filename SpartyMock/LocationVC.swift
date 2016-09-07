//
//  LocationVC.swift
//  PetAlert
//
//  Created by David Colvin on 7/6/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

enum ViewMode {
    case Search
    case Map
    
    static func valueForInt(index:Int) -> ViewMode? {
        switch index {
        case 0:
            return .Search
        case 1:
            return .Map
        default:
            break
        }
        
        return nil
    }
    
    static func IntForValue(value:ViewMode) -> Int? {
        
        switch value {
        case .Search:
            return 0
        case .Map:
            return 1
        }
    }
}

class LocationVC: UIViewController {
    
    //MARK: - Properties
    //--------------------------------------------------------------------------
    var currentCoordinate:CLLocationCoordinate2D!
    var selectedLocation:Location?
    var previousLocation: Location?
    var cellDescriptor:CellDescriptor!
    var toolbarButtons: [UIBarButtonItem]?
    var mapVC: MapVC {
        return self.childViewControllers.last as! MapVC
    }
    
    //MARK: - Outlets
    //--------------------------------------------------------------------------
    @IBOutlet weak var viewModeButton: UIBarButtonItem!
    @IBOutlet weak var searchContainer: UIView!
    @IBOutlet weak var mapContainer: UIView!
    
    //MARK: - View LifeCycle
    //--------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewMode(DataStore.sharedInstance.viewMode)
        
        self.navigationController!.lightNavBar()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Setup
    //--------------------------------------------------------------------------    
    func setViewMode(mode:ViewMode) {
        
        switch mode {
        case .Search:
            self.viewModeButton.image = UIImage(named: "map")
            self.mapContainer.hidden = true
            self.searchContainer.hidden = false
        case .Map:
            self.viewModeButton.image = UIImage(named: "search")
            self.searchContainer.hidden = true
            self.mapContainer.hidden = false
            self.mapVC.zoomToDefaultCoordinate()
        }
        
        DataStore.sharedInstance.viewMode = mode
    }
    
    //MARK: - Actions
    //--------------------------------------------------------------------------
    @IBAction func cancelAction(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func viewModeAction(sender: AnyObject) {
        
        if DataStore.sharedInstance.viewMode == .Search {
            DataStore.sharedInstance.viewMode = .Map
        } else {
            DataStore.sharedInstance.viewMode = .Search
        }
        
        setViewMode(DataStore.sharedInstance.viewMode)
    }
    
    func selectLocation(location:Location) {
        
        DataStore.sharedInstance.defaultCoordinate = location.coordinate
        
        self.cellDescriptor.value = location
        self.cellDescriptor.subtitle = location.title
        NSNotification.selectionCallback(self.cellDescriptor)
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
}
