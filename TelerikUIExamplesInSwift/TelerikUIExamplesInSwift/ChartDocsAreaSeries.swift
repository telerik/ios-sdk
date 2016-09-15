//
//  ChartDocsAreaSeries.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ChartDocsAreaSeries: UIViewController {
    var pointsWithCategoriesAndValues = [TKChartDataPoint]()
    var pointsWithCategoriesAndValues2 = [TKChartDataPoint]()
    var chart:TKChart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chart.frame = CGRectInset(self.view.bounds, 10, 10)
        self.view.addSubview(chart)
        // >> chart-area-swift
        let categories = ["Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" ];
        let values = [70, 75, 58, 59, 88]
        for i in 0 ..< categories.count {
            pointsWithCategoriesAndValues.append(TKChartDataPoint(x: categories[i], y: values[i]))
        }
        
        let values2 = [40, 80, 32, 69, 95]
        for i in 0 ..< categories.count {
            pointsWithCategoriesAndValues2.append(TKChartDataPoint(x: categories[i], y: values2[i]))
        }
        
        chart.addSeries(TKChartAreaSeries(items: pointsWithCategoriesAndValues))
        chart.addSeries(TKChartAreaSeries(items: pointsWithCategoriesAndValues2))
        // << chart-area-swift
    }
    
    func areaSeries() {
        let seriesForIncome = TKChartAreaSeries(items: pointsWithCategoriesAndValues)
        chart.addSeries(seriesForIncome)
        
        let seriesForExpenses = TKChartAreaSeries(items: pointsWithCategoriesAndValues2)
        chart.addSeries(seriesForExpenses)
    }
    
    func stacking100AreaSeries() {
        // >> chart-stack-area-100-swift
        let stackInfo = TKChartStackInfo(ID: 1, withStackMode: TKChartStackMode.Stack100)
        
        let seriesForIncome = TKChartAreaSeries(items: pointsWithCategoriesAndValues)
        seriesForIncome.stackInfo = stackInfo
        
        let seriesForExpenses = TKChartAreaSeries(items: pointsWithCategoriesAndValues2)
        seriesForExpenses.stackInfo = stackInfo
        
        chart.beginUpdates()
        chart.addSeries(seriesForIncome)
        chart.addSeries(seriesForExpenses)
        chart.endUpdates()
        // << chart-stack-area-100-swift
    }
    
    func stackingAreaSeries() {
        // >> chart-stack-area-swift
        let stackInfo = TKChartStackInfo(ID: 1, withStackMode: TKChartStackMode.Stack)
        
        let seriesForIncome = TKChartAreaSeries(items: pointsWithCategoriesAndValues)
        seriesForIncome.stackInfo = stackInfo
        
        let seriesForExpenses = TKChartAreaSeries(items: pointsWithCategoriesAndValues2)
        seriesForExpenses.stackInfo = stackInfo
        
        chart.beginUpdates()
        chart.addSeries(seriesForIncome)
        chart.addSeries(seriesForExpenses)
        chart.endUpdates()
        // << chart-stack-area-swift
    }
    
    func visualAppearance() {
        // >> chart-style-fill-swift
        let seriesForAnnualRevenue = TKChartAreaSeries(items: pointsWithCategoriesAndValues)
        seriesForAnnualRevenue.style.palette = TKChartPalette()
        let paletteItem = TKChartPaletteItem()
        paletteItem.stroke = TKStroke(color: UIColor.brownColor())
        paletteItem.fill = TKSolidFill(color: UIColor.redColor())
        seriesForAnnualRevenue.style.palette!.addPaletteItem(paletteItem)
        chart.addSeries(seriesForAnnualRevenue)
        // << chart-style-fill-swift
    }
    
}
