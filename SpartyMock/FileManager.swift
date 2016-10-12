//
//  FileManager.swift
//  Sparty
//
//  Created by David Colvin on 10/7/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation

class FileManager: NSObject {
    
    struct FileName {
        static let UserObject = "Sparty_FileName_UserObject"
    }
    
    static func saveNewUser(user: User) {
        
        FirebaseManager.saveUsername(user.screenName)
        FirebaseManager.saveEmail(user.email)
        FirebaseManager.saveUserInfo(user.dict())
        FileManager.saveToDisk(FileName.UserObject, object: user)
        
        NSUserDefaults.setIsRegistered(true)
    }
    
    
    static func filePath(fileName: String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory = paths[0] as String
        return (documentDirectory as NSString).stringByAppendingPathComponent(fileName)
    }
    
    static func saveToDisk(fileName:String, object:AnyObject) {
        NSKeyedArchiver.archiveRootObject(object, toFile: filePath(fileName))
    }
    
    func loadFromDisk(fileName:String) -> AnyObject? {
        //Load if it exists
        if NSFileManager.defaultManager().fileExistsAtPath(FileManager.filePath(fileName)) {
            return NSKeyedUnarchiver.unarchiveObjectWithFile(FileManager.filePath(fileName))
        }
        return nil
    }
}
