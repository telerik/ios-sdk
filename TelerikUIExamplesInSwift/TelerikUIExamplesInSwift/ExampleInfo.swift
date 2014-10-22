//
//  ExampleInfo.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class ExampleInfo : NSObject {
    
    let title : NSString
    var examples : NSArray?
    var exampleFunc: () -> (UIViewController)
    
    init(title: NSString, example exampleFunc:() -> (UIViewController)) {
        self.exampleFunc = exampleFunc
        self.title = title
    }
    
    init(title: NSString, exampleList examples:NSArray) {
        exampleFunc = { ViewController() }
        self.examples = examples
        self.title = title
    }
    
    func createController() -> UIViewController {
        var controller = exampleFunc()
        if let e = examples {
           (controller as ViewController).initWithExample(self)
        }
        controller.title = self.title
        return controller
    }
}
