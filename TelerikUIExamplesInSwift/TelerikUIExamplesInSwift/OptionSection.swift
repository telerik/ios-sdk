//
//  OptionSection.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class OptionSection: NSObject {
   
    var title = ""
    
    var items = NSMutableArray()
    
    var selectedOption: Int = 0

    init(Text:NSString) {
        self.title = Text
    }
}
