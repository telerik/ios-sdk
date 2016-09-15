//
//  ListViewDocsGroups.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

import UIKit

// >> listview-groups-swift
class ListViewDocsGroups: UIViewController {
    
    var dataSource: TKDataSource?
    var items = [DataSourceItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items.append(DataSourceItem(name: "John", value: 50, group: "A"))
        items.append(DataSourceItem(name: "Abby", value: 33, group: "A"))
        items.append(DataSourceItem(name: "Smith", value: 42, group: "B"))
        items.append(DataSourceItem(name: "Peter", value: 28, group: "B"))
        items.append(DataSourceItem(name: "Paula", value: 25, group: "B"))
        
        dataSource = TKDataSource()
        dataSource?.itemSource = items
        dataSource?.groupWithKey("group")
        dataSource?.displayKey = "name"
        let listView = TKListView(frame: CGRectMake(20, 20, self.view.bounds.size.width-40,self.view.bounds.size.height-40))
        
        listView.dataSource = dataSource
        let layout = listView.layout as! TKListViewLinearLayout
        layout.headerReferenceSize = CGSizeMake(200, 22)
        self.view.addSubview(listView)
    }
}
// << listview-groups-swift
