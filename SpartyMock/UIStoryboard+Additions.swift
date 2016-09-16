//
//  UIViewController+Additions.swift
//  Sparty
//
//  Created by David Colvin on 9/8/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import UIKit

extension UIStoryboard {
    
//    static let RegisterNavID = "RegisterNav"
    
    static func loadFromStoryboard<T>(hasNav:Bool = false) -> T? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let id = String(T.self)
        return storyboard.instantiateViewControllerWithIdentifier(id) as? T
    }
    
    static func loadNavFromStoryboard(id:String) -> UINavigationController? {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewControllerWithIdentifier(id) as? UINavigationController
    }
}