//
//  CalendarTransitonEffects.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CalendarTransitonEffects: ExampleViewController, TKCalendarPresenterDelegate {
    
    let toolbar = UIToolbar()
    let calendarView = TKCalendar()
    let colors = [UIColor(red: 0, green: 1, blue: 0, alpha: 0.3),
                  UIColor(red: 1, green: 0, blue: 0, alpha: 0.3),
                  UIColor(red: 0, green: 0, blue: 1, alpha: 0.3),
                  UIColor(red: 1, green: 1, blue: 0, alpha: 0.3),
                  UIColor(red: 0, green: 1, blue: 1, alpha: 0.3),
                  UIColor(red: 1, green: 0, blue: 1, alpha: 0.3)]
    var colorIndex = 0
    var oldColorIndex = -1
    
    override init() {
        super.init()

        self.addOption("Flip effect") { self.selectFlipEffect() }
        self.addOption("Float effect") { self.selectFloatEffect() }
        self.addOption("Fold effect") { self.selectFoldEffect() }
        self.addOption("Rotate effect") { self.selectRotateEffect() }
        self.addOption("Card effect") { self.selectCardEffect() }
        self.addOption("Scroll effect") { self.selectScrollEffect() }
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.toolbar)
        self.view.addSubview(self.calendarView)
        
        let buttonPrev = UIBarButtonItem(title: "Prev month", style: UIBarButtonItemStyle.Plain, target: self, action: "prevTouched:")
        let buttonNext = UIBarButtonItem(title: "Next month", style: UIBarButtonItemStyle.Plain, target: self, action: "nextTouched:")
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        self.toolbar.items = [buttonPrev, space, buttonNext]
        
        let presenter = self.calendarView.presenter() as TKCalendarMonthPresenter
        presenter.transitionMode = TKCalendarTransitionMode.Flip
        presenter.delegate = self
        presenter.headerIsSticky = true
        presenter.contentView().backgroundColor = colors[colorIndex]
    }
    
    override func viewDidLayoutSubviews() {
        toolbar.frame = CGRectMake(0, self.view.frame.size.height - 44, self.view.bounds.size.width, 44)
        calendarView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - toolbar.frame.size.height)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//MARK: - Events
    
    func prevTouched(sender: AnyObject) {
        calendarView.navigateBack(true)
    }
    
    func nextTouched(sender: AnyObject) {
        calendarView.navigateForward(true)
    }
    
    func selectFlipEffect() {
        self.setTransition(TKCalendarTransitionMode.Flip, isVertical: false)
    }
    
    func selectFloatEffect() {
        self.setTransition(TKCalendarTransitionMode.Float, isVertical: false)
    }
    
    func selectFoldEffect() {
        self.setTransition(TKCalendarTransitionMode.Fold, isVertical: false)
    }
    
    func selectRotateEffect() {
        self.setTransition(TKCalendarTransitionMode.Rotate, isVertical: false)
    }
    
    func selectCardEffect() {
        self.setTransition(TKCalendarTransitionMode.Card, isVertical: true)
    }
    
    func selectScrollEffect() {
        self.setTransition(TKCalendarTransitionMode.Scroll, isVertical: true)
    }
    
    func setTransition(transitionMode: TKCalendarTransitionMode, isVertical: Bool) {
        let presenter = calendarView.presenter() as TKCalendarMonthPresenter
        presenter.delegate = self
        presenter.headerIsSticky = true
        presenter.transitionIsVertical = isVertical
        presenter.transitionMode = transitionMode
    }
    
//MARK: - TKCalendarPresenterDelegate
    
    func presenter(presenter: TKCalendarPresenter!, beginTransition transition: TKViewTransition!) {
        oldColorIndex = colorIndex
        colorIndex = (colorIndex + 1) % colors.count
        let monthPresenter = presenter as TKCalendarMonthPresenter
        monthPresenter.contentView().backgroundColor = colors[colorIndex]
    }
    
    func presenter(presenter: TKCalendarPresenter!, finishTransition canceled: Bool) {
        if canceled {
            let monthPresenter = presenter as TKCalendarMonthPresenter
            monthPresenter.contentView().backgroundColor = colors[oldColorIndex]
            colorIndex = oldColorIndex
        }
    }
}
