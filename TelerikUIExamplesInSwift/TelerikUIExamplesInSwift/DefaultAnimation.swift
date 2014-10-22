//
//  DefaultAnimation.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation
import QuartzCore

class DefaultAnimation: ExampleViewController {
    
    let chart = TKChart()
    
    override init() {
        super.init()

        let names = ["Area Series", "Pie Series", "Line Series", "Scatter Series", "Bar Series", "Column Series"]
        let idiom = UIDevice.currentDevice().userInterfaceIdiom
        
        self.addOption(self.nameForOption(0, names: names, idiom: idiom)) { self.setupAreaSeries() }
        self.addOption(self.nameForOption(1, names: names, idiom: idiom)) { self.setupPieSeries() }
        self.addOption(self.nameForOption(2, names: names, idiom: idiom)) { self.setupLineSeries() }
        self.addOption(self.nameForOption(3, names: names, idiom: idiom)) { self.setupScatterSeries() }
        self.addOption(self.nameForOption(4, names: names, idiom: idiom)) { self.setupBarSeries() }
        self.addOption(self.nameForOption(5, names: names, idiom: idiom)) { self.setupColumnSeries() }
        
        self.selectedOption = 2
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBounds
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        chart.allowAnimations = true
        self.view.addSubview(chart)
        
        self.setupLineSeries()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func nameForOption(index: NSInteger, names: NSArray, idiom: UIUserInterfaceIdiom) -> NSString {
        var name = names[index] as NSString
        if (idiom != UIUserInterfaceIdiom.Pad) {
            name = NSString(format: "%@ Animation", name)
        }
        return name
    }
    
    func setupLineSeries() {
        chart.removeAllData()
        
        let array = NSMutableArray()
        for i in 0..<10 {
            array.addObject(TKChartDataPoint(x: i, y: Int(arc4random() % 100)))
        }
        
        let lineSeries = TKChartLineSeries(items: array)
        lineSeries.selectionMode = TKChartSeriesSelectionMode.Series
        chart.addSeries(lineSeries)
    }
    
    func setupAreaSeries() {
        chart.removeAllData()
        
        let array = NSMutableArray()
        for i in 0..<10 {
            array.addObject(TKChartDataPoint(x: i, y: Int(arc4random() % 100)))
        }
        
        let areaSeries = TKChartAreaSeries(items: array)
        areaSeries.selectionMode = TKChartSeriesSelectionMode.Series
        chart.addSeries(areaSeries)
    }
    
    func setupPieSeries() {
        chart.removeAllData()
        
        let array = NSMutableArray()
        array.addObject(TKChartDataPoint(value: 20, name: "Google"))
        array.addObject(TKChartDataPoint(value: 30, name: "Apple"))
        array.addObject(TKChartDataPoint(value: 10, name: "Microsoft"))
        array.addObject(TKChartDataPoint(value: 5, name: "IBM"))
        array.addObject(TKChartDataPoint(value: 8, name: "Oracle"))
        
        let series = TKChartPieSeries(items: array)
        series.selectionMode = TKChartSeriesSelectionMode.DataPoint
        chart.addSeries(series)
    }
    
    func setupScatterSeries() {
        chart.removeAllData()
        
        let points = NSMutableArray()
        for i in 0..<100 {
            points.addObject(TKChartDataPoint(x: Int(arc4random() % 1450), y: Int(arc4random() % 150)))
        }
        
        let scatterSeries = TKChartScatterSeries(items: points)
        scatterSeries.selectionMode = TKChartSeriesSelectionMode.Series
        chart.addSeries(scatterSeries)
    }
    
    func setupBarSeries() {
        chart.removeAllData()
        
        let array = NSMutableArray()
        for i in 0..<10 {
            array.addObject(TKChartDataPoint(x: Int(arc4random() % 100), y: i))
        }
        
        let barSeries = TKChartBarSeries(items: array)
        barSeries.selectionMode = TKChartSeriesSelectionMode.Series
        chart.addSeries(barSeries)
    }
    
    func setupColumnSeries() {
        chart.removeAllData()
        
        let array = NSMutableArray()
        for i in 0..<10 {
            array.addObject(TKChartDataPoint(x: i, y: Int(arc4random() % 100)))
        }
        
        let columnSeries = TKChartColumnSeries(items: array)
        columnSeries.selectionMode = TKChartSeriesSelectionMode.Series
        chart.addSeries(columnSeries)
    }
}
