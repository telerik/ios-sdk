//
//  ListViewWrapLayout.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewLayout: ExampleViewController, TKListViewStaggeredLayoutDelegate {
    
    let dataSource = TKDataSource()
    let listView = TKListView()
    let categories = ["breakfast", "paleo", "desserts"]
    var sizes = [Int]()
    var scrollDirection = TKListViewScrollDirection.Vertical
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Linear layout", inSection:"Layout") { self.linearLayoutSelected() }
        self.addOption("Grid layout", inSection:"Layout") { self.gridLayoutSelected() }
        self.addOption("Staggered layout", inSection:"Layout") { self.staggeredLayoutSelected() }
        self.addOption("Flow layout", inSection:"Layout") { self.wrapLayoutSelected() }
        
        self.addOption("Horizontal", inSection:"Orientation") { self.horizontalSelected() }
        self.addOption("Vertical", inSection:"Orientation") { self.verticalSelected() }
        
        self.setSelectedOption(1, section: 1)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        dataSource.loadDataFromJSONResource("ListItems", ofType: "json", rootItemKeyPath: "items")
        dataSource.addFilterDescriptor(TKDataSourceFilterDescriptor(query: "category LIKE '\(categories[0])' OR category LIKE '\(categories[1])' OR category LIKE '\(categories[2])'"))
        
        for i in 0..<dataSource.items.count {
            sizes.append(Int(50 + 5*(arc4random()%40)))
        }
        
        dataSource.reloadData()
        dataSource.groupWithKey("category")
        
        dataSource.settings.listView.createCell { (listView: TKListView!, indexPath: NSIndexPath!, item: AnyObject!) -> TKListViewCell! in
            return listView.dequeueReusableCellWithReuseIdentifier("custom", forIndexPath: indexPath) as! TKListViewCell
        }

        dataSource.settings.listView.initCell { (TKListView listView, NSIndexPath indexPath, TKListViewCell cell, AnyObject item) -> Void in
            cell.imageView.image = UIImage(named:item.objectForKey("photo") as! String)
            cell.textLabel.text = item.objectForKey("title") as? String
            cell.detailTextLabel.text = item.objectForKey("author") as? String
        }
        
        dataSource.settings.listView.initHeader { (TKListView listView, NSIndexPath indexPath, TKListViewHeaderCell headerCell, TKDataSourceGroup group) -> Void in
            headerCell.textLabel.textAlignment = NSTextAlignment.Center
            headerCell.textLabel.text = (group.key as? String)?.capitalizedString
            headerCell.backgroundColor = UIColor.lightGrayColor()
        }
        
        listView.frame = self.view.bounds
        listView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        listView.dataSource = self.dataSource
        listView.registerClass(CustomListCell.classForCoder(), forCellWithReuseIdentifier: "custom")

        self.view.addSubview(listView)
     
        self.linearLayoutSelected()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func linearLayoutSelected() {
        let layout = TKListViewLinearLayout()
        layout.itemSize = CGSizeMake(200, 200)
        layout.headerReferenceSize = CGSizeMake(100, 30)
        layout.itemSpacing = 1
        layout.scrollDirection = self.scrollDirection
        listView.layout = layout
    }
    
    func gridLayoutSelected() {
        let layout = TKListViewGridLayout()
        layout.itemSize = CGSizeMake(200, 100)
        layout.headerReferenceSize = CGSizeMake(100, 30)
        layout.spanCount = 2
        layout.itemSpacing = 1
        layout.lineSpacing = 1
        layout.scrollDirection = self.scrollDirection
        listView.layout = layout
    }

    func staggeredLayoutSelected() {
        let layout = TKListViewStaggeredLayout()
        layout.delegate = self
        layout.itemSize = CGSizeMake(200, 100)
        layout.headerReferenceSize = CGSizeMake(100, 30)
        layout.spanCount = 2
        layout.itemSpacing = 1
        layout.lineSpacing = 1
        layout.scrollDirection = self.scrollDirection
        layout.alignLastLine = true
        listView.layout = layout
    }
    
    func wrapLayoutSelected() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake((CGRectGetWidth(listView.bounds)-3)/3.0, CGRectGetHeight(listView.bounds)/4.0)
        layout.headerReferenceSize = CGSizeMake(100, 30)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        listView.layout = layout
        self.scrollDirection = TKListViewScrollDirection.Vertical
        self.setSelectedOption(1, section: 1)
    }
    
    func verticalSelected() {
        listView.scrollDirection = TKListViewScrollDirection.Vertical
        self.scrollDirection = TKListViewScrollDirection.Vertical
    }
    
    func horizontalSelected() {
        listView.scrollDirection = TKListViewScrollDirection.Horizontal
        self.scrollDirection = TKListViewScrollDirection.Horizontal
    }
    
    func staggeredLayout(layout: TKListViewStaggeredLayout!, sizeForItemAtIndexPath indexPath: NSIndexPath!) -> CGSize {
        if layout.scrollDirection == TKListViewScrollDirection.Vertical {
            return CGSizeMake(100, CGFloat(sizes[indexPath.row]))
        }
        else {
            return CGSizeMake(CGFloat(sizes[indexPath.row]), 100)
        }
    }
}
