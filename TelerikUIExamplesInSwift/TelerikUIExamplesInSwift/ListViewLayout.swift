//
//  ListViewWrapLayout.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit

class ListViewLayout: ExampleViewController {
    
    let photos = TKDataSource()
    let names = TKDataSource()
    let listView = TKListView()
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Wrap layout", inSection:"Layout") { self.wrapLayoutSelected() }
        self.addOption("Columns layout", inSection:"Layout") { self.columnsLayoutSelected() }
        
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
        self.photos.loadDataFromJSONResource("PhotosWithNames", ofType: "json", rootItemKeyPath: "photos")
        self.names.loadDataFromJSONResource("PhotosWithNames", ofType: "json", rootItemKeyPath: "names")
        
        photos.settings.listView.createCell { (listView: TKListView!, indexPath: NSIndexPath!, item: AnyObject!) -> TKListViewCell! in
            return listView.dequeueReusableCellWithReuseIdentifier("simpleCell", forIndexPath: indexPath) as! TKListViewCell
        }
        
        photos.settings.listView.initCell { (listView: TKListView!, indexPath: NSIndexPath!, cell: TKListViewCell!, item: AnyObject!) -> Void in
            cell.imageView.image = UIImage(named: self.photos.items[indexPath.row] as! String)
            cell.textLabel.text = self.names.items[indexPath.row] as? String
            let view = cell.backgroundView as! TKView
            view.stroke.strokeSides = listView.layout.isKindOfClass(TKListViewColumnsLayout) ? TKRectSide.Right | TKRectSide.Bottom : TKRectSide.All
            view.setNeedsDisplay()
        }
        listView.frame = self.view.bounds
        listView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        listView.dataSource = self.photos
        listView.registerClass(SimpleListViewCell.classForCoder(), forCellWithReuseIdentifier: "simpleCell")
        self.view.addSubview(listView)
        self.wrapLayoutSelected()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func wrapLayoutSelected() {
        listView.insets = UIEdgeInsetsMake(4, 4, 0, 4)
        let layout = TKListViewWrapLayout()
        layout.minimumLineSpacing = 4
        layout.minimumInteritemSpacing = 4
        layout.itemSize = CGSizeMake(100, 100)
        listView.layout = layout
        listView.reloadData()
    }
    
    func columnsLayoutSelected() {
        listView.insets = UIEdgeInsetsZero
        let layout = TKListViewColumnsLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSizeMake(100, 100)
        layout.columnsCount = 2
        listView.layout = layout
        listView.reloadData()
        
        listView.scrollDirection = TKListViewScrollDirection.Vertical
        self.setSelectedOption(1, section: 1)
    }
    
    func verticalSelected() {
        listView.scrollDirection = TKListViewScrollDirection.Vertical
        listView.layout.prepareLayout()
    }
    
    func horizontalSelected() {
        if(listView.layout .isKindOfClass(TKListViewColumnsLayout)) {
            self.setSelectedOption(1, section: 1)
            let alert = UIAlertView(title: "TKListView", message: "columns layout supports only vertical scroll direction", delegate: nil, cancelButtonTitle: "Close")
            alert.show()
            return
        }
        
        //Plese note that columns layout would not be affected by setting horizontal direction as it supports only vertical scroll direction.
        listView.scrollDirection = TKListViewScrollDirection.Horizontal
        listView.layout.prepareLayout()
    }
}
