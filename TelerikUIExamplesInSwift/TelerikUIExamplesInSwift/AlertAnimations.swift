//
//  AlertViewAnimations.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import Foundation

class AlertAnimations: ExampleViewController, TKListViewDelegate {

    let alert = TKAlert()

    let appearLabel = UILabel()
    let hideLabel = UILabel()
    let appearAnimationsList = TKListView()
    let hideAnimationsList = TKListView()
    let appearAnimations = TKDataSource(array: ["Scale in", "Fade in", "Slide from left", "Slide from top", "Slide from right", "Slide from bottom"])
    let hideAnimations = TKDataSource(array: ["Scale out", "Fade out", "Slide to left", "Slide to top", "Slide to right", "Slide to bottom"])
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        self.addOption("Show Alert") { self.show() }
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
  
        super.viewDidLoad()
        
        alert.title = "Animations"
        alert.style.backgroundStyle = TKAlertBackgroundStyle.Blur
    
        alert.addActionWithTitle("Close") { (TKAlert, TKAlertAction) -> Bool in
            return true
        }
        
        let block: TKDataSourceListViewSettings_InitCellWithItemBlock = { (listView: TKListView!, indexPath: NSIndexPath!, cell: TKListViewCell!, item: AnyObject!) -> Void in
            cell.textLabel.font = UIFont.systemFontOfSize(12)
            cell.textLabel.textAlignment = NSTextAlignment.Center
            cell.textLabel.text = item as? String
        
        }
        
        self.appearAnimations.settings.listView.initCell(block)
        self.hideAnimations.settings.listView.initCell(block)

        self.view.addSubview(TKListView())
        
        appearAnimationsList.frame = CGRectMake(0, 44, self.view.frame.size.width/2, self.view.frame.size.height)
        appearAnimationsList.dataSource = self.appearAnimations
        appearAnimationsList.delegate = self
        appearAnimationsList.tag = 0
        self.view.addSubview(appearAnimationsList)
        
        appearAnimationsList.selectItemAtIndexPath(NSIndexPath(forItem:3, inSection: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.None)
        
        hideAnimationsList.frame = CGRectMake(self.view.frame.size.width/2 , 108, self.view.frame.size.width/2, self.view.frame.size.height + 20)
        hideAnimationsList.dataSource = self.hideAnimations
        hideAnimationsList.delegate = self
        hideAnimationsList.tag = 1
        self.view.addSubview(hideAnimationsList)
        
        hideAnimationsList.selectItemAtIndexPath(NSIndexPath(forItem:5, inSection: 0), animated: false, scrollPosition: UICollectionViewScrollPosition.None)
    
        appearLabel.frame = CGRectMake(0, 70, self.view.frame.size.width/2, 30)
        appearLabel.text = "Show animation: "
        appearLabel.backgroundColor = UIColor.whiteColor()
        appearLabel.textColor = UIColor.blackColor()
        appearLabel.font = UIFont.systemFontOfSize(12)
        appearLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(appearLabel)
        
        hideLabel.frame = CGRectMake(self.view.frame.size.width/2, 70 , self.view.frame.size.width/2, 30)
        hideLabel.text = "Dismiss animation:"
        hideLabel.backgroundColor = UIColor.whiteColor()
        hideLabel.textColor = UIColor.blackColor()
        hideLabel.font = UIFont.systemFontOfSize(12)
        hideLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(hideLabel)
    }
    
    override func viewDidLayoutSubviews() {
        var titleHeight:CGFloat = 60.0
        if UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation) {
            titleHeight = 50.0
        }
        
        if UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad {
            titleHeight += 40;
        }
    
        let halfWidth:CGFloat = CGRectGetWidth(self.view.frame)/2.0
        appearLabel.frame = CGRectMake(0.0, titleHeight + 10.0, halfWidth, 20.0)
        hideLabel.frame = CGRectMake(halfWidth, titleHeight + 10.0, halfWidth, 20.0)
    
        let height:CGFloat = CGRectGetHeight(self.view.frame) - titleHeight - 50.0
    
        appearAnimationsList.frame = CGRectMake(0, titleHeight + 40, halfWidth, height)
        hideAnimationsList.frame = CGRectMake(halfWidth, titleHeight + 40, halfWidth, height)
    }
    
    func show() {
        
        let message = NSMutableString()
        
        if let selected = appearAnimationsList.indexPathsForSelectedItems {
            if (selected.count > 0) {
                let indexPath:NSIndexPath = selected[0] as! NSIndexPath
                message.appendString(String(format: "Alert did %@. \n", appearAnimations.items[indexPath.row] as! String))
            }
        }

        if let selected = hideAnimationsList.indexPathsForSelectedItems {
            if (selected.count > 0) {
                let indexPath:NSIndexPath = selected[0] as! NSIndexPath
                message.appendString(String(format: "It will %@ when closed. \n", appearAnimations.items[indexPath.row] as! String))
            }
        }
        
        alert.message = message as String
        
        alert.show(true)
    }
    
    //MARK: - TKListViewDelegate
    
    func listView(listView: TKListView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if(listView.tag == 0) {
            alert.style.showAnimation = TKAlertAnimation(rawValue: indexPath.row)!
        } else {
            alert.style.dismissAnimation = TKAlertAnimation(rawValue: indexPath.row)!
        }
    }
}
