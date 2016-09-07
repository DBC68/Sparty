//
//  Titleable.swift
//  DynamicTableView
//
//  Created by David Colvin on 6/12/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation

protocol Titleable {
    
    func title() -> String
    
    func data() -> AnyObject
    
}