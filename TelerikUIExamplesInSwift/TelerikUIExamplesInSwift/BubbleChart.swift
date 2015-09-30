//
//  BubbleChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class BubbleChart: ExampleViewController {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBoundsWithInset
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        for i in 0..<2 {
            var points = [TKChartBubbleDataPoint]()
            for _ in 0..<20 {
                let randomX = Int(arc4random()%1450)
                let randomY = Int(arc4random()%150)
                let area = Int(arc4random()%200)
                points.append(TKChartBubbleDataPoint(x:randomX, y:randomY, area:area))
            }
            let series = TKChartBubbleSeries(items: points)
            series.title = String(format:"Series %d", (i+1))
            series.scale = 1.5
            series.marginForHitDetection = CGFloat(2)
            if (i == 0) {
                series.selectionMode = TKChartSeriesSelectionMode.DataPoint
            } else {
                series.selectionMode = TKChartSeriesSelectionMode.Series
            }
            
            chart.addSeries(series)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
