//
//  LocalizedCalendar.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class LocalizedCalendar: ExampleViewController {
    
    let calendarView = TKCalendar()
    
    override init() {
        super.init()

        self.addOption("Russian") { self.selectRussian() }
        self.addOption("German") { self.selectGerman() }
        self.addOption("Hebrew") { self.selectHebrew() }
        self.addOption("Chinese") { self.selectChinese() }
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendarView.frame = self.view.bounds
        self.calendarView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(self.calendarView)
        
        self.selectHebrew()
    }
    
    func selectRussian() {
        self.calendarView.calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        self.calendarView.locale = NSLocale(localeIdentifier: "ru_RU")
        self.calendarView.presenter().update(false)
    }
    
    func selectGerman() {
        self.calendarView.calendar = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        self.calendarView.locale = NSLocale(localeIdentifier: "de_DE")
        self.calendarView.presenter().update(false)
    }
    
    func selectHebrew() {
        self.calendarView.calendar = NSCalendar(calendarIdentifier: NSHebrewCalendar)
        self.calendarView.locale = NSLocale(localeIdentifier: "he_IL")
        self.calendarView.presenter().update(false)
    }
    
    func selectChinese() {
        self.calendarView.calendar = NSCalendar(calendarIdentifier: NSChineseCalendar)
        self.calendarView.locale = NSLocale(localeIdentifier: "zh_Hans_SG")
        self.calendarView.presenter().update(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
