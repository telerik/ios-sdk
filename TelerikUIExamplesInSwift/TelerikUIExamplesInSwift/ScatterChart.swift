//
//  ScatterChart.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class ScatterChart: TKExamplesExampleViewController {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        for i in 0..<2 {
            // >> chart-scatter-swift
            var points  = [TKChartDataPoint]()
            for _ in 0..<20 {
                let randomX = Int(arc4random()%1450)
                let randomY = Int(arc4random()%150)
                points.append(TKChartDataPoint(x:randomX, y:randomY))
            }
            let series = TKChartScatterSeries(items:points)
            // << chart-scatter-swift
            series.title = String(format:"Series % d", (i+1))
            if(2==i){
                series.selection = TKChartSeriesSelection.DataPoint
            }
            else{
                series.selection = TKChartSeriesSelection.Series
            }
            series.style.paletteMode = TKChartSeriesStylePaletteMode.UseItemIndex
            series.marginForHitDetection = 300
            chart.addSeries(series)
        }
    
        chart.xAxis!.allowPan = true
        chart.xAxis!.allowZoom = true
        chart.yAxis!.allowPan = true
        chart.yAxis!.allowZoom = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
