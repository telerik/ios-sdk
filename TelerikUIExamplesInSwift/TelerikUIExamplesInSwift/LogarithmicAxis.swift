//
//  LogarithmicAxis.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 Telerik. All rights reserved.
//
//

class LogarithmicAxis: TKExamplesExampleViewController {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.view.bounds
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        chart.legend.hidden = false;
        self.view.addSubview(chart)
        
        let datasource = TKDataSource(dataFromJSONResource: "electricity", ofType: ".json", rootItemKeyPath: "data")
        datasource.sortWithKey("year", ascending: true)
        
        datasource.itemSource = [TKDataSourceGroup(items: datasource.items, valueKey: "nuclear", displayKey: "year"),
            TKDataSourceGroup(items: datasource.items, valueKey: "hydro", displayKey: "year"),
            TKDataSourceGroup(items: datasource.items, valueKey: "solar", displayKey: "year")
        ];
        
        var colors = [UIColor(red: 0.318, green: 0.384, blue: 0.737, alpha: 1.00),
        UIColor(red: 0.039, green: 0.631, blue: 0.933, alpha: 1.00),
        UIColor(red: 0.271, green: 0.678, blue: 0.373, alpha: 1.00)]
        
        datasource.settings.chart.createSeries { (TKDataSourceGroup group) -> TKChartSeries! in
            let series = TKChartAreaSeries()
            series.title = group!.valueKey!.capitalizedString
            series.style.fill = TKSolidFill(color:colors[datasource.itemSource!.indexOfObject(group!)])
            return series
        }
        
        chart.yAxis = TKChartLogarithmicAxis()
        chart.dataSource = datasource
    }
}
