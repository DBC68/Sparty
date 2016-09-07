//
//  ControllerFactory.swift
//  SpartyMock
//
//  Created by David Colvin on 8/19/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

enum StoryboardID {
    case FriendRequestVC
    case FriendVC
    case MenuTVC
}

class ControllerFactory: NSObject {
    
    private static let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)

    static func controller(id: StoryboardID) -> AnyObject {
        
        switch id {
        case .FriendRequestVC:
            return mainStoryboard.instantiateViewControllerWithIdentifier("FriendRequestVC") as! FriendRequestVC
        case .FriendVC:
            return mainStoryboard.instantiateViewControllerWithIdentifier("FriendVC") as! FriendVC
        case .MenuTVC:
            return mainStoryboard.instantiateViewControllerWithIdentifier("MenuNav") as! UINavigationController
        }
    }
    
    class func test() {
        
        let controller = ControllerFactory.controller(.FriendVC) as? FriendVC
        
        print (controller)
    }
    
}
