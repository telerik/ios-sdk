//
//  IndicatorsTableView.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class IndicatorsTableView : UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var example: Indicators?
    var table = UITableView()
    let kCellIdentifier: NSString = "indicatorCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.frame = self.view.bounds
        table.autoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth
        table.dataSource = self
        table.delegate = self
        table.allowsMultipleSelection = true
        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        self.view.addSubview(table)
        
        let trendlinePath = NSIndexPath(forRow: example!.selectedTrendline, inSection: 0)
        let indicatorPath = NSIndexPath(forRow: example!.selectedIndicator, inSection: 1)
        table.selectRowAtIndexPath(trendlinePath, animated: false, scrollPosition: UITableViewScrollPosition.None)
        table.selectRowAtIndexPath(indicatorPath, animated: false, scrollPosition: UITableViewScrollPosition.None)
    }
    
    //MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return example!.trendlines.count
        }
        else {
            return example!.indicators.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var info: OptionInfo
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier) as UITableViewCell!
        let section = indexPath.section as NSInteger
        if section == 0 {
            info = example!.trendlines[indexPath.row] as OptionInfo
            if indexPath.row == example!.selectedTrendline {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
        }
        else {
            info = example!.indicators[indexPath.row] as OptionInfo
            if indexPath.row == example!.selectedIndicator {
                cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            }
            else {
                cell.accessoryType = UITableViewCellAccessoryType.None
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.textLabel!.text = info.optionText
        
        return cell
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String {
        if section == 0 {
            return "Trendlines"
        }
        else {
            return "Indicators"
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let section = indexPath.section
        let selectedRow = indexPath.row
        var info: OptionInfo
        if section == 0 {
            let currentPath = NSIndexPath(forRow: example!.selectedTrendline, inSection: section)
            tableView.deselectRowAtIndexPath(currentPath, animated: false)
            example!.selectedTrendline = selectedRow
            info = example!.trendlines[selectedRow] as OptionInfo
        }
        else {
            let currentPath = NSIndexPath(forRow: example!.selectedTrendline, inSection: section)
            tableView.deselectRowAtIndexPath(currentPath, animated: false)
            example!.selectedIndicator = selectedRow
            info = example!.indicators[selectedRow] as OptionInfo
        }

        info.selector!()
        
        tableView.reloadData()
    }

    func tableView(tableView: UITableView, willDeselectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        return nil
    }
}