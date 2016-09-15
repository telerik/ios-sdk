//
//  RangeBarColumnChart.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//

class RangeBarColumnChart: TKExamplesExampleViewController {
    let chart = TKChart()
    
    let lowValues = [33, 29, 55, 21, 10, 39, 40, 11]
    let highValues = [47, 61, 64, 40, 33, 90, 87, 69]
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.addOption("Range Column", action: rangeColumnSelected)
        self.addOption("Range Bar", action: rangeBarSelected)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        self.rangeColumnSelected()
    }
    
    func rangeColumnSelected() {
        chart.removeAllData()
        
        var items = [TKChartRangeDataPoint]()
        for i in 0..<8 {
            items.append(TKChartRangeDataPoint(x: i, low: lowValues[i], high: highValues[i]))
        }
        
        let series = TKChartRangeColumnSeries(items:items)
        series.style.paletteMode = TKChartSeriesStylePaletteMode.UseItemIndex
        series.selection = TKChartSeriesSelection.DataPoint
        chart.addSeries(series)
        chart.reloadData()
    }
    
    func rangeBarSelected() {
        chart.removeAllData()
        
        var items = [TKChartRangeDataPoint]()
        for i in 0..<8 {
            items.append(TKChartRangeDataPoint(y: i, low: lowValues[i], high: highValues[i]))
        }
        
        let series = TKChartRangeBarSeries(items:items)
        series.style.paletteMode = TKChartSeriesStylePaletteMode.UseItemIndex
        series.selection = TKChartSeriesSelection.DataPoint
        chart.addSeries(series)
        chart.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
