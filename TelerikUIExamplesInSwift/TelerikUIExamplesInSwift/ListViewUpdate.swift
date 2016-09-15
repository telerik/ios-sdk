//
//  ListViewUpdate.swift
//  TelerikUIExamplesInSwift
//
//  Created by wfmac on 12/1/15.
//  Copyright © 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewUpdate: TKExamplesExampleViewController, TKListViewDelegate {
    
    let toolbar = UIToolbar()
    let listView = TKListView()
    let dataSource = TKDataSource()
    var items = [String]()
    var added = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<3 {
            self.addItem()
        }
        
        self.dataSource.itemSource = self.items
        
        self.toolbar.frame = CGRectMake(0, self.view.bounds.origin.y, CGRectGetWidth(self.view.frame), 44)
        self.toolbar.items = [
            UIBarButtonItem(barButtonSystemItem:.FlexibleSpace, target:nil, action:nil),
            UIBarButtonItem(title:"Add", style:.Plain, target:self, action:#selector(ListViewUpdate.addTouched)),
            UIBarButtonItem(barButtonSystemItem:.FlexibleSpace, target:nil, action:nil),
            UIBarButtonItem(title:"Remove", style:.Plain, target:self, action:#selector(ListViewUpdate.removeTouched)),
            UIBarButtonItem(barButtonSystemItem:.FlexibleSpace, target:nil, action:nil),
            UIBarButtonItem(title:"Update", style:.Plain, target:self, action:#selector(ListViewUpdate.updateTouched)),
            UIBarButtonItem(barButtonSystemItem:.FlexibleSpace, target:nil, action:nil),
        ]
        self.toolbar.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        self.view.addSubview(self.toolbar)
        
        self.listView.frame = CGRectMake(0, self.view.bounds.origin.y + 44,
            CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.bounds) - 44)
        self.listView.autoresizingMask = [ .FlexibleWidth, .FlexibleHeight ]
        self.listView.dataSource = self.dataSource
        self.listView.delegate = self
        self.view.addSubview(listView)
        
        self.toolbar.items![3].enabled = false
        self.toolbar.items![5].enabled = false
    }
    
    func addItem() {
        self.items.append("Item \(added+1)")
        self.dataSource.itemSource = self.items
        added += 1
    }
    
    func addTouched() {
        self.addItem()
        let indexPath = NSIndexPath(forItem: self.items.count-1, inSection: 0)
        
        // >> listview-insert-item-swift
        self.listView.insertItemsAtIndexPaths([ indexPath ])
        // << listview-insert-item-swift
        
        self.listView.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .CenteredVertically)
    }
    
    func removeTouched() {
        let selectedItemsPaths = self.listView.indexPathsForSelectedItems!
        if selectedItemsPaths.count > 0 {
            let indexPath = selectedItemsPaths[0] as! NSIndexPath
            self.items.removeAtIndex(indexPath.row)
            self.dataSource.itemSource = self.items
            
            // >> listview-delete-item-swift
            self.listView.deleteItemsAtIndexPaths(selectedItemsPaths)
            // << listview-delete-item-swift
            
            if (indexPath.row < self.items.count) {
                self.listView.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .CenteredVertically)
            }
            else {
                self.listView.selectItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0),
                    animated: false, scrollPosition: .CenteredVertically)
            }
        }
    }
    
    func updateTouched() {
        let selectedItems = self.listView.indexPathsForSelectedItems!
        if selectedItems.count > 0 {
            let indexPath = selectedItems[0] as! NSIndexPath
            self.items[indexPath.row] = "updated"
            self.dataSource.itemSource = self.items
            self.listView.reloadItemsAtIndexPaths(selectedItems)
            self.listView.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: .CenteredVertically)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //pragma mark - TKListViewDelegate
    
    func listView(listView: TKListView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.toolbar.items![3].enabled = true
        self.toolbar.items![5].enabled = true
    }
}
