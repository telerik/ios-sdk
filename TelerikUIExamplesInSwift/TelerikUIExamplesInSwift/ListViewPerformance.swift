//
//  ListViewPerformance.swift
//  TelerikUIExamplesInSwift
//
//  Created by wfmac on 12/1/15.
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewPerformance: TKExamplesExampleViewController, TKListViewDataSource {

    var items = [NSString]()
    var listView:TKListView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let generator = LoremIpsumGenerator()
        for _ in 0..<10000 {
            items.append(generator.generateString(3 + Int(arc4random()%50) + Int(arc4random()%30)))
        }
        
        let button = UIButton(type:UIButtonType.System)
        button.frame = CGRectMake(20, self.view.center.y - 22, CGRectGetWidth(self.view.frame)-40, 44);
        button.autoresizingMask = [ .FlexibleWidth, .FlexibleTopMargin, .FlexibleBottomMargin ]
        button.setTitle("Load 10000 items", forState:UIControlState.Normal)
        button.addTarget(self, action:#selector(ListViewPerformance.loadItemsTouched(_:)), forControlEvents:.TouchUpInside)
        self.view.addSubview(button)
    }
    
    func loadItemsTouched(sender:UIButton) {
        let systemVersion = (UIDevice.currentDevice().systemVersion as NSString).floatValue
        if (systemVersion < 9) {
            let alert = TKAlert()
            alert.title = "Telerik UI"
            alert.message = "TKListView is optimized for performance when using dynamic item sizing only when running on iOS 9 and upper!"
            alert.addAction(TKAlertAction(title: "OK", handler: { (alert:TKAlert, action:TKAlertAction) -> Bool in
                self.createListView()
                return true
            }))
            alert.show(true)
        }
        else {
            self.createListView()
        }
        
        sender.removeFromSuperview()
    }

    func createListView() {
        let listView = TKListView(frame:self.view.bounds)
        listView.autoresizingMask = [ .FlexibleWidth, .FlexibleHeight ]
        listView.registerClass(ListViewDynamicSizeCell.self, forCellWithReuseIdentifier:"cell")
        self.view.addSubview(listView)
        
        let layout = listView.layout as! TKListViewLinearLayout
        layout.dynamicItemSize = true
        
        listView.dataSource = self;
        
        self.listView = listView;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //pragma mark - TKListViewDataSource
    
    func listView(listView: TKListView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func listView(listView: TKListView, cellForItemAtIndexPath indexPath: NSIndexPath) -> TKListViewCell? {
        let cell = listView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath:indexPath) as! ListViewDynamicSizeCell
        cell.label!.text = self.items[indexPath.row] as String
        return cell
    }
}
