//
//  ListViewVariableHeight.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewVariableHeight: TKExamplesExampleViewController {
    
    var items = [String]()
    var dataSource = TKDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let loremGenerator = LoremIpsumGenerator()
        for _ in 0..<20 {
            items.append(loremGenerator.generateString(2 + Int(arc4random()%30)) as String)
        }
        
        dataSource.itemSource = items
        dataSource.settings.listView.defaultCellClass = ListViewDynamicSizeCell.self
        dataSource.settings.listView.initCell { (listView:TKListView, indexPath:NSIndexPath, cell:TKListViewCell, item:AnyObject) -> Void in
            let myCell = cell as! ListViewDynamicSizeCell
            myCell.label!.text = item as? String
        }
        
        let listView = TKListView(frame:self.view.bounds)
        listView.autoresizingMask = [ .FlexibleWidth, .FlexibleHeight ]
        listView.dataSource = dataSource
        self.view.addSubview(listView)
        
        let layout = listView.layout as! TKListViewLinearLayout
        layout.dynamicItemSize = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
