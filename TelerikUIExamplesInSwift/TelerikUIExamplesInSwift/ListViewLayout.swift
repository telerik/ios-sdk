//
//  ListViewWrapLayout.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewLayout: TKExamplesExampleViewController, TKListViewLinearLayoutDelegate {
    
    let dataSource = TKDataSource()
    let listView = TKListView()
    let categories = ["breakfast", "paleo", "desserts"]
    var sizes = [Int]()
    var scrollDirection = TKListViewScrollDirection.Vertical
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Linear layout", inSection:"Layout", withAction: linearLayoutSelected)
        self.addOption("Grid layout", inSection:"Layout", withAction: gridLayoutSelected)
        self.addOption("Staggered layout", inSection:"Layout", withAction: staggeredLayoutSelected)
        self.addOption("Flow layout", inSection:"Layout", withAction: wrapLayoutSelected)
        
        self.addOption("Horizontal", inSection:"Orientation", withAction: horizontalSelected)
        self.addOption("Vertical", inSection:"Orientation", withAction: verticalSelected)
        
        self.setSelectedOption(1, inSection: 1)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.

        dataSource.loadDataFromJSONResource("ListItems", ofType: "json", rootItemKeyPath: "items")
        dataSource.addFilterDescriptor(TKDataSourceFilterDescriptor(query: "category LIKE '\(categories[0])' OR category LIKE '\(categories[1])' OR category LIKE '\(categories[2])'"))
        
        for _ in 0..<dataSource.items.count {
            sizes.append(Int(50 + 5*(arc4random()%40)))
        }
        
        dataSource.reloadData()
        dataSource.groupWithKey("category")
        
        dataSource.settings.listView.createCell { (listView: TKListView!, indexPath: NSIndexPath!, item: AnyObject!) -> TKListViewCell! in
            return listView.dequeueReusableCellWithReuseIdentifier("custom", forIndexPath: indexPath) as! TKListViewCell
        }

        dataSource.settings.listView.initCell { (listView: TKListView, indexPath: NSIndexPath, cell: TKListViewCell, item: AnyObject) -> Void in
            cell.imageView.image = UIImage(named:item.objectForKey("photo") as! String)
            cell.textLabel.text = item.objectForKey("title") as? String
            cell.detailTextLabel.text = item.objectForKey("author") as? String
        }
        
        dataSource.settings.listView.initHeader { (listView: TKListView, indexPath: NSIndexPath, headerCell: TKListViewHeaderCell, group: TKDataSourceGroup?) -> Void in
            headerCell.textLabel.textAlignment = NSTextAlignment.Center
            headerCell.textLabel.text = (group!.key as? String)?.capitalizedString
            headerCell.backgroundColor = UIColor.lightGrayColor()
        }
        
        listView.frame = self.view.bounds
        listView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
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
        // >> listview-linear-swift
        let layout = TKListViewLinearLayout()
        layout.itemSize = CGSizeMake(200, 200)
        layout.headerReferenceSize = CGSizeMake(100, 30)
        layout.itemSpacing = 1
        layout.scrollDirection = self.scrollDirection
        listView.layout = layout
        // << listview-linear-swift
    }
    
    func gridLayoutSelected() {
        // >> listview-grid-swift
        let layout = TKListViewGridLayout()
        layout.itemSize = CGSizeMake(200, 100)
        layout.headerReferenceSize = CGSizeMake(100, 30)
        layout.spanCount = 2
        layout.itemSpacing = 1
        layout.lineSpacing = 1
        layout.scrollDirection = self.scrollDirection
        listView.layout = layout
        // << listview-grid-swift
    }

    func staggeredLayoutSelected() {
        // >> listview-staggered-swift
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
        // << listview-staggered-swift
    }
    
    func wrapLayoutSelected() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSizeMake((CGRectGetWidth(listView.bounds)-3)/3.0, CGRectGetHeight(listView.bounds)/4.0)
        layout.headerReferenceSize = CGSizeMake(100, 30)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 1
        listView.layout = layout
        self.scrollDirection = TKListViewScrollDirection.Vertical
        self.setSelectedOption(1, inSection: 1)
    }
    
    func verticalSelected() {
        listView.scrollDirection = TKListViewScrollDirection.Vertical
        self.scrollDirection = TKListViewScrollDirection.Vertical
    }
    
    func horizontalSelected() {
        listView.scrollDirection = TKListViewScrollDirection.Horizontal
        self.scrollDirection = TKListViewScrollDirection.Horizontal
    }

    // >> listview-staggered-size-swift
    func listView(listView: TKListView, layout: TKListViewLinearLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if layout.scrollDirection == TKListViewScrollDirection.Vertical {
            return CGSizeMake(100, CGFloat(sizes[indexPath.row]))
        }
        else {
            return CGSizeMake(CGFloat(sizes[indexPath.row]), 100)
        }
    }
    // << listview-staggered-size-swift
}
