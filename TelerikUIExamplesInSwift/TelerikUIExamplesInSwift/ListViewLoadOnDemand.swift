//
//  ListViewLoadOnDemand.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewLoadOnDemand: ExampleViewController, TKListViewDataSource, TKListViewDelegate {

    let names = TKDataSource()
    let photos = TKDataSource()
    let loremIpsumGenerator = LoremIpsumGenerator()
    var lastRetrievedDataIndex = 15
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.photos.loadDataFromJSONResource("PhotosWithNames", ofType: "json", rootItemKeyPath: "photos")
        self.names.loadDataFromJSONResource("PhotosWithNames", ofType: "json", rootItemKeyPath: "names")

        let listView = TKListView(frame: self.view.bounds)
        listView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        listView.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.5)
        listView.dataSource = self
        listView.delegate = self
        listView.cellBufferSize = 5
        listView.insets = UIEdgeInsetsMake(10, 10, 10, 10)
        self.view.addSubview(listView)
        listView.registerClass(CustomCardListViewCell.classForCoder(), forCellWithReuseIdentifier:"cell")
    
        let layout = listView.layout as! TKListViewColumnsLayout
        layout.itemSize = CGSizeMake(100, 120)
        layout.minimumLineSpacing = 5
        layout.cellAlignment = TKListViewCellAlignment.Stretch
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
// MARK: TKListViewDataSource
    
    func listView(listView: TKListView!, numberOfItemsInSection section: Int) -> Int {
        return lastRetrievedDataIndex
    }
    
    func listView(listView: TKListView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> TKListViewCell! {
        let cell = listView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TKListViewCell
        cell.backgroundView?.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        cell.imageView.image = UIImage(named: self.photos.items[indexPath.row] as! String)
        cell.textLabel.text = names.items[indexPath.row] as? String
        cell.detailTextLabel.text = loremIpsumGenerator.randomString(10 + Int(arc4random_uniform(16)), indexPath: indexPath) as String
        cell.detailTextLabel.textColor = UIColor.whiteColor()
        let backgroundView = cell.backgroundView as! TKView
        backgroundView.stroke = nil
        return cell
    }
    
// MARK: TKListViewDelegate
    
    func listView(listView: TKListView!, shouldLoadMoreDataAtIndexPath indexPath: NSIndexPath!) -> Bool {
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { () -> Void in
        self.lastRetrievedDataIndex = min(self.names.items.count, self.lastRetrievedDataIndex + 10)
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), {
            //Notifying the ListView that we have fresh data so it can hide the activity indicator and be ready for next load-on-demand request.
            listView.didLoadDataOnDemand()
        })
       })
        
        return true
    }
}
