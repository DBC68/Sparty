//
//  String+Additions.swift
//  PetAlert
//
//  Created by David Colvin on 5/19/16.
//  Copyright © 2016 Distal Industries. All rights reserved.
//

import Foundation

extension String {
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(self)
    }
    
    func isValidLength(min:Int, max:Int) -> Bool {
        return self.characters.count >= min && self.characters.count <= max
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    

    func wordCount() -> Int {
        return self.componentsSeparatedByString(" ").count
    }
    
    func isNotEmpty() -> Bool {
        return !(self ?? "").isEmpty
    }
    
    func fromBase64() -> String
    {
        let data = NSData(base64EncodedString: self, options: NSDataBase64DecodingOptions(rawValue: 0))
        return String(data: data!, encoding: NSUTF8StringEncoding)!
    }
    
    func toBase64() -> String
    {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        return data!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    }
}
