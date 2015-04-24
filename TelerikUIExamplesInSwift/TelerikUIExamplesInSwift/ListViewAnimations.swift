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
        self.addOption("Fade + Scale in") { self.dafePlusScaleSelected() }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.dataSource.loadDataFromJSONResource("ListViewSampleData", ofType: "json", rootItemKeyPath: "photos")
        self.dataSource.settings.listView.initCell { (listView: TKListView!, indexPath: NSIndexPath!, cell: TKListViewCell!, item: AnyObject!) -> Void in
            cell.imageView.image = UIImage(named: self.dataSource.items[indexPath.row] as! String)
            let view : TKView = cell.backgroundView as! TKView
            view.stroke.width = 0
            
            cell.imageView.layer.shadowColor = UIColor(red: 0.27, green: 0.27, blue: 0.55, alpha: 1.0).CGColor
            cell.imageView.layer.shadowOffset = CGSizeMake(2, 2)
            cell.imageView.layer.shadowOpacity = 0.5
            cell.imageView.layer.shadowRadius = 3

        }
        self.listView.frame = self.view.bounds
        self.listView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.listView.dataSource = self.dataSource
        self.listView.cellAppearBehavior = TKListViewCellAppearBehavior()
        self.view.addSubview(self.listView)
        let layout = listView.layout as! TKListViewColumnsLayout
        layout.itemSize = CGSizeMake(130, 180)
        layout.minimumLineSpacing = 10
        layout.cellAlignment = TKListViewCellAlignment.Stretch
        self.scaleInSelected()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fadeInSelected() {
        self.listView.cellAppearBehavior = TKListViewCellFadeInBehavior()
    }
    
    func slideInSelected() {
        self.listView.cellAppearBehavior = TKListViewCellSlideInBehavior()
    }
    
    func scaleInSelected() {
        self.listView.cellAppearBehavior = TKListViewCellScaleInBehavior()
    }
    
    func dafePlusScaleSelected() {
        self.listView.cellAppearBehavior = TKListViewCellFadeInBehavior()
        self.listView.cellAppearBehavior.addChildBehavior(TKListViewCellScaleInBehavior())
    }
}
