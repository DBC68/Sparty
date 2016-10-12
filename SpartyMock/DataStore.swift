//
//  DataStore.swift
//  SpartyMock
//
//  Created by David Colvin on 8/13/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation
import CoreLocation

struct PlistNames {
    static let Users = "Users"
    static let Actions = "Actions"
    static let Activities = "Activities"
    static let Sparties = "Sparties"
    static let Guests = "Guests"
    static let Friends = "Friends"
}

class DataStore {
    
    static let sharedInstance: DataStore = DataStore()
    
    var user: User? //Logged in user
    
    var users = [User]()
    var friends = [Friend]()
    var activities = [Activity]()
    var actions = [Action]()
    var sparties = [Sparty]()
    var guests = [Guest]()
    var tags = [Tag]()
    var menuItems: [MenuItem]!
    var defaultCoordinate:CLLocationCoordinate2D?
    var units: Units = Units.Imperial
    
    var score = 0
    var credits: Int {
        return score/10
    }
    
    init() {
        if let user = FirebaseManager.user {
            FirebaseManager.loadUser(user.uid) { (result) in
                self.user = result
            }
        }
    }
    
    //MARK: - Users
    //--------------------------------------------------------------------------
    private func loadUsers() {
        
        self.users.removeAll()
        
        if let path = NSBundle.mainBundle().pathForResource(PlistNames.Users, ofType: "plist"),
            array = NSArray(contentsOfFile: path) as? [[String:AnyObject]] {
            
            for dict in array {
                
                let user = User(dict: dict)
                self.users.append(user!)
            }
        } else {
            abort()
        }
        
    }
    
    func userForUserId(userId: String) -> User? {
        for user in self.users {
            if user.uid == userId {
                return user
            }
        }
        return nil
    }
    
    
    // MARK: - Activities
    //--------------------------------------------------------------------------
    private func loadActivities() {
        
        self.activities.removeAll()
        
        if let path = NSBundle.mainBundle().pathForResource(PlistNames.Activities, ofType: "plist"),
            array = NSArray(contentsOfFile: path) as? [[String:AnyObject]] {
            
            for dict in array {
                
                let activity = Activity(dict: dict)
                self.activities.append(activity)
            }
        } else {
            abort()
        }
        
    }
    
    //MARK: - Actions
    //--------------------------------------------------------------------------
    private func loadActions() {
        
        self.actions.removeAll()
        
        if let path = NSBundle.mainBundle().pathForResource(PlistNames.Actions, ofType: "plist"),
            array = NSArray(contentsOfFile: path) as? [[String:AnyObject]] {
            
            for dict in array {
                
                let action = Action(dict: dict)
                self.actions.append(action)
            }
        } else {
            abort()
        }
    }
    
    func actionForActionId(actionId: Action.ID) -> Action? {
        for action in self.actions {
            if action.id == actionId {
                return action
            }
        }
        return nil
    }

    //MARK: - Sparties
    //--------------------------------------------------------------------------
    private func loadSparties() {
        
        self.sparties.removeAll()
        
        if let path = NSBundle.mainBundle().pathForResource(PlistNames.Sparties, ofType: "plist"),
            array = NSArray(contentsOfFile: path) as? [[String:AnyObject]] {
            
            for dict in array {
                
                let sparty = Sparty.spartyForPlistDictionary(dict)
                self.sparties.append(sparty)
            }
        } else {
            abort()
        }
    }
    
    func spartyForSpartyId(spartyId: String) -> Sparty? {
        for sparty in self.sparties {
            if sparty.spartyId == spartyId {
                return sparty
            }
        }
        return nil
    }
    
    //MARK: - Guests
    //--------------------------------------------------------------------------
    private func loadGuests() {
        
        self.guests.removeAll()
        
        if let path = NSBundle.mainBundle().pathForResource(PlistNames.Guests, ofType: "plist"),
            array = NSArray(contentsOfFile: path) as? [[String:AnyObject]] {
            
            for dict in array {
                
                let guest = Guest(dict: dict)
                self.guests.append(guest)
            }
        } else {
            abort()
        }
    }
    
    //MARK: - Tags
    //--------------------------------------------------------------------------
    func tagsForUserId(userId: String) -> [Tag] {
        return self.tags.filter({$0.userId == userId})
    }
    
    //MARK: - Menu Items
    //--------------------------------------------------------------------------
    private func loadMenuItems() {
        
        let firstTitles = ["Active", "Coming Up", "Over"]
        let secondTitles = ["My Sparties", "Invitations"]
        var firstSection = [MenuItem]()
        var secondSection = [MenuItem]()
        
        for title in firstTitles {
            firstSection.append(MenuItem(title: title, section: .Status))
        }
        
        for title in secondTitles {
            secondSection.append(MenuItem(title: title, section: .Ownership))
        }
        
        self.menuItems = firstSection + secondSection
    }
    
    func resetMenuItems() {
        for item in DataStore.sharedInstance.menuItems {
            item.isSelected = true
        }
    }
}
