//
//  ChartDocsSplineSeries.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ChartDocsSplineSeries: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let chart = TKChart(frame: self.view.bounds)
        self.view.addSubview(chart)
        
        // >> chart-spline
        var profitData = [TKChartDataPoint]()
        let profitValues = [10, 45, 8, 27, 57]
        let categories = ["Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green"]
        for i in 0 ..< categories.count {
            profitData.append(TKChartDataPoint(x: categories[i], y: profitValues[i]))
        }
        
        let seriesForProfit = TKChartSplineSeries(items: profitData)
        chart.addSeries(seriesForProfit)
        // << chart-spline-swift
    }

}
