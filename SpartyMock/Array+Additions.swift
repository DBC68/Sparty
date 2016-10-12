//
//  Array+Additions.swift
//  Sparty
//
//  Created by David Colvin on 10/5/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation

extension Array where Element: NSCoding {
    
    func documentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentDirectory = paths[0] as String
        return documentDirectory
    }
    
    func saveToDisk(fileName:String) {
        //Get path to file
        let filePath = documentsDirectory().stringByAppendingPathComponent(fileName)
        //Save to disk
        NSKeyedArchiver.archiveRootObject(self, toFile: filePath)
    }
    
    func loadFromDisk(fileName:String) -> [Element]? {
        //Get path to file
        let filePath = documentsDirectory().stringByAppendingPathComponent(fileName)
        //Load if it exists
        if NSFileManager.defaultManager().fileExistsAtPath(filePath) {
            return NSKeyedUnarchiver.unarchiveObjectWithFile(filePath) as? [Element]
        }
        return nil
    }
}
