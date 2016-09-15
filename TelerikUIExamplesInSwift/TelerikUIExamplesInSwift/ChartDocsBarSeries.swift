//
//  ChartDocsBarSeries.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ChartDocsBarSeries: UIViewController {
    
    var pointsWithCategoriesAndValues = [TKChartDataPoint]()
    var pointsWithCategoriesAndValues2 = [TKChartDataPoint]()
    var chart:TKChart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chart.frame = CGRectInset(self.view.bounds, 10, 10)
        self.view.addSubview(chart)
        
        let categories = ["Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" ];
        let values = [70, 75, 58, 59, 88]
        for i in 0 ..< categories.count {
            pointsWithCategoriesAndValues.append(TKChartDataPoint(x: values[i], y: categories[i]))
        }
        
        let values2 = [40, 80, 32, 69, 95]
        for i in 0 ..< categories.count {
            pointsWithCategoriesAndValues2.append(TKChartDataPoint(x: values2[i], y: categories[i]))
        }
    }
    
    func simpleBarChart() {
        // >> chart-bar-width-swift
        let series = TKChartBarSeries(items: pointsWithCategoriesAndValues)
        series.minBarHeight = 20
        series.maxBarHeight = 50
        chart.addSeries(series)
        // << chart-bar-width-swift
    }
    
    func clusteredBarSeries() {
        // >> chart-bar-cls-swift
        let categories = ["Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" ];
        let categoryAxis = TKChartCategoryAxis(categories: categories)
        chart.yAxis = categoryAxis
        
        let series1 = TKChartBarSeries(items: pointsWithCategoriesAndValues)
        series1.yAxis = categoryAxis
        
        let series2 = TKChartBarSeries(items: pointsWithCategoriesAndValues2)
        series2.yAxis = categoryAxis
        
        chart.beginUpdates()
        chart.addSeries(series1)
        chart.addSeries(series2)
        chart.endUpdates()
        // << chart-bar-cls-swift
    }
    
    func stackedBarSeries() {
        // >> chart-bar-stack-swift
        let stackInfo = TKChartStackInfo(ID: 1, withStackMode: TKChartStackMode.Stack)
        
        let series1 = TKChartBarSeries(items: pointsWithCategoriesAndValues)
        series1.stackInfo = stackInfo
        
        let series2 = TKChartBarSeries(items: pointsWithCategoriesAndValues2)
        series2.stackInfo = stackInfo
        
        chart.beginUpdates()
        chart.addSeries(series1)
        chart.addSeries(series2)
        chart.endUpdates()
        // << chart-bar-stack-swift
    }
    
    func stacked100BarSeries() {
        // >> chart-bar-stack-100
        let stackInfo = TKChartStackInfo(ID: 1, withStackMode: TKChartStackMode.Stack100)
        
        let series1 = TKChartBarSeries(items: pointsWithCategoriesAndValues)
        series1.stackInfo = stackInfo
        
        let series2 = TKChartBarSeries(items: pointsWithCategoriesAndValues2)
        series2.stackInfo = stackInfo
        
        chart.beginUpdates()
        chart.addSeries(series1)
        chart.addSeries(series2)
        chart.endUpdates()
        // << chart-bar-stack-100
    }
    
    func visualAppearance() {
        // >> chart-bar-visual-swift
        let series = TKChartBarSeries(items: pointsWithCategoriesAndValues)
        // >> chart-column-visual-swift
        series.style.palette = TKChartPalette()
        
        let paletteItem = TKChartPaletteItem()
        paletteItem.fill = TKSolidFill(color: UIColor.redColor())
        paletteItem.stroke = TKStroke(color: UIColor.blackColor())
        series.style.palette!.addPaletteItem(paletteItem)
        chart.addSeries(series)
        // << chart-column-visual-swift
        // << chart-bar-visual-swift
    }
    
    func gapBetweenSeries() {
        // >> chart-bar-gap-swift
        let series = TKChartBarSeries(items: pointsWithCategoriesAndValues)
        series.gapLength = 0.5
        chart.addSeries(series)
        // << chart-bar-gap-swift
    }
    
    func barRange() {
        // >> chart-range-bar-swift
        let lowValues = [33, 29, 55, 21, 10, 39, 40, 11]
        let highValues = [47, 61, 64, 40, 33, 90, 87, 69]
        let lowValues2 = [31, 32, 57, 18, 12, 31, 45, 14]
        let highValues2 = [43, 66, 61, 49, 31, 80, 82, 78]
        
        var items = [TKChartRangeDataPoint]()
        var items2 = [TKChartRangeDataPoint]()
        for i in 0..<8 {
            items.append(TKChartRangeDataPoint(y: i, low: lowValues[i], high: highValues[i]))
            items2.append(TKChartRangeDataPoint(y: i, low: lowValues2[i], high: highValues2[i]))
        }
        
        let series = TKChartRangeBarSeries(items:items)
        let series2 = TKChartRangeBarSeries(items:items2)
        
        chart.addSeries(series)
        chart.addSeries(series2)
        // << chart-range-bar-swift
        
        // >> chart-range-bar-visual-swift
        series.style.palette = TKChartPalette()
        let paletteItem = TKChartPaletteItem()
        paletteItem.fill = TKSolidFill(color: UIColor.redColor())
        paletteItem.stroke = TKStroke(color: UIColor.blackColor())
        series.style.palette!.addPaletteItem(paletteItem)
        chart.addSeries(series)
        // << chart-range-bar-visual-swift
        
        // >> chart-range-bar-gap-swift
        series.gapLength = 0.5
        // << chart-range-bar-gap-swift
        
        // >> chart-range-bar-height-swift
        series.minBarHeight = 20
        series.maxBarHeight = 50
        // << chart-range-bar-height-swift
    }
}
