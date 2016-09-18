//
//  UIImage+Additions.swift
//  Sparty
//
//  Created by David Colvin on 9/17/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation

extension UIImage {
    
    func resize(newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        self.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    static func imageToString(image: UIImage) -> String? {
        if let data = UIImagePNGRepresentation(image) {
            return data.base64EncodedStringWithOptions([])
        }
        return nil
    }
    
    static func stringToImage(photoString: String) -> UIImage? {
        if let data = NSData(base64EncodedString: photoString, options: []) {
            return UIImage(data: data)
        }
        return nil
    }
}