//
//  ListViewPullToRefresh.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewPullToRefresh: ExampleViewController, TKListViewDataSource, TKListViewDelegate {

    let dataSource = TKDataSource()
    var data = [String]()
    var newItemsCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.translucent = false
        
        // Do any additional setup after loading the view.
        dataSource.loadDataFromJSONResource("ListViewSampleData", ofType:"json", rootItemKeyPath: "teams")
        dataSource.groupItemSourceKey = "items"
        dataSource.filterWithQuery("key like 'Marketing'")
        dataSource.groupWithKey("key")
        self.updateData(3)
        
        let listView = TKListView(frame: self.view.bounds)
        listView.autoresizingMask = UIViewAutoresizing(rawValue:UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        listView.dataSource = self
        listView.delegate = self
        listView.allowsPullToRefresh = true
        listView.pullToRefreshTreshold = 70
        listView.pullToRefreshView.backgroundColor = UIColor.blueColor()
        listView.pullToRefreshView.activityIndicator.color = UIColor.whiteColor()
        listView.registerClass(TKListViewCell.classForCoder() , forCellWithReuseIdentifier: "cell")
        self.view.addSubview(listView)
    }

    override func willMoveToParentViewController(parent: UIViewController?) {
        if parent == nil {
            self.navigationController?.navigationBar.translucent = true
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateData(count: NSInteger) -> Int {
      let group = dataSource.items[0] as! TKDataSourceGroup
      let startIndex = data.count
      var i = 0
        for ; i < count; i++ {
            if(i + startIndex >= group.items.count){
                return i
            }
            let points = arc4random() % 100
            data.insert("\(group.items[i + startIndex]) \(points) points", atIndex: 0)
        }
        return i
    }
    
    func isUpdated(indexPath: NSIndexPath) -> Bool {
      return indexPath.row < newItemsCount
    }
    
// MARK: - TKListViewDataSource
    
    func listView(listView: TKListView!, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func listView(listView: TKListView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> TKListViewCell! {
        let cell = listView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TKListViewCell
        let isUpdated = self.isUpdated(indexPath)
        cell.textLabel.text = data[indexPath.row]
        let backgroundView : UIView = cell.backgroundView!
        backgroundView.backgroundColor = isUpdated ? UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 0.4): UIColor.whiteColor()
        backgroundView.alpha = isUpdated ? 0.0 : 1.0
        if(isUpdated){
           UIView.animateWithDuration(NSTimeInterval(0.5), animations: { () -> Void in
               backgroundView.alpha = 1
           })
        }
        return cell
    }
    
// MARK: - TKListViewDelegate
    
    func listView(listView: TKListView!, didPullWithOffset offset: CGFloat) {
        listView.pullToRefreshView.alpha = min(offset/listView.pullToRefreshTreshold, 1.0)
    }
    
    func listViewShouldRefreshOnPull(listView: TKListView!) -> Bool {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            
            self.newItemsCount = self.updateData(1 + Int(arc4random() % 3))
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC))), dispatch_get_main_queue(), { () -> Void in
                listView.didRefreshOnPull()
                
                if(self.newItemsCount < 1){
                 let alert = UIAlertView(title: "Pull to refresh", message: "No more data available", delegate: nil, cancelButtonTitle: "Close")
                    alert.show()
                }
            })
        })
        return true
    }
}
