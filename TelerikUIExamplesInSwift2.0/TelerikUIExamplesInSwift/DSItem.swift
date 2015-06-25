//
//  DSItem.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class DSItem: NSObject {
    
    var name: String = ""
    
    var value: Float = 0
    
    var group: String = ""
    
    var image: UIImage?
    
    var date: NSDate?
    
    override init() {
        super.init()
    }
    
    init(name: String, value: Float, group: String) {
        self.name = name
        self.value = value
        self.group = group
    }
}
