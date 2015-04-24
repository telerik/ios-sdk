//
//  BindWithCustomObject.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CustomObject : NSObject
{
    var objectID:Int?
    var value1:Float?
    var value2:Float?
    var value3:Float?

    override func valueForKey(key: String) -> AnyObject? {
        switch key {
            case "objectID":
                return self.objectID
            case "value1":
                return self.value1
            case "value2":
                return self.value2
            case "value3":
                return self.value3
        default:
            break
        }
       return super.valueForKey(key)
    }
}

class BindWithCustomObject: ExampleViewController {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBoundsWithInset
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)
        
        var data = [CustomObject]()
        for i in 0..<6 {
            let obj = CustomObject()
            obj.objectID = i
            obj.value1 = Float(arc4random() % (100))
            obj.value2 = Float(arc4random() % (100))
            obj.value3 = Float(arc4random() % (100))
            data.append(obj)
        }
        
        chart.addSeries(TKChartAreaSeries(items: data, forKeys: ["dataXValue": "objectID", "dataYValue": "value1"]))
        chart.addSeries(TKChartAreaSeries(items: data, forKeys: ["dataXValue": "objectID", "dataYValue": "value2"]))
        chart.addSeries(TKChartAreaSeries(items: data, xValueKey: "objectID", yValueKey: "value3"))
        
        var stackInfo = TKChartStackInfo(ID: 1, withStackMode: TKChartStackMode.Stack)
        for i in 0..<chart.series().count {
            let series = chart.series()[i] as! TKChartSeries
            series.selectionMode = TKChartSeriesSelectionMode.Series
            series.stackInfo = stackInfo
        }

        chart.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}