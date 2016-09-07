//
//  Action.swift
//  SpartyMock
//
//  Created by David Colvin on 8/18/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit


class Action {
    
    enum ID: Int {
        case FriendRequest = 0
        case RequestAccepted = 1
        
        case SpartyInvite = 2
        
        case SpartyRSVPYes = 3
        case SpartyRSVPNo = 4
        case SpartyRSVPMaybe = 5
        case InviteUser = 6
        case FirstTimeUser = 7
        case CheckIn = 8
        case Advertisement = 9
    }
    
    enum Seque: String {
        case SpartyInvite = "SPARTY_INVITE_SEGUE"
    }
    
    enum Calculation: Int {
        case Points = 0
        case Percent = 1
        case None = 2
    }
    
    //MARK: - Properties
    //--------------------------------------------------------------------------
    var id: ID!
    var title: String!
    var comment: String!
    var calculation: Calculation!
    var value: Double!
    var actionString: String!

    
    //MARK: - Initializers
    //--------------------------------------------------------------------------
    init(dict:[String:AnyObject]) {
        
        guard let id = dict["id"] as? Int,
            title = dict["title"] as? String,
            comment = dict["comment"] as? String,
            calculation = dict["calculation"] as? Int,
            value = dict["value"] as? Double,
            actionString = dict["actionString"] as? String else {
                abort()
        }
        
        self.id = ID(rawValue: id)
        self.title = title
        self.comment = comment
        self.calculation = Calculation(rawValue: calculation)
        self.value = value
        self.actionString = actionString
    }

    
}
