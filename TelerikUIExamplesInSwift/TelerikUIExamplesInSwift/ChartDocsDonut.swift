//
//  ChartDocsDonut.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ChartDocsDonut: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let chart = TKChart(frame: CGRectInset(self.view.bounds, 10, 10))
        self.view.addSubview(chart)
        // >> chart-dnt-swift
        var pointsWithValueAndName = [TKChartDataPoint]()
        pointsWithValueAndName.append(TKChartDataPoint(name: "Google", value: 20))
        pointsWithValueAndName.append(TKChartDataPoint(name: "Apple", value: 30))
        pointsWithValueAndName.append(TKChartDataPoint(name: "Microsoft", value: 10))
        pointsWithValueAndName.append(TKChartDataPoint(name: "IBM", value: 5))
        pointsWithValueAndName.append(TKChartDataPoint(name: "Oracle", value: 8))
        
        let series = TKChartDonutSeries(items: pointsWithValueAndName)
        series.innerRadius = 0.5
        
        chart.addSeries(series)
        chart.legend.hidden = false
        chart.legend.style.position = TKChartLegendPosition.Right
        // << chart-dnt-swift
    }

}
