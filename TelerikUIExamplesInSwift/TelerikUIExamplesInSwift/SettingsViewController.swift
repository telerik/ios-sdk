//
//  SettingsViewController.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let kCellID = "settingscell"
    var options: NSArray?
    var example : ExampleViewController?
    let table = UITableView()
    var sections = NSMutableArray()
    var selectedOption = 0
    var translucent: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.translucent = self.navigationController?.navigationBar.translucent
        self.navigationController?.navigationBar.translucent = false
        
        table.frame = self.view.bounds
        table.dataSource = self
        table.delegate = self
        self.view.addSubview(table)

        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellID)
    
        let indexPath = NSIndexPath(forRow: self.selectedOption, inSection: 0)
        table.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Middle)
    }
    
    override func willMoveToParentViewController(parent: UIViewController?) {
        super.willMoveToParentViewController(parent)
        if (parent == nil) {
            self.navigationController?.navigationBar.translucent = self.translucent!
        }
    }
    
    override func didReceiveMemoryWarning() {
        // Dispose of any resources that can be recreated.
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = self.view.bounds
    }
    
//MARK: - UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if sections.count > 0 {
            return sections.count
        }
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sections.count > 0 {
            let sec = sections[section] as! OptionSection
            return sec.items.count
        }
        return options!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellID)!

        if sections.count > 0 {
            let sec = sections[indexPath.section] as! OptionSection
            let info = sec.items[indexPath.row] as! OptionInfo
            cell.textLabel!.text = info.optionText
            if (indexPath.row == sec.selectedOption) {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        }
        else {
            let info = options![indexPath.row] as! OptionInfo
            cell.textLabel!.text = info.optionText
            if (indexPath.row == self.example!.selectedOption) {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sec = sections[section] as! OptionSection
        return sec.title
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if sections.count > 0 {
            return 44
        }
        return 0
    }
    
//MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
       
        var info:OptionInfo?
        if sections.count > 0 {
            let sec = sections[indexPath.section] as! OptionSection
            sec.selectedOption = indexPath.row
            info = sec.items[indexPath.row] as? OptionInfo
        }
        else {
            self.example!.selectedOption = indexPath.row
            info = options![indexPath.row] as? OptionInfo
        }
        
        info?.selector?()
        
        if let popover = self.example!.popover {
            if (popover.popoverVisible) {
                popover.dismissPopoverAnimated(false)
            }
        }
        else {
            self.navigationController?.popViewControllerAnimated(true)
        }

    }
}