//
//  LoremIpsumGenerator.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class LoremIpsumGenerator: NSObject {
    
    let words = ["lorem", "ipsum", "dolor", "sit", "amet", "consectetuer", "adipiscing", "elit", "integer", "in", "mi", "a", "mauris"]
    let rows = NSMutableDictionary()
    
    func generateString(wordCount: NSInteger) -> NSString {
        let randomString = NSMutableString()
        for var i = 0; i < wordCount; ++i {
            let index : Int = Int(arc4random_uniform(UInt32(words.count)))
            randomString.appendString(words[index])
            randomString.appendString(" ")
        }
        return randomString
    }
    
    func randomString(wordCount: NSInteger, indexPath: NSIndexPath) -> NSString {
        var text : NSString? = rows.objectForKey(indexPath) as? NSString
        if(text == nil){
          text = generateString(wordCount)
          rows.setObject(text!, forKey: indexPath)
        }
        return text!
    }
}
