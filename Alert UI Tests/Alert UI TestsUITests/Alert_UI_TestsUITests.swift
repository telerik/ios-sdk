//
//  Alert_UI_TestsUITests.swift
//  Alert UI TestsUITests
//
//  Created by Miroslava Ivanova on 8/18/15.
//  Copyright © 2015 Telerik. All rights reserved.
//

import XCTest

class Alert_UI_TestsUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let answerMeButton = app.buttons["Answer me"]
        
        answerMeButton.tap()
        
        XCTAssert(app.staticTexts["Chicken or the egg?"].exists)
        XCTAssert(app.staticTexts["Which came first, the chicken or the egg?"].exists)
        
        app.buttons["Chicken"].tap()
        
        XCTAssert(app.staticTexts["It was the chiken"].exists)
        
        answerMeButton.tap()
        app.buttons["Egg"].tap()
        
        XCTAssert(app.staticTexts["It was the egg"].exists)
        
    }
    
}
