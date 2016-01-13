//
//  ListViewGroups.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewGroups: TKExamplesExampleViewController {

    let dataSource = TKDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource.loadDataFromJSONResource("ListViewSampleData", ofType: "json", rootItemKeyPath: "teams")
        self.dataSource.groupItemSourceKey = "items"
        self.dataSource.groupWithKey("key")
        
        let listView = TKListView(frame: self.view.bounds)
        listView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        listView.dataSource = dataSource
        listView.selectionBehavior = TKListViewSelectionBehavior.Press
        self.view.addSubview(listView)
        
        let layout = listView.layout as! TKListViewLinearLayout
        
        layout.itemSize = CGSizeMake(300, 44)
        layout.itemSpacing = 0
        layout.headerReferenceSize = CGSizeMake(100, 44);
        layout.footerReferenceSize = CGSizeMake(100, 44);

        self.dataSource.settings.listView.initCell { (TKListView listView, NSIndexPath indexPath, TKListViewCell cell, AnyObject item) -> Void in
            let group = self.dataSource.items[indexPath.section] as! TKDataSourceGroup
            cell.textLabel.text = group.items[indexPath.row] as? String
        }
        
        self.dataSource.settings.listView.initHeader { (TKListView listView, NSIndexPath indexPath, TKListViewHeaderCell headerCell, TKDataSourceGroup group) -> Void in
            headerCell.textLabel.text = "\(group!.key)"
            headerCell.textLabel.textAlignment = NSTextAlignment.Center
        }
        
        self.dataSource.settings.listView.initFooter { (TKListView listView, NSIndexPath indexPath, TKListViewFooterCell footerCell, TKDataSourceGroup group) -> Void in
            footerCell.textLabel.text = "Members count: \(group!.items.count)"
            footerCell.textLabel.textAlignment = NSTextAlignment.Left
            footerCell.textLabel.frame = CGRectMake(5, 10, 200, 22)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
