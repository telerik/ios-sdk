//
//  ViewController.swift
//  ListViewItemsVariableSize
//
//  Created by Tsvetan Raikov on 11/3/15.
//  Copyright © 2015 TR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let dataSource = TKDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let listView = TKListView(frame: self.view.frame)
        listView.autoresizingMask = [ .FlexibleWidth, .FlexibleHeight ]
        listView.contentInset = UIEdgeInsets(top: 35, left: 4, bottom: 4, right: 4)
        self.view.addSubview(listView)
        
        let layout = listView.layout as! TKListViewLinearLayout
        layout.dynamicItemSize = true
        layout.itemSpacing = 4

        listView.registerNib(UINib(nibName: "MyCell", bundle: nil), forCellReuseIdentifier: "myCell")

        dataSource.settings.listView.defaultCellID = "myCell"
        
        dataSource.settings.listView.initCell { (listView:TKListView, indexPath:NSIndexPath, cell:TKListViewCell, item:AnyObject) -> Void in
            let myCell = cell as! MyCell
            let dict = item as! NSDictionary
            myCell.myLabel.text = dict["titleNoFormatting"] as? String
        }
        
        dataSource.loadDataFromURL("https://ajax.googleapis.com/ajax/services/search/news?v=1.0&rsz=8&q=Telerik", dataFormat: TKDataSourceDataFormat.JSON, rootItemKeyPath: "responseData.results") { (err:NSError?) -> Void in
            listView.dataSource = self.dataSource
            listView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

