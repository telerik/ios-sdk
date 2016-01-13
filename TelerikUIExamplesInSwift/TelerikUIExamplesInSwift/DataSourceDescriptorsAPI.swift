//
//  DataSourceDescriptorsAPI.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class DataSourceDescriptorsAPI: TKExamplesExampleViewController {

    let dataSource = TKDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Descriptors API"
            
        self.dataSource.addFilterDescriptor(TKDataSourceFilterDescriptor(query:"NOT (name like 'John')"))
        self.dataSource.addSortDescriptor(TKDataSourceSortDescriptor(property: "name", ascending: true))
        self.dataSource.addGroupDescriptor(TKDataSourceGroupDescriptor(property: "group"))
        
        var items = [DSItem]()
        
        items.append(DSItem(name: "John", value: 22, group: "one"))
        items.append(DSItem(name: "Peter", value: 15, group: "one"))
        items.append(DSItem(name: "Abby", value: 47, group: "one"))
        items.append(DSItem(name: "Robert", value: 45, group: "two"))
        items.append(DSItem(name: "Alan", value: 17, group: "two"))
        items.append(DSItem(name: "Saly", value: 33, group: "two"))
        
        self.dataSource.displayKey = "name"
        self.dataSource.valueKey = "value"
        self.dataSource.itemSource = items
        
        let tableView = UITableView(frame: self.view.bounds)
        tableView.dataSource = self.dataSource
        tableView.autoresizingMask = UIViewAutoresizing(rawValue: ~UIViewAutoresizing.None.rawValue)
        self.view.addSubview(tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
