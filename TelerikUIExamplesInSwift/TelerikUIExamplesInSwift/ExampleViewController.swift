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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.translucent = false
        self.view.backgroundColor = UIColor.whiteColor()
        
        let idiom = UIDevice.currentDevice().userInterfaceIdiom as UIUserInterfaceIdiom
        if(options.count > 0) {
            if (idiom == UIUserInterfaceIdiom.Pad) {
                self.loadIPadLayout()
            }
            else {
                self.loadIPhoneLayout()
            }
        }
        else {
            if (idiom == UIUserInterfaceIdiom.Pad) {
                self.exampleBounds = CGRectInset(self.view.bounds, 30, 30)
            }
            else {
                self.exampleBounds = CGRectInset(self.view.bounds, 10, 10)
            }
        }
    }
    
    func loadIPhoneLayout() {
        if options.count == 1 {
           let info = options[0] as OptionInfo
           self.settingsButton = UIBarButtonItem(title: info.optionText, style: UIBarButtonItemStyle.Plain, target: self, action: "optionTouched")
        }
        else {
            let image = UIImage(named: "menu")
            self.settingsButton = UIBarButtonItem(image: image, style: UIBarButtonItemStyle.Plain, target: self, action: "settingsTouched")
        }
        self.navigationItem.rightBarButtonItem = self.settingsButton;
        self.exampleBounds = CGRectInset(self.view.bounds, 10, 10);
    }
    
    func loadIPadLayout() {
        var desiredSize: CGSize = CGSizeZero
        if (options.count == 1) {
            let info  = options[0] as OptionInfo
            let button = UIButton.buttonWithType(UIButtonType.System) as UIButton
            button.addTarget(self, action: "optionTouched", forControlEvents: UIControlEvents.TouchDown)
            button.setTitle(info.optionText, forState: UIControlState.Normal)
            desiredSize = button.sizeThatFits(self.view.bounds.size)
            button.frame = CGRectMake(30, 10, desiredSize.width, desiredSize.height)
            self.view.addSubview(button)
        }
        else if (options.count >= 3) {
            settingsButton = UIBarButtonItem(image: UIImage(named: "menu"), style: UIBarButtonItemStyle.Plain, target: self, action: "settingsTouched")
            self.navigationItem.rightBarButtonItem = settingsButton
        }
        else {
            let segmented = UISegmentedControl()
            var i: Int = 0
            for o in options {
                let option = o as OptionInfo
                segmented.insertSegmentWithTitle(option.optionText, atIndex: i++, animated: false)
            }
            desiredSize = segmented.sizeThatFits(self.view.bounds.size)
            segmented.frame = CGRectMake(10, 10, desiredSize.width, desiredSize.height)
            segmented.addTarget(self, action: "optionSelected:", forControlEvents: UIControlEvents.ValueChanged)
            self.view.addSubview(segmented)
            segmented.selectedSegmentIndex = self.selectedOption
        }

        exampleBounds = CGRectMake(20, 30 + desiredSize.height, self.view.bounds.size.width - 40, self.view.bounds.size.height - desiredSize.height - 60)
    }
    
    func addOption(text:NSString, selector: Optional<() -> ()>) {
        options.addObject(OptionInfo(Text: text, Selector: selector))
    }
    
    func addOption(option: OptionInfo) {
        options.addObject(option)
    }
    
    func optionSelected(sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex >= 0) {
            self.selectedOption = sender.selectedSegmentIndex
            let info = options[sender.selectedSegmentIndex] as OptionInfo
            info.selector?()
        }
    }
    
    func optionTouched() {
        let info = options[0] as OptionInfo
        info.selector?()
    }
  
    func settingsTouched() {
        let settings = SettingsViewController()
        settings.options = options
        settings.example = self
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
