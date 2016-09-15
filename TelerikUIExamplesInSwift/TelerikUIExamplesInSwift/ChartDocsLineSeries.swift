//
//  ChartDocsLineSeries.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ChartDocsLineSeries: UIViewController {

    var chart = TKChart()
    var expensesData = [TKChartDataPoint]()
    var incomesData = [TKChartDataPoint]()
    var profitData = [TKChartDataPoint]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chart.frame = CGRectInset(self.view.bounds, 10, 10)
        self.view.addSubview(chart)
        self.lineSeries()
    }
    
    func lineSeries() {
        // >> chart-line-swift
        let categories = ["Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" ]
        let expensesValues = [60, 30, 50, 32, 31]
        let incomesValues = [70, 75, 58, 59, 88]
        let profitValues = [10, 45, 8, 27, 57]
        
        for i in 0 ..< categories.count {
            expensesData.append(TKChartDataPoint(x: categories[i], y: expensesValues[i]))
            incomesData.append(TKChartDataPoint(x: categories[i], y: incomesValues[i]))
            profitData.append(TKChartDataPoint(x: categories[i], y: profitValues[i]))
        }
        
        let seriesForExpenses = TKChartLineSeries(items: expensesData)
        seriesForExpenses.title = "Expenses"
        chart.addSeries(seriesForExpenses)
        
        let seriesForIncomes = TKChartLineSeries(items: incomesData)
        seriesForIncomes.title = "Incomes"
        chart.addSeries(seriesForIncomes)
        
        let seriesForProfit = TKChartLineSeries(items: profitData)
        seriesForProfit.title = "Profit"
        chart.addSeries(seriesForProfit)
        chart.legend.hidden = false
        // << chart-line-swift
    }
    
    func selection() {
        let seriesForProfit = TKChartLineSeries(items: profitData)
        seriesForProfit.selection = TKChartSeriesSelection.Series
        seriesForProfit.marginForHitDetection = 30.0
        chart.addSeries(seriesForProfit)
    }
    
    func visualAppearance() {
        // >> chart-line-series-stroke-swift
        let seriesForProfit = TKChartLineSeries(items: profitData)
        seriesForProfit.style.palette = TKChartPalette()
        let paletteItem = TKChartPaletteItem()
        paletteItem.stroke = TKStroke(color: UIColor.greenColor())
        seriesForProfit.style.palette!.addPaletteItem(paletteItem)
        chart.addSeries(seriesForProfit)
        // << chart-line-series-stroke-swift
    }
}
