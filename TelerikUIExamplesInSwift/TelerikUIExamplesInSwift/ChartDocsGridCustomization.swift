//
//  ChartDocsGridCustomization.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ChartDocsGridCustomization: UIViewController {

    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chart.frame = CGRectInset(self.view.bounds, 10, 10)
        self.view.addSubview(chart)
        
        let categories = ["Greetings", "Perfecto", "NearBy", "Family Store", "Fresh & Green" ]
        let expensesValues = [70, 75, 58, 59, 88]
        var expensesData = [TKChartDataPoint]()
        for i in 0 ..< categories.count {
            expensesData.append(TKChartDataPoint(x: categories[i], y: expensesValues[i]))
        }
        
        let series = TKChartLineSeries(items: expensesData)
        chart.addSeries(series)
    }
    
    func zPosition() {
        // >> chart-grid-z-swift
        let gridStyle = chart.gridStyle
        gridStyle.horizontalLineStroke = TKStroke(color: UIColor(white: 215.0 / 255.0, alpha: 1.0))
        gridStyle.horizontalLineAlternateStroke = TKStroke(color: UIColor(white: 215.0 / 255.0, alpha: 1.0))
        gridStyle.horizontalLinesHidden = false
        gridStyle.horizontalFill = TKSolidFill(color: UIColor(white: 228.0 / 255.0, alpha: 0.7))
        gridStyle.horizontalAlternateFill = TKSolidFill(color: UIColor.clearColor())
        
        gridStyle.verticalFill = nil
        gridStyle.verticalAlternateFill = nil
        gridStyle.verticalLinesHidden = true
        gridStyle.zPosition = TKChartGridZPosition.AboveSeries
        // << chart-grid-z-swift
    }
    
    func combiningItAltogether() {
        // >> chart-grid-combining-swift
        let gridStyle = chart.gridStyle
        gridStyle.horizontalLineStroke = TKStroke(color: UIColor(white: 215.0 / 255.0, alpha: 1.0))
        gridStyle.horizontalLineAlternateStroke = TKStroke(color: UIColor(white: 215.0 / 255.0, alpha: 1.0))
        gridStyle.horizontalFill = TKSolidFill(color: UIColor(white: 228.0 / 255.0, alpha: 0.7))
        gridStyle.horizontalAlternateFill = TKSolidFill(color: UIColor.whiteColor())
        gridStyle.horizontalLinesHidden = false
        
        gridStyle.verticalLineStroke = TKStroke(color: UIColor(white: 215.0 / 255.0, alpha: 1.0))
        gridStyle.verticalLineAlternateStroke = TKStroke(color: UIColor(white: 215.0 / 255.0, alpha: 1.0))
        gridStyle.verticalLinesHidden = false
        gridStyle.verticalFill = TKSolidFill(color: UIColor(red: 1.0, green: 1.0, blue:0.0 , alpha: 0.1))
        gridStyle.verticalAlternateFill = TKSolidFill(color: UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.1))
        // << chart-grid-combining-swift
        
        // >> chart-grid-first-swift
        gridStyle.drawOrder = TKChartGridDrawMode.VerticalFirst
        // << chart-grid-first-swift
        
        // >> chart-grid-bg-fill-swift
        gridStyle.backgroundFill = TKSolidFill(color: UIColor.whiteColor())
        // << chart-grid-bg-fill-swift
        
        // >> chart-grid-img-fill-swift
        gridStyle.backgroundFill = TKSolidFill(color: UIColor(patternImage: UIImage(named: "logo")!))
        // << chart-grid-img-fill-swift
        
    }
    
    func colorfulGridLines() {
        // >> chart-grid-colorful-swift
        let gridStyle = chart.gridStyle
        gridStyle.verticalLineStroke = TKStroke(color: UIColor.blackColor())
        gridStyle.verticalLineAlternateStroke = TKStroke(color: UIColor.blackColor())
        gridStyle.verticalLinesHidden = false
        gridStyle.verticalFill = nil
        gridStyle.verticalAlternateFill = nil
        
        gridStyle.horizontalLineStroke = TKStroke(color: UIColor.redColor())
        gridStyle.horizontalLineAlternateStroke = TKStroke(color: UIColor.blueColor())
        gridStyle.horizontalFill = nil
        gridStyle.horizontalAlternateFill = nil
        gridStyle.horizontalLinesHidden = false
        // << chart-grid-colorful-swift
    }
    
    func verticalAlternativeFills() {
        // >> chart-grid-alternate-vertical-swift
        let gridStyle = chart.gridStyle
        gridStyle.verticalLineStroke = TKStroke(color: UIColor(white: 215.0 / 255.0, alpha: 1.0))
        gridStyle.verticalLineAlternateStroke = TKStroke(color: UIColor(white: 215.0 / 255.0, alpha: 1.0))
        gridStyle.verticalLinesHidden = false
        gridStyle.verticalFill = TKSolidFill(color: UIColor(white: 228.0 / 255.0, alpha: 1.0))
        gridStyle.verticalAlternateFill = TKSolidFill(color: UIColor.whiteColor())
        
        
        gridStyle.horizontalFill = nil
        gridStyle.horizontalAlternateFill = nil
        gridStyle.horizontalLinesHidden = true
        // << chart-grid-alternate-vertical-swift
    }
    
    func removeVerticalLines() {
        // >> chart-grid-remove-vertical-swift
        let gridStyle = chart.gridStyle
        gridStyle.verticalLinesHidden = true
        gridStyle.verticalFill = nil
        gridStyle.verticalAlternateFill = nil
        
        gridStyle.horizontalLineStroke = TKStroke(color: UIColor.redColor())
        gridStyle.horizontalLineAlternateStroke = TKStroke(color: UIColor.blueColor())
        gridStyle.horizontalFill = nil
        gridStyle.horizontalAlternateFill = nil
        gridStyle.horizontalLinesHidden = false
        // << chart-grid-remove-vertical-swift
    }
    
    func horizontalAlternativeFills() {
        // >> chart-grid-alternate-horizontal-swift
        let gridStyle = chart.gridStyle
        gridStyle.horizontalLineStroke = TKStroke(color: UIColor(white: 215.0 / 255.0, alpha: 1.0))
        gridStyle.horizontalLineAlternateStroke = TKStroke(color: UIColor(white: 215.0 / 255.0, alpha: 1.0))
        gridStyle.horizontalLinesHidden = false
        gridStyle.horizontalFill = TKSolidFill(color: UIColor(white: 228.0 / 255.0, alpha: 1.0))
        gridStyle.horizontalAlternateFill = TKSolidFill(color: UIColor.whiteColor())
        
        gridStyle.verticalFill = nil
        gridStyle.verticalAlternateFill = nil
        gridStyle.verticalLinesHidden = true
        // << chart-grid-alternate-horizontal-swift
    }
}
