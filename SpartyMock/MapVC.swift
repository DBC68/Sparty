//
//  MapVC.swift
//  PetAlert
//
//  Created by David Colvin on 7/6/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//


import UIKit
import MapKit

let defaultSpanDelta = 0.005
let locationErrorMessage = "Your device's location services are disabled. Please go to Settings and allow \"While Using the App\" location access for Sparty."

class MapVC: UIViewController, MKMapViewDelegate, UIGestureRecognizerDelegate {
    
    //MARK - Outlets
    //--------------------------------------------------------------------------
    @IBOutlet weak var crosshairLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    //MARK - Properties
    //--------------------------------------------------------------------------
    var parent: LocationVC {
        return self.parentViewController as! LocationVC
    }
    
    var selectedLocation:Location? {
        didSet {
            self.selectButton.enabled = true
        }
    }
    
    var previousLocation:Location?

    //MARK - View LiveCycle
    //--------------------------------------------------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMapView()
        zoomToDefaultCoordinate()
        
        self.selectButton.sizeToFit()
        self.selectButton.enabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK - Setup
    //--------------------------------------------------------------------------
    private func setupMapView(){
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        self.mapView.mapType = NSUserDefaults.mapType()
        
        let mapDragRecognizer = UIPanGestureRecognizer(target: self, action: #selector(MapVC.didDragMap))
        mapDragRecognizer.delegate = self
        self.mapView.addGestureRecognizer(mapDragRecognizer)
    }
    
    func zoomToDefaultCoordinate() {
        
        if let coordinate = DataStore.sharedInstance.defaultCoordinate where coordinate.isNotEmpty() {
            zoomToCoordinate(coordinate)
            reverseGeocodeCoordinate(coordinate)
        }
        else {
            self.addressLabel.text = locationErrorMessage
            self.addressLabel.textColor = UIColor.secondColor()
        }
    }
    
    //MARK: - Gestures
    //--------------------------------------------------------------------------
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func didDragMap(gestureRecognizer: UIGestureRecognizer) {
        if (gestureRecognizer.state == UIGestureRecognizerState.Began) {
            //            print("Map drag began")
            NSObject.cancelPreviousPerformRequestsWithTarget(self, selector: #selector(MapVC.reverseGeocodeCoordinate), object: nil)
        }
        
        if (gestureRecognizer.state == UIGestureRecognizerState.Ended) {
            //            print("Map drag ended")
            performSelector(#selector(MapVC.reversegeocodeCurrentLocation), withObject: nil, afterDelay: 0.2)
        }
    }
    
    func reversegeocodeCurrentLocation() {
        reverseGeocodeCoordinate(self.mapView.centerCoordinate)
    }

    

    //MARK - Location Manager
    //--------------------------------------------------------------------------
    func zoomToCoordinate(coordinate:CLLocationCoordinate2D) {
        
        if coordinate.isNotEmpty() {
            let latitude = coordinate.latitude
            let longitude = coordinate.longitude
            let latDelta = CLLocationDegrees(defaultSpanDelta)
            let lonDelta = CLLocationDegrees(defaultSpanDelta)
            let span = MKCoordinateSpanMake(latDelta, lonDelta)
            let location = CLLocationCoordinate2DMake(latitude, longitude)
            let region = MKCoordinateRegionMake(location, span)
            self.mapView.setRegion(region, animated: false)
        }
    }
    
    //MARK: - Geocoding
    //--------------------------------------------------------------------------
    func reverseGeocodeCoordinate(coordinate:CLLocationCoordinate2D) {
        
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler:
            {(placemarks, error) in
                
                if error != nil {
                    print("Reverse geocoder failed with error" + error!.localizedDescription)
                    return
                }
                
                if let pm = placemarks {
                    if pm.count > 0 {
                        let newLocation = Location(coordinate: coordinate, placemark: pm.first!)
                        self.addressLabel.text = newLocation.address
                        self.addressLabel.textColor = UIColor.darkTextColor()
                        
                        self.selectedLocation = newLocation
                        
                        if let previous = self.previousLocation {
                            if previous.sameAs(newLocation) == false {
                                self.flashText()
                            }
                        }
                        
                        self.previousLocation = self.selectedLocation
                    }
                }
                else {
                    print("Problem with the data received from geocoder")
                }
        })
    }
    
    func flashText(){
        
        self.addressLabel.alpha = 0.0
        UIView.animateWithDuration(0.75, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.addressLabel.alpha = 1.0
            }, completion: nil)
        
    }
    
    func locateUser() {
        if CLLocationManager.authorizationStatus() == .AuthorizedWhenInUse {
            zoomToCoordinate(self.mapView.userLocation.coordinate)
            reverseGeocodeCoordinate(self.mapView.userLocation.coordinate)
        }
        else {
            self.addressLabel.text = locationErrorMessage
            self.addressLabel.textColor = UIColor.errorColor()
        }
    }
    
    func showStandardMap() {
        self.crosshairLabel.textColor = UIColor.blackColor()
        self.mapView.mapType = .Standard
    }
    
    func showSatelliteMap() {
        self.crosshairLabel.textColor = UIColor.whiteColor()
        self.mapView.mapType = .Satellite
    }
    
    //MARK: - Actions
    //--------------------------------------------------------------------------
    @IBAction func locateAction(sender: AnyObject) {
        self.locateUser()
    }
    
    @IBAction func mapType(sender: AnyObject) {
        
        let alertController = UIAlertController(title: nil, message: "Change Map Type", preferredStyle: .ActionSheet)
        
        alertController.view.tintColor = UIColor.alertTextColor()
        
        let action1 = UIAlertAction(title: "Standard", style: .Default) { (action) in
            self.showStandardMap()
        }
        
        alertController.addAction(action1)
        
        let action2 = UIAlertAction(title: "Satellite", style: .Default) { (action) in
            self.showSatelliteMap()        }
        
        alertController.addAction(action2)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    @IBAction func selectAction(sender: AnyObject) {
        
        guard let location = self.selectedLocation else { return }
        
        self.parent.selectLocation(location)
    }
}
