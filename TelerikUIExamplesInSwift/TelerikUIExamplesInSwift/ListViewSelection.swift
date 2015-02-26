//
//  ListViewSelection.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewSelection: ExampleViewController, TKListViewDelegate {

    let label = UILabel()
    let listView = TKListView()
    let dataSource = TKDataSource()
    
    override init() {
        super.init()

        self.addOption("Selection on press", inSection:"Selection type") { self.selectionOnPressSelected() }
        self.addOption("Selection on hold", inSection:"Selection type") { self.selectionOnHoldSelected() }
        self.addOption("No selection", inSection:"Selection type") { self.noSelectionSelected() }
        
        self.addOption("YES", inSection:"Multiple selection") { self.multipleSelectionSelected() }
        self.addOption("NO", inSection:"Multiple selection") { self.singleSelectionSelected() }
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource.loadDataFromJSONResource("ListViewSampleData", ofType: "json", rootItemKeyPath: "players")

        self.label.frame = CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)
        self.label.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin
        self.label.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.label)
        
        self.listView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - self.label.frame.size.height - 55)
        self.listView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.listView.registerClass(TKListViewCell.self, forCellWithReuseIdentifier:"cell")
        self.listView.delegate = self
        self.listView.dataSource = self.dataSource
        self.listView.selectionBehavior = TKListViewSelectionBehavior.Press
        self.listView.allowsMultipleSelection = true
        self.view.addSubview(self.listView)
        
        self.listView.selectItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.None)
        
        let layout : TKListViewColumnsLayout = listView.layout as TKListViewColumnsLayout
        layout.cellAlignment = TKListViewCellAlignment.Stretch
        layout.minimumLineSpacing = 0
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selectionOnPressSelected() {
        self.listView.selectionBehavior = TKListViewSelectionBehavior.Press
        
    }
    
    func selectionOnHoldSelected() {
        self.listView.selectionBehavior = TKListViewSelectionBehavior.LongPress
    }
    
    func noSelectionSelected() {
        self.listView.selectionBehavior = TKListViewSelectionBehavior.None
        listView.clearSelectedItems()
    }
    
    func multipleSelectionSelected() {
        self.listView.allowsMultipleSelection = true
    }
    
    func singleSelectionSelected() {
        self.listView.allowsMultipleSelection = false
    }

// MARK: TKListViewDelegate
    
    func listView(listView: TKListView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
       label.text = "Selected \(dataSource.items[indexPath.row])"
        NSLog("Did select item at row\(indexPath.row)")
    }
    
    func listView(listView: TKListView!, didDeselectItemAtIndexPath indexPath: NSIndexPath!) {
        NSLog("Did deselect item at row\(indexPath.row)")

    }
}
