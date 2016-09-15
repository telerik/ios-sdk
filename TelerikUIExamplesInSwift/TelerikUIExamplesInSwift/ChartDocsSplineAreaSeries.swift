//
//  ChartDocsSplineAreaSeries.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ChartDocsSplineAreaSeries: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let chart = TKChart(frame: CGRectInset(self.view.bounds, 10, 10))
        self.view.addSubview(chart)
        
        // >> chart-spline-area-swift
        let categories = ["Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" ];
        let values = [70, 75, 58, 59, 88]
        var pointsWithCategoriesAndValues = [TKChartDataPoint]()
        for i in 0 ..< categories.count {
            pointsWithCategoriesAndValues.append(TKChartDataPoint(x: categories[i], y: values[i]))
        }
        
        let series = TKChartSplineAreaSeries(items: pointsWithCategoriesAndValues)
        chart.addSeries(series)
        // << chart-spline-area-swift
    }
}
