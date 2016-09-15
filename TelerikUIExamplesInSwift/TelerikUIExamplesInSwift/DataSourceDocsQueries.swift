//
//  DataSourceDocsQueries.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

// >> datasource-predicate-style-swift
class DataSourceDocsQueries: UIViewController {

    let dataSource = TKDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // >> datasource-displaykey-swift
        var items = [DataSourceItem]()
        items.append(DataSourceItem(name: "John", value: 50, group: "A"))
        items.append(DataSourceItem(name: "Abby", value: 33, group: "A"))
        items.append(DataSourceItem(name: "Smith", value: 42, group: "B"))
        items.append(DataSourceItem(name: "Peter", value: 28, group: "B"))
        items.append(DataSourceItem(name: "Paula", value: 25, group: "B"))
        
        dataSource.itemSource = items
        dataSource.displayKey = "name"
        // << datasource-displaykey-swift
        
        dataSource.filterWithQuery("value > 30")
        dataSource.sortWithKey("value", ascending: true)
        dataSource.groupWithKey("group")
        
        
        let tableView = UITableView(frame: self.view.bounds)
        tableView.dataSource = dataSource
        tableView.autoresizingMask = UIViewAutoresizing(rawValue:~UIViewAutoresizing.None.rawValue)
        self.view.addSubview(tableView)
    }
}
// << datasource-predicate-style-swift
