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
    
    func dataXValue() -> AnyObject! {
        return self.objectID
    }
    
    func dataYValue() -> AnyObject! {
        return self.value
    }
}