//
//  LocalizedCalendar.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class LocalizedCalendar: TKExamplesExampleViewController {
    
    let calendarView = TKCalendar()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Russian", action: selectRussian)
        self.addOption("German", action: selectGerman)
        self.addOption("Hebrew", action: selectHebrew)
        self.addOption("Chinese", action: selectChinese)
        self.addOption("Islamic", action: selectIslamic)
        
        self.selectedOption = 2
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.calendarView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(self.calendarView)
        
        self.selectHebrew()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.calendarView.frame = self.view.bounds
    }
    
    func selectRussian() {
        self.calendarView.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        self.calendarView.locale = NSLocale(localeIdentifier: "ru_RU")
        self.calendarView.presenter.update(false)
    }
    
    func selectGerman() {
        self.calendarView.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
        self.calendarView.locale = NSLocale(localeIdentifier: "de_DE")
        self.calendarView.presenter.update(false)
    }
    
    func selectHebrew() {
        self.calendarView.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierHebrew)!
        self.calendarView.locale = NSLocale(localeIdentifier: "he_IL")
        self.calendarView.presenter.update(false)
    }
    
    func selectChinese() {
        self.calendarView.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierChinese)!
        self.calendarView.locale = NSLocale(localeIdentifier: "zh_Hans_SG")
        self.calendarView.presenter.update(false)
    }
    
    func selectIslamic() {
        self.calendarView.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierIslamic)!
        self.calendarView.locale = NSLocale(localeIdentifier:"ar-QA")
        self.calendarView.presenter.update(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
