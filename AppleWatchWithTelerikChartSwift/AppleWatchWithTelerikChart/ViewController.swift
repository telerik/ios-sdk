//
//  ViewController.swift
//  AppleWatchWithTelerikChart
//
//  Created by Nikolay Diyanov on 1/28/15.
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit
import WatchCoreDataProxy

class ViewController: UIViewController {

    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bounds = CGRectInset(self.view.bounds, 10, 10)
        chart.frame = CGRectInset(CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width, bounds.size.height / 2), 10, 10)
        self.view.addSubview(chart)
        
        let array:NSMutableArray = [
            TKChartDataPoint(name: "Google",value: 20),
            TKChartDataPoint(name: "Apple",value: 30),
            TKChartDataPoint(name: "Microsoft",value: 10),
            TKChartDataPoint(name: "IBM",value: 5),
            TKChartDataPoint(name: "Oracle",value: 8)]
        let series = TKChartPieSeries(items:array)
        chart.addSeries(series)
        
        UIGraphicsBeginImageContext(chart.bounds.size)
        chart.layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.sample"

        WatchCoreDataProxy.sharedInstance.sendImageToWatch(image)
        WatchCoreDataProxy.sharedInstance.sendStringToWatch("Pie")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

