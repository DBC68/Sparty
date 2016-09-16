//
//  AppState.swift
//  Sparty
//
//  Created by David Colvin on 9/11/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation

class AppState: NSObject {
    
    private struct Key {
        static let IsRegistered = "AppStateIsRegistered"
        static let Units = "AppStateUnits"
        static let Photo = "AppStatePhoto"
        static let ScreenName = "AppStateScreenName"
        static let Motto = "AppStateMotto"
    }
    
    
    //MARK:  - Properties
    //--------------------------------------------------------------------------
    
//    static var isRegistered = false
//    
//    static var screenName: String? {
//        set {
//            if screenName != nil {
//                NSUserDefaults.saveString(screenName!, forKey: Key.ScreenName)
//            }
//        }
//        get {
//            if let screenName = NSUserDefaults.loadStringForKey(Key.ScreenName) {
//                return screenName
//            } else {
//                return nil
//            }
//        }
//    }
//    
//    static var motto: String? {
//        set {
//            if motto != nil {
//                NSUserDefaults.saveString(motto!, forKey: Key.Motto)
//            }
//        }
//        get {
//            if let motto = NSUserDefaults.loadStringForKey(Key.Motto) {
//                return motto
//            } else {
//                return nil
//            }
//        }
//    }
//    
//    static var units: Units? {
//        set {
//            if units != nil {
//                NSUserDefaults.saveInteger(units!.rawValue, forKey: Key.Units)
//            }
//        }
//        get {
//            if let units = NSUserDefaults.loadIntegerForKey(Key.Units) {
//                return Units(rawValue: units)
//            } else {
//                return .Imperial
//            }
//        }
//    }
// 
//    static var photo: UIImage? {
//        set {
//            if photo != nil {
//                let imagePath = fileInDocumentsDirectory(Key.Photo)
//                saveImage(photo!, path: imagePath)
//            }
//        }
//        get {
//            let imagePath = fileInDocumentsDirectory(Key.Photo)
//            if let loadedImage = loadImageFromPath(imagePath) {
//                return loadedImage
//            } else {
//                return nil
//            }
//        }
//    }
    
    //MARK: - Save File
    //--------------------------------------------------------------------------
    static func getDocumentsURL() -> NSURL {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        return documentsURL
    }
    
    static func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
        return fileURL.path!
        
    }
    
    static func saveImage (image: UIImage, path: String ) -> Bool{
        
        let pngImageData = UIImagePNGRepresentation(image)
        //let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        let result = pngImageData!.writeToFile(path, atomically: true)
        
        return result
        
    }
    
    static func loadImageFromPath(path: String) -> UIImage? {
        
        let image = UIImage(contentsOfFile: path)
        
        if image == nil {
            
            print("missing image at: \(path)")
        }
        print("Loading image from path: \(path)") // this is just for you to see the path in case you want to go to the directory, using Finder.
        return image
        
    }
}