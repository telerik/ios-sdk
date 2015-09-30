//
//  DataPointImpl.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class DataPointImpl : NSObject, TKChartData {
    
    var objectID : NSInteger
    var value : CGFloat
    
    init(ID objectID: NSInteger, withValue value: CGFloat){
        self.objectID = objectID
        self.value = value
    }
    
    var dataXValue: AnyObject! {
        get {
            return self.objectID
        }
        set {}
    }
    
    var dataYValue: AnyObject! {
        get {
            return self.value
        }
        set {}
    }
}