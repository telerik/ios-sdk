//
//  DataSourceItem.swift
//  TelerikUIExamplesInSwift
//
//  Created by Sophia Lazarova on 5/31/16.
//  Copyright © 2016 Telerik. All rights reserved.
//

import UIKit

class DataSourceItem: NSObject {
    var name:String = ""
    var content:String = ""
    var value:Float = 0
    
    init(name: String, value: Float) {
        self.name = name
        self.value = value
    }
    
    var group:String = ""
    
    init(name: String, value: Float, group: String) {
        self.name = name
        self.value = value
        self.group = group
    }
    
    var startDate:NSDate?
    
    var endDate:NSDate?
}

