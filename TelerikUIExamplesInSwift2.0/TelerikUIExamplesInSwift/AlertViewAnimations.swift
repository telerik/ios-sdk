//
//  AlertViewAnimations.swift
//  TelerikUIExamplesInSwift
//
//  Created by Sophia Lazarova on 6/11/15.
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import Foundation

class AlertViewAnimations: ExampleViewController, TKListViewDelegate, TKListViewDataSource {

    var _appearAnimations = ["Fade in", "Scale in", "Slide from top", "Slide from bottom", "Slide from left", "Slide from right"]

    var _hideAnimations = ["Fade out", "Scale out", "Slide to top", "Slide to bottom", "Slide to left", "Slide to right"]
    var _appearAnimationsList: TKListView?
    var _hideAnimationsList: TKListView?
    var _alertView: TKAlert?
    var _appearLabel: UILabel?
    var _hideLabel: UILabel?
    
    override func viewDidLoad() {
        self.setupListView()
        self.view.backgroundColor = UIColor.whiteColor()
       // _alertView = TKAlert(title: "Title", message: "Message", delegate: self, cancelActionTitle: "Cancel", otherActionTitles: "OK")
        _alertView?.style.backgroundStyle = TKAlertBackgroundStyle.Blur
    }
    
    func listView(listView: TKListView!, cellForItemAtIndexPath indexPath: NSIndexPath!) -> TKListViewCell! {
        let cell: TKListViewCell = listView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! TKListViewCell
        
        if(listView == _appearAnimationsList){
            cell.textLabel!.text = _appearAnimations[indexPath.row]
        }
        
        if (listView == _hideAnimationsList) {
            cell.textLabel!.text = _hideAnimations[indexPath.row]
        }
        
        cell.textLabel.font = UIFont.systemFontOfSize(12)
        cell.textLabel.textAlignment = NSTextAlignment.Center
        
        return cell
    }
    
    func listView(listView: TKListView!, numberOfItemsInSection section: Int) -> Int {
          return _appearAnimations.count;
    }
    
    func listView(listView: TKListView!, didSelectItemAtIndexPath indexPath: NSIndexPath!) {
        if(listView == _appearAnimationsList) {
                    switch (indexPath.row) {
                    case 0:
                        _alertView!.style.appearAnimation = TKAlertAnimation.Fade
                        break;
                    case 1:
                        _alertView!.style.appearAnimation = TKAlertAnimation.Scale
                        break;
                    case 2:
                        _alertView!.style.appearAnimation = TKAlertAnimation.SlideFromTop
                        break;
                    case 3:
                        _alertView!.style.appearAnimation = TKAlertAnimation.SlideFromBottom
                        break;
                    case 4:
                        _alertView!.style.appearAnimation = TKAlertAnimation.SlideFromLeft
                        break;
                    case 5:
                        _alertView!.style.appearAnimation = TKAlertAnimation.SlideFromRight
                        break;
                    default:
                        break;
                    }
                }
            
                if(listView == _hideAnimationsList) {
                    switch (indexPath.row) {
                    case 0:
                        _alertView!.style.hideAnimation = TKAlertAnimation.Fade
                        break;
                    case 1:
                        _alertView!.style.hideAnimation = TKAlertAnimation.Scale
                        break;
                    case 2:
                        _alertView!.style.hideAnimation = TKAlertAnimation.SlideFromTop
                        break;
                    case 3:
                        _alertView!.style.hideAnimation = TKAlertAnimation.SlideFromBottom
                        break;
                    case 4:
                        _alertView!.style.hideAnimation = TKAlertAnimation.SlideFromLeft
                        break;
                    case 5:
                        _alertView!.style.hideAnimation = TKAlertAnimation.SlideFromRight
                        break;
                    default:
                        break;
            }
        }
    }
    
    func show(sender: AnyObject)
    {
       _alertView?.show(true)
    }
    
    func setupListView() {
        _appearAnimationsList = TKListView(frame: CGRectMake(0, 26, self.view.frame.size.width/2, self.view.frame.size.height))
        _appearAnimationsList?.dataSource = self
        _appearAnimationsList?.delegate = self
        self.view.addSubview(_appearAnimationsList!)
        _appearAnimationsList?.registerClass(TKListViewCell.self, forCellWithReuseIdentifier: "cell")
        
        _hideAnimationsList = TKListView(frame: CGRectMake(self.view.frame.size.width/2, 90, self.view.frame.size.width/2, self.view.frame.size.height))
        
        _hideAnimationsList?.dataSource = self
        _hideAnimationsList?.delegate = self
        self.view.addSubview(_hideAnimationsList!)
        _hideAnimationsList?.registerClass(TKListViewCell.self, forCellWithReuseIdentifier: "cell")
        
        _appearLabel = UILabel(frame: CGRectMake(0, 70, self.view.frame.size.width/2, 12))
        _appearLabel!.text = "Show animation: "
        _appearLabel?.textColor = UIColor.blackColor()
        _appearLabel?.font = UIFont.systemFontOfSize(12)
        _appearLabel?.textAlignment = NSTextAlignment.Center
        self.view.addSubview(_appearLabel!)
        
        _hideLabel = UILabel(frame: CGRectMake(self.view.frame.size.width/2, 70 , self.view.frame.size.width/2, 12))
        _hideLabel!.text = "Dismiss animation:"
        _hideLabel!.textColor = UIColor.blackColor()
        _hideLabel!.font = UIFont.systemFontOfSize(12)
        _hideLabel!.textAlignment = NSTextAlignment.Center
        self.view.addSubview(_hideLabel!)
        
        let button: UIButton = UIButton(type:UIButtonType.System)
        button.addTarget(self, action: "show:", forControlEvents: UIControlEvents.TouchUpInside)
        button.setTitle("Show Alert", forState: UIControlState.Normal)
        button.backgroundColor = UIColor(red: 0.5, green: 0.7, blue: 0.2, alpha: 0.7)
        button.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont(name: "GillSans", size: 18)
        button.frame = CGRectMake((self.view.frame.size.width - 160)/2, 450.0, 160.0, 80.0)
        button.layer.cornerRadius = 80
        button.clipsToBounds = true
        self.view.addSubview(button)

    }
    
}