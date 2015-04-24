//
//  ExampleInfo.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class ExampleInfo : NSObject {
    
    let title : String
    var examples = [ExampleInfo]()
    var exampleFunc: () -> (UIViewController)
    
    init(title: String, example exampleFunc:() -> (UIViewController)) {
        self.exampleFunc = exampleFunc
        self.title = title
    }
    
    init(title: String, exampleList examples:[ExampleInfo]) {
        exampleFunc = { ViewController() }
        self.examples = examples
        self.title = title
    }
    
    func createController() -> UIViewController {
        var controller = exampleFunc()
        if examples.count > 0 {
           (controller as! ViewController).initWithExample(self)
        }
        controller.title = self.title
        return controller
    }
}
