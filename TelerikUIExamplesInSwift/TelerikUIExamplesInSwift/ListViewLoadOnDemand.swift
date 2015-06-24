//
//  ListViewLoadOnDemand.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewLoadOnDemand: ExampleViewController, TKListViewDataSource, TKListViewDelegate {

    let listView = TKListView()
    let names = TKDataSource()
    let photos = TKDataSource()
    let loremIpsumGenerator = LoremIpsumGenerator()
    var lastRetrievedDataIndex = 15
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.addOption("Manual", inSection:"Load on demand mode") { self.loadOnDemandManual() }
        self.addOption("Auto", inSection:"Load on demand mode") { self.loadOnDemandAuto() }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.photos.loadDataFromJSONResource("PhotosWithNames", ofType: "json", rootItemKeyPath: "photos")
        self.names.loadDataFromJSONResource("PhotosWithNames", ofType: "json", rootItemKeyPath: "names")

        listView.frame = self.view.bounds
        listView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        listView.backgroundColor = UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.5)
        listView.dataSource = self
        listView.delegate = self
        listView.loadOnDemandBufferSize = 5
        listView.loadOnDemandMode = TKListViewLoadOnDemandMode.Manual
        listView.contentInset = UIEdgeInsetsMake(10, 10, 10, 10)
        self.view.addSubview(listView)
        listView.registerClass(CustomCardListViewCell.classForCoder(), forCellWithReuseIdentifier:"cell")
    
        let layout = listView.layout as! TKListViewLinearLayout
        layout.itemSize = CGSizeMake(100, 120)
        layout.itemSpacing = 5
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadOnDemandManual() {
        self.lastRetrievedDataIndex = 15
        self.listView.loadOnDemandMode = TKListViewLoadOnDemandMode.Manual
        self.listView.reloadData()
        self.listView.contentOffset = CGPoint.zeroPoint
    }

    
    func loadOnDemandAuto() {
        self.lastRetrievedDataIndex = 15
        self.listView.loadOnDemandMode = TKListViewLoadOnDemandMode.Auto
        self.listView.reloadData()
        self.listView.contentOffset = CGPoint.zeroPoint
    }
    
// MARK: TKListViewDataSource
    
    func listView(listView: TKListView!, numberOfItemsInSection section: Int) -> Int {
        return lastRetrievedDataIndex
    }
    
    func listView(listView: TKListView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> TKListViewCell! {
        
        var cell = listView.dequeueLoadOnDemandCellForIndexPath(indexPath)
        
        if (cell == nil) {
            cell = listView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TKListViewCell
            cell.imageView.image = UIImage(named: self.photos.items[indexPath.row] as! String)
            cell.textLabel.text = names.items[indexPath.row] as? String
            cell.detailTextLabel.text = loremIpsumGenerator.randomString(10 + Int(arc4random_uniform(16)), indexPath: indexPath) as String
            cell.detailTextLabel.textColor = UIColor.whiteColor()
        }
        
        cell.backgroundView?.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
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
            
            if self.lastRetrievedDataIndex == self.names.items.count {
                listView.loadOnDemandMode = TKListViewLoadOnDemandMode.None
            }
            
            listView.didLoadDataOnDemand()
        })
       })
        
        return true
    }
}
