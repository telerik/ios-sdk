//
//  ListViewWrapLayout.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewWrapLayout: ExampleViewController, TKListViewDataSource {

    let dataSource = TKDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource.loadDataFromJSONResource("ListViewSampleData", ofType: "json", rootItemKeyPath: "photos")
        
        let listView = TKListView(frame:self.view.bounds)
        listView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
      //  listView.layoutMode = TKListViewLayoutMode.Wrap
        listView.dataSource = self
      //  listView.cellAlignment = TKListViewCellAlignment.Stretch
        listView.selectionBehavior = TKListViewSelectionBehavior.Press
      //  listView.itemSize = CGSizeMake(self.view.bounds.size.width/2.0 - 0.5, 130)
     //   listView.minimumLineSpacing = 0

        listView.registerClass(TKListViewCell.self, forCellWithReuseIdentifier: "cell")
        self.view .addSubview(listView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// MARK: - TKListViewDataSource
    
    func listView(listView: TKListView!, numberOfItemsInSection section: Int) -> Int
    {
        return self.dataSource.items.count
    }
    
    func listView(listView: TKListView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> TKListViewCell!
    {
        let cell = listView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as TKListViewCell
        cell.imageView.frame = CGRectMake(cell.frame.size.width/2.0 - 35.0, 10, 70, 80)
        cell.imageView.image = UIImage(named: self.dataSource.items[indexPath.row] as String)
   //     cell.label.frame = CGRectMake(cell.frame.size.width/2.0 - 50, 100, 100, 22)
   //     cell.label.text = "Lorem ipsum"
        return cell
    }
}
