//
//  ListViewDocsGroupsDelegate.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

import UIKit

// >> listview-groups-delegate-swift
class ListViewDocsGroupsDelegate: UIViewController, TKListViewDataSource {
    var items = [DataSourceItem]()
    let groups = [["John","Abby"],["Smith","Peter","Paula"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items.append(DataSourceItem(name: "John", value: 50, group: "A"))
        items.append(DataSourceItem(name: "Abby", value: 33, group: "A"))
        items.append(DataSourceItem(name: "Smith", value: 42, group: "B"))
        items.append(DataSourceItem(name: "Peter", value: 28, group: "B"))
        items.append(DataSourceItem(name: "Paula", value: 25, group: "B"))
        
        let listView = TKListView(frame: CGRectMake(20, 20, self.view.bounds.size.width-40,self.view.bounds.size.height-40))
        listView.registerClass(TKListViewCell.self, forCellWithReuseIdentifier: "cell")
        listView.registerClass(TKListViewHeaderCell.self, forSupplementaryViewOfKind: TKListViewElementKindSectionHeader, withReuseIdentifier: "header")
        listView.dataSource = self
        let layout = listView.layout as! TKListViewLinearLayout
        layout.headerReferenceSize = CGSizeMake(200, 22)
        self.view.addSubview(listView)
    }
    
    func numberOfSectionsInListView(listView: TKListView) -> Int {
        return groups.count
    }
    
    func listView(listView: TKListView, numberOfItemsInSection section: Int) -> Int {
        return groups[section].count
    }
    
    func listView(listView: TKListView, cellForItemAtIndexPath indexPath: NSIndexPath) -> TKListViewCell? {
        let cell = listView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TKListViewCell
        cell.textLabel.text = groups[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func listView(listView: TKListView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> TKListViewReusableCell? {
        let headerCell = listView.dequeueReusableSupplementaryViewOfKind(TKListViewElementKindSectionHeader, withReuseIdentifier: "header", forIndexPath: indexPath) as! TKListViewHeaderCell
        headerCell.textLabel.text = "Group \(indexPath.section)"
        
        return headerCell
    }
}
// << listview-groups-delegate-swift
