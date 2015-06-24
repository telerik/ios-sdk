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
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.addOption("Selection on press", inSection:"Selection type") { self.selectionOnPressSelected() }
        self.addOption("Selection on hold", inSection:"Selection type") { self.selectionOnHoldSelected() }
        self.addOption("No selection", inSection:"Selection type") { self.noSelectionSelected() }
        
        self.addOption("YES", inSection:"Multiple selection") { self.multipleSelectionSelected() }
        self.addOption("NO", inSection:"Multiple selection") { self.singleSelectionSelected() }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource.loadDataFromJSONResource("ListViewSampleData", ofType: "json", rootItemKeyPath: "players")
        
        self.listView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 55)
        self.listView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.listView.registerClass(TKListViewCell.self, forCellWithReuseIdentifier:"cell")
        self.listView.delegate = self
        self.listView.dataSource = self.dataSource
        self.listView.selectionBehavior = TKListViewSelectionBehavior.Press
        self.listView.allowsMultipleSelection = true
        self.view.addSubview(self.listView)
        
        self.listView.selectItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.None)
        
        let layout = listView.layout as! TKListViewLinearLayout
        layout.itemAlignment = TKListViewItemAlignment.Stretch
        layout.itemSpacing = 0
        
        self.label.frame = CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)
        self.label.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleTopMargin
        self.label.textAlignment = NSTextAlignment.Center
        self.listView.addSubview(self.label)
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
        self.label.text = ""
        listView.clearSelectedItems()
    }
    
    func multipleSelectionSelected() {
        self.listView.allowsMultipleSelection = true
    }
    
    func singleSelectionSelected() {
        self.listView.allowsMultipleSelection = false
    }

// MARK: TKListViewDelegate
    
    func listView(listView: TKListView!, didHighlightItemAtIndexPath indexPath: NSIndexPath!) {
        println("Did highlight item at row\(indexPath.row)")
        let cell = listView.cellForItemAtIndexPath(indexPath)
        if !cell.selected && listView.selectionBehavior == TKListViewSelectionBehavior.LongPress {
            cell.selectedBackgroundView.hidden = true
        }
    }
    
    func listView(listView: TKListView!, didUnhighlightItemAtIndexPath indexPath: NSIndexPath!) {
        println("Did unhighlight item at row\(indexPath.row)")
    }
    
    func listView(listView: TKListView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        label.text = "Selected \(dataSource.items[indexPath.row])"
        println("Did select item at row\(indexPath.row)")
        let cell = listView.cellForItemAtIndexPath(indexPath)
        if cell != nil {
            cell.selectedBackgroundView.hidden = false
        }
    }
    
    func listView(listView: TKListView!, didDeselectItemAtIndexPath indexPath: NSIndexPath!) {
        println("Did deselect item at row\(indexPath.row)")

    }
}
