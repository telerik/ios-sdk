//
//  ViewController.swift
//  AppleWatchWithTelerikChart
//
//  Created by Nikolay Diyanov on 1/28/15.
//  Copyright (c) 2015 Telerik. All rights reserved.
//

import UIKit
import WatchCoreDataProxy

class ViewController: UIViewController, TKChartDelegate {

    @IBOutlet weak var label: UILabel!
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bounds = CGRectInset(self.view.bounds, 10, 10)
        chart.frame = CGRectInset(CGRectMake(bounds.origin.x, bounds.origin.y + 100, bounds.size.width, bounds.size.height / 2), 10, 10)
        chart.backgroundColor = UIColor.blackColor()
        chart.delegate = self
        self.view.addSubview(chart)
        
        let array = [
            TKChartDataPoint(name: "Germany",value: 20),
            TKChartDataPoint(name: "USA",value: 30),
            TKChartDataPoint(name: "Canada",value: 10),
            TKChartDataPoint(name: "UK",value: 5),
            TKChartDataPoint(name: "France",value: 8)]
        let series = TKChartPieSeries(items:array)
        series.style.pointLabelStyle.textHidden = false
        series.style.pointLabelStyle.textColor = UIColor.whiteColor()
        chart.addSeries(series)
        
        UIGraphicsBeginImageContext(chart.bounds.size)
        chart.layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        WatchCoreDataProxy.sharedInstance.sharedAppGroup = "group.watch.sample"

        WatchCoreDataProxy.sharedInstance.sendImageToWatch(image)
        WatchCoreDataProxy.sharedInstance.sendStringToWatch(label.text!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func chart(chart: TKChart!, textForLabelAtPoint dataPoint: TKChartData!, inSeries series: TKChartSeries!, atIndex dataIndex: UInt) -> String! {
        return dataPoint.dataName!()
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

