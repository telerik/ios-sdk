//
//  ExampleViewController.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class ExampleViewController: UIViewController {
    
    let options : NSMutableArray = NSMutableArray()
    let selectedOptions : NSMutableSet = NSMutableSet()
    var selectedOption : NSInteger = 0
    var popover: UIPopoverController?
    var settingsButton : UIBarButtonItem?
    var exampleBounds = CGRect.zeroRect
    var exampleBoundsWithInset = CGRect.zeroRect
    var sections = NSMutableArray()
    var headerHeight:CGFloat = 0
    var offset:CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.updateHeaderHeight()
        
        let idiom = UIDevice.currentDevice().userInterfaceIdiom as UIUserInterfaceIdiom
        if sections.count > 0 || options.count > 0 {
            if (idiom == UIUserInterfaceIdiom.Pad) {
                self.loadIPadLayout()
            }
            else {
                self.loadIPhoneLayout()
            }
        }
        
        self.updateLayoutConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.updateLayoutConstraints()
    }
    
    func updateHeaderHeight() {
        if  self.navigationController != nil {
            let navigationBar = self.navigationController!.navigationBar
            if navigationBar.translucent {
                let app = UIApplication.sharedApplication()
                let isLandscape = UIInterfaceOrientationIsLandscape(app.statusBarOrientation)
                self.headerHeight = navigationBar.intrinsicContentSize().height + (isLandscape ? app.statusBarFrame.size.width : app.statusBarFrame.size.height)
            }
        }
    }
    
    func updateLayoutConstraints() {
        
        self.exampleBounds = self.view.bounds

        self.updateHeaderHeight()

        self.exampleBounds.origin.y += headerHeight
        self.exampleBounds.size.height -= headerHeight
    
        if (self.offset > 0) {
            self.exampleBounds.origin.y += self.offset
            self.exampleBounds.size.height -= self.offset
        }
    
        let idiom = UIDevice.currentDevice().userInterfaceIdiom
        if idiom == UIUserInterfaceIdiom.Pad {
            self.exampleBoundsWithInset = CGRectInset(self.exampleBounds, 30, 30);
        }
        else {
            self.exampleBoundsWithInset = CGRectInset(self.exampleBounds, 10, 10);
        }
    }
    
    func loadIPhoneLayout() {
        if sections.count == 0 && options.count == 1 {
           let info = options[0] as! OptionInfo
           self.settingsButton = UIBarButtonItem(title: info.optionText, style: UIBarButtonItemStyle.Plain, target: self, action: "optionTouched")
        }
        else {
            let image = UIImage(named: "menu")
            self.settingsButton = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "settingsTouched")
        }
        self.navigationItem.rightBarButtonItem = self.settingsButton
    }
    
    func loadIPadLayout() {
        self.offset = 0
        var desiredSize: CGSize = CGSizeZero
        if sections.count == 0 && options.count == 1 {
            let info  = options[0] as! OptionInfo
            let button = UIButton(type: UIButtonType.System) as UIButton
            button.addTarget(self, action: "optionTouched", forControlEvents: UIControlEvents.TouchDown)
            button.setTitle(info.optionText, forState: UIControlState.Normal)
            desiredSize = button.sizeThatFits(self.view.bounds.size)
            button.frame = CGRectMake(30, 10 + self.headerHeight, desiredSize.width, desiredSize.height)
            self.view.addSubview(button)
            self.offset = 10 + desiredSize.height + 10
        }
        else if options.count >= 3 || sections.count > 0 {
            settingsButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self, action: "settingsTouched")
            self.navigationItem.rightBarButtonItem = settingsButton
        }
        else {
            let segmented = UISegmentedControl()
            var i: Int = 0
            for o in options {
                let option = o as! OptionInfo
                segmented.insertSegmentWithTitle(option.optionText, atIndex: i++, animated: false)
            }
            desiredSize = segmented.sizeThatFits(self.view.bounds.size)
            segmented.frame = CGRectMake(10, 10 + headerHeight, desiredSize.width, desiredSize.height)
            segmented.selectedSegmentIndex = self.selectedOption
            segmented.addTarget(self, action: "optionSelected:", forControlEvents: UIControlEvents.ValueChanged)
            self.view.addSubview(segmented)
            self.offset = 10 + desiredSize.height + 10
        }
    }
    
    func addOption(text:String, selector: Optional<() -> ()>) {
        options.addObject(OptionInfo(Text: text, Selector: selector))
    }
    
    func addOption(option: OptionInfo) {
        options.addObject(option)
    }
    
    func addOption(text:String, inSection:String, selector: Optional<() -> ()>) {
        addOption(OptionInfo(Text:text, Selector:selector), inSection:inSection)
    }
    
    func addOption(option: OptionInfo, inSection:String)
    {
        for section in sections {
            let sec = section as! OptionSection
            if sec.title == inSection {
                sec.items.addObject(option)
                return;
            }
        }
        let section = OptionSection(Text: inSection)
        section.items.addObject(option)
        sections.addObject(section)
    }
    
    func optionSelected(sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex >= 0) {
            self.selectedOption = sender.selectedSegmentIndex
            let info = options[sender.selectedSegmentIndex] as! OptionInfo
            info.selector?()
        }
    }
    
    func setSelectedOption(index: Int, section: Int) {
        let sec = sections[section] as! OptionSection
        sec.selectedOption = index
    }
    
    func optionTouched() {
        let info = options[0] as! OptionInfo
        info.selector?()
    }
  
    func settingsTouched() {
        let settings = SettingsViewController()
        settings.options = options
        settings.example = self
        settings.sections = sections
        settings.selectedOption = self.selectedOption
        
        let idiom = UIDevice.currentDevice().userInterfaceIdiom as UIUserInterfaceIdiom
        if (idiom == UIUserInterfaceIdiom.Pad) {
            if (popover != nil && popover!.popoverVisible) {
                popover!.dismissPopoverAnimated(true)
                return
            }
            
            popover = UIPopoverController(contentViewController: settings)
            let rect = settings.view.bounds
            settings.table.sizeToFit()
            let size = CGSizeMake(min(rect.size.width, rect.size.height) / 2, settings.table.contentSize.height) as CGSize
            popover!.popoverContentSize = size
            popover!.presentPopoverFromBarButtonItem(settingsButton!, permittedArrowDirections: UIPopoverArrowDirection.Up, animated: true)
        }
        else {
            self.navigationController?.pushViewController(settings, animated: true)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        if (popover != nil && popover!.popoverVisible) {
            popover!.dismissPopoverAnimated(true)
        }
    }
}
