//
//  SettingsViewController.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let kCellID = "settingscell"
    var options: NSArray?
    var example : ExampleViewController?
    let table = UITableView()
    var selectedOption = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        table.frame = self.view.bounds
        table.dataSource = self
        table.delegate = self
        self.view.addSubview(table)

        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellID)
    
        let indexPath = NSIndexPath(forRow: self.selectedOption, inSection: 0)
        table.selectRowAtIndexPath(indexPath, animated: false, scrollPosition: UITableViewScrollPosition.Middle)
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

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellID) as UITableViewCell
        let info = options![indexPath.row] as OptionInfo
        cell.textLabel.text = info.optionText
        cell.selectionStyle = UITableViewCellSelectionStyle.None

        if (indexPath.row == self.example!.selectedOption) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        
        return cell
    }
    
//MARK: - UITableViewDelegate
  
    func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
       
        self.example!.selectedOption = indexPath.row
        let info = options![indexPath.row] as OptionInfo
        info.selector?()
        
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