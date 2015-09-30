//
//  ListViewReorder.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewReorder: ExampleViewController, TKListViewDelegate {

    let listView = TKListView()
    let dataSource = TKDataSource()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Reorder with handle") { self.reorderWithHandleSelected() }
        self.addOption("Reorder with long press") { self.reorderWithLongPressSelected() }
        self.addOption("Disable reorder mode") { self.disableReorderSelected() }
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource.allowItemsReorder = true
        self.dataSource.loadDataFromJSONResource("PhotosWithNames", ofType: "json", rootItemKeyPath: "names")
        
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            self.listView.frame = self.exampleBounds
        }
        else {
            self.listView.frame = self.view.bounds
        }
        self.listView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.listView.dataSource = self.dataSource
        self.listView.delegate = self
        self.listView.allowsCellReorder = true
        self.view.addSubview(self.listView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reorderWithHandleSelected() {
        self.listView.allowsCellReorder = true
        self.listView.reorderMode = TKListViewReorderMode.WithHandle
    }
    
    func reorderWithLongPressSelected() {
        self.listView.allowsCellReorder = true
        self.listView.reorderMode = TKListViewReorderMode.WithLongPress
    }
    
    func disableReorderSelected() {
        self.listView.allowsCellReorder = false
    }
    
    // MARK: - TKListViewDelegate
    
    func listView(listView: TKListView, willReorderItemAtIndexPath indexPath: NSIndexPath) {
        let cell = listView.cellForItemAtIndexPath(indexPath)
        cell!.backgroundView?.backgroundColor = UIColor.yellowColor()
    }
    
    func listView(listView: TKListView, didReorderItemFromIndexPath originalIndexPath: NSIndexPath, toIndexPath targetIndexPath: NSIndexPath) {
        let cell = listView.cellForItemAtIndexPath(originalIndexPath)
        cell!.backgroundView?.backgroundColor = UIColor.whiteColor()
        self.dataSource .listView(listView, didReorderItemFromIndexPath: originalIndexPath, toIndexPath: targetIndexPath)
    }
}
