//
//  OptionInfo.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class OptionInfo: NSObject
{
    var optionText: String?
    var selector: Optional<() -> ()> = nil
    var tag: AnyObject?
    
    init(Text:NSString, Selector selector:Optional<() -> ()>) {
        self.optionText = Text
        self.selector = selector
    }
    
    init(Text text:String, selector: Optional<() -> ()>, tag:AnyObject) {
        self.tag = tag
        self.optionText = text
        self.selector = selector
    }
}



