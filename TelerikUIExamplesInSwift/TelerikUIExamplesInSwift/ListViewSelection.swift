//
//  ListViewSelection.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewSelection: TKExamplesExampleViewController, TKListViewDelegate {

    let label = UILabel()
    let listView = TKListView()
    let dataSource = TKDataSource()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.addOption("Selection on press", inSection:"Selection type", withAction: selectionOnPressSelected)
        self.addOption("Selection on hold", inSection:"Selection type", withAction:selectionOnHoldSelected)
        self.addOption("No selection", inSection:"Selection type", withAction:noSelectionSelected)
        
        self.addOption("YES", inSection:"Multiple selection", withAction:multipleSelectionSelected)
        self.addOption("NO", inSection:"Multiple selection", withAction:singleSelectionSelected)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource.loadDataFromJSONResource("ListViewSampleData", ofType: "json", rootItemKeyPath: "players")
        
        self.listView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height - 55)
        self.listView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.listView.registerClass(TKListViewCell.self, forCellWithReuseIdentifier:"cell")
        self.listView.delegate = self
        self.listView.dataSource = self.dataSource
        
        // >> listview-selection-behavior-swift
        self.listView.selectionBehavior = TKListViewSelectionBehavior.Press
        // << listview-selection-behavior-swift
        
        // >> listview-multiple-selection-swift
        self.listView.allowsMultipleSelection = true
        // << listview-multiple-selection-swift
        
        self.view.addSubview(self.listView)
        
        // >> listview-selection-programatically-swift
        self.listView.selectItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.None)
        // << listview-selection-programatically-swift
        
        let layout = listView.layout as! TKListViewLinearLayout
        layout.itemAlignment = TKListViewItemAlignment.Stretch
        layout.itemSpacing = 0
        
        self.label.frame = CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)
        self.label.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleTopMargin.rawValue)
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
        // >> listview-selection-behavior-long-swift
        self.listView.selectionBehavior = TKListViewSelectionBehavior.LongPress
        // << listview-selection-behavior-long-swift
    }
    
    func noSelectionSelected() {
        // >> listview-selection-behavior-none-swift
        self.listView.selectionBehavior = TKListViewSelectionBehavior.None
        // << listview-selection-behavior-none-swift
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
    

    func listView(listView: TKListView, didHighlightItemAtIndexPath indexPath: NSIndexPath) {
        print("Did highlight item at row\(indexPath.row)")
        let cell = listView.cellForItemAtIndexPath(indexPath)!
        if !cell.selected && listView.selectionBehavior == TKListViewSelectionBehavior.LongPress {
            cell.selectedBackgroundView!.hidden = true
        }
    }
    
    func listView(listView: TKListView, didUnhighlightItemAtIndexPath indexPath: NSIndexPath) {
        print("Did unhighlight item at row\(indexPath.row)")
    }
    
    // >> listview-respond-swift
    func listView(listView: TKListView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        label.text = "Selected \(dataSource.items[indexPath.row])"
        print("Did select item at row\(indexPath.row)")
        if let cell = listView.cellForItemAtIndexPath(indexPath) {
            cell.selectedBackgroundView!.hidden = false
        }
    }
    
    func listView(listView: TKListView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        print("Did deselect item at row\(indexPath.row)")
    }
    
    // << listview-respond-swift
}
