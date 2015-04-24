//
//  ScatterChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class ScatterChart: ExampleViewController {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBoundsWithInset
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        self.view.addSubview(chart)
        
        for i in 0..<2 {
            var points  = [TKChartDataPoint]()
            for i in 0..<20 {
                let randomX = Int(arc4random()%1450)
                let randomY = Int(arc4random()%150)
                points.append(TKChartDataPoint(x:randomX, y:randomY))
            }
            let series = TKChartScatterSeries(items:points)
            series.title = String(format:"Series % d", (i+1))
            if(2==i){
                series.selectionMode = TKChartSeriesSelectionMode.DataPoint
            }
            else{
                series.selectionMode = TKChartSeriesSelectionMode.Series
            }
            series.style.paletteMode = TKChartSeriesStylePaletteMode.UseItemIndex
            series.marginForHitDetection = 300
            chart.addSeries(series)
        }
    
        chart.xAxis.allowPan = true
        chart.xAxis.allowZoom = true
        chart.yAxis.allowPan = true
        chart.yAxis.allowZoom = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
