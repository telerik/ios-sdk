//
//  ListViewAnimations.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewAnimations: TKExamplesExampleViewController {

    let listView = TKListView()
    let dataSource = TKDataSource()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.addOption("Scale in", action: scaleInSelected)
        self.addOption("Fade in", action: fadeInSelected)
        self.addOption("Slide in", action: slideInSelected)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource.loadDataFromJSONResource("ListViewSampleData", ofType: "json", rootItemKeyPath: "photos")
        
        self.dataSource.settings.listView.createCell { (listView: TKListView, indexPath: NSIndexPath, item: AnyObject) -> TKListViewCell! in
            return listView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TKListViewCell
        }

        self.dataSource.settings.listView.initCell { (listView: TKListView, indexPath: NSIndexPath, cell: TKListViewCell, item: AnyObject) -> Void in
            cell.imageView.image = UIImage(named: self.dataSource.items[indexPath.row] as! String)
        }

        self.listView.frame = self.view.bounds
        self.listView.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.listView.dataSource = self.dataSource
        self.listView.registerClass(AnimationListCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(self.listView)
        
        let layout = TKListViewGridLayout()
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            layout.spanCount = 3
        }
        else {
            layout.spanCount = 2
        }
        layout.itemSize = CGSizeMake(130, 180)
        layout.itemSpacing = 10
        layout.lineSpacing = 10
        
        // >> listview-alignment-swift
        layout.itemAlignment = TKListViewItemAlignment.Center
        // << listview-alignment-swift
        
        layout.itemAppearAnimation = TKListViewItemAnimation.Scale
        
        // >> listview-animation-duration-swift
        layout.animationDuration = 0.4
        // << listview-animation-duration-swift
        
        self.listView.layout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fadeInSelected() {
        let layout = listView.layout as! TKListViewLinearLayout
        layout.itemAppearAnimation = TKListViewItemAnimation.Fade
        layout.itemInsertAnimation = TKListViewItemAnimation.Fade
        layout.itemDeleteAnimation = TKListViewItemAnimation.Fade
    }
    
    func slideInSelected() {
        let layout = listView.layout as! TKListViewLinearLayout
        layout.itemAppearAnimation = TKListViewItemAnimation.Slide
         layout.itemInsertAnimation = TKListViewItemAnimation.Slide
        layout.itemInsertAnimation = TKListViewItemAnimation.Slide
    }
    
    func scaleInSelected() {
        let layout = listView.layout as! TKListViewLinearLayout
        // >> listview-appear-swift
        layout.itemAppearAnimation = TKListViewItemAnimation.Scale
        // << listview-appear-swift
        
        // >> listview-insert-swift
        layout.itemInsertAnimation = TKListViewItemAnimation.Scale
        // << listview-insert-swift
        
        // >> listview-delete-swift
        layout.itemInsertAnimation = TKListViewItemAnimation.Scale
        // << listview-delete-swift
        
    }
}
