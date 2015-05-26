//
//  ListViewAnimations.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewAnimations: ExampleViewController {

    let listView = TKListView()
    let dataSource = TKDataSource()
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.addOption("Scale in") { self.scaleInSelected() }
        self.addOption("Fade in") { self.fadeInSelected() }
        self.addOption("Slide in") { self.slideInSelected() }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource.loadDataFromJSONResource("ListViewSampleData", ofType: "json", rootItemKeyPath: "photos")
        
        self.dataSource.settings.listView.createCell { (TKListView listView, NSIndexPath indexPath, AnyObject item) -> TKListViewCell! in
            return listView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TKListViewCell
        }
        
        self.dataSource.settings.listView.initCell { (listView: TKListView!, indexPath: NSIndexPath!, cell: TKListViewCell!, item: AnyObject!) -> Void in
            cell.imageView.image = UIImage(named: self.dataSource.items[indexPath.row] as! String)
        }

        self.listView.frame = self.view.bounds
        self.listView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
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
        layout.itemAlignment = TKListViewItemAlignment.Center
        layout.itemAppearAnimation = TKListViewItemAnimation.Scale
        layout.animationDuration = 0.4
        self.listView.layout = layout
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fadeInSelected() {
        let layout = listView.layout as! TKListViewLinearLayout
        layout.itemAppearAnimation = TKListViewItemAnimation.Fade
    }
    
    func slideInSelected() {
        let layout = listView.layout as! TKListViewLinearLayout
        layout.itemAppearAnimation = TKListViewItemAnimation.Slide
    }
    
    func scaleInSelected() {
        let layout = listView.layout as! TKListViewLinearLayout
        layout.itemAppearAnimation = TKListViewItemAnimation.Scale
    }
}
