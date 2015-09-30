//
//  CustomAnnotation.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class CustomAnnotation: ExampleViewController {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBoundsWithInset
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let values = [95, 40, 55, 30, 76, 34]
        var array = [TKChartDataPoint]()
        for i in 0..<months.count {
            array.append(TKChartDataPoint(x: months[i], y: values[i]))
        }
        let series = TKChartAreaSeries(items: array)
        series.style.pointShape = TKPredefinedShape(type: TKShapeType.Circle, andSize: CGSizeMake(10, 10))
        chart.addSeries(series)
        
        let shape = TKPredefinedShape(type: TKShapeType.Star, andSize: CGSizeMake(20, 20))
        let a = MyAnnotation(Shape: shape, X: "Mar", Y: 60, forSeries: series)
        a.fill = TKSolidFill(color: UIColor.blueColor())
        a.stroke = TKStroke(color: UIColor.yellowColor(), width: 3)
        chart.addAnnotation(a)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
