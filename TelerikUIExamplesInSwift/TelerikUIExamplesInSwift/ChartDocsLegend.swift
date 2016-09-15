//
//  ChartDocsLegend.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ChartDocsLegend: UIViewController, TKChartDelegate {

    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.delegate = self
        
        chart.frame = CGRectInset(self.view.bounds, 10, 10)
        self.view.addSubview(chart)
        var pointsWithValueAndName = [TKChartDataPoint]()
        pointsWithValueAndName.append(TKChartDataPoint(name: "Google", value: 20))
        pointsWithValueAndName.append(TKChartDataPoint(name: "Apple", value: 30))
        pointsWithValueAndName.append(TKChartDataPoint(name: "Microsoft", value: 10))
        pointsWithValueAndName.append(TKChartDataPoint(name: "IBM", value: 5))
        pointsWithValueAndName.append(TKChartDataPoint(name: "Oracle", value: 8))
        
        let series = TKChartDonutSeries(items: pointsWithValueAndName)
        chart.addSeries(series)
        
        chart.legend.style.position = TKChartLegendPosition.Bottom
        chart.legend.hidden = false
    }
    
    func chart(chart: TKChart, updateLegendItem item: TKChartLegendItem, forSeries series: TKChartSeries, atIndex index: UInt) {
        let image : UIImage? = UIImage(named: item.label.text! + ".png")
        let imgView : UIImageView = UIImageView(image: image)
        item.icon.addSubview(imgView)
    }
    
    func customizeChartsLegend() {
        chart.legend.hidden = false
         chart.legend.style.position = TKChartLegendPosition.Bottom
        // >> chart-legend-offset-pos-swift
        chart.legend.style.position = TKChartLegendPosition.Floating
        chart.legend.style.offsetOrigin = TKChartLegendOffsetOrigin.TopLeft
        chart.legend.style.offset = UIOffsetMake(10, 10)
        // << chart-legend-offset-pos-swift
        
        // >> chart-legend-title-swift
        chart.legend.titleLabel.text = "Companies"
        chart.legend.showTitle = true
        // << chart-legend-title-swift
    }
    
    func createLegendView() {
        chart.title.text = "Market Share"
        // >> chart-legend-outside-swift
        let legendView = TKChartLegendView(chart: chart)
        legendView.frame = CGRectMake(20, 20, 320, 100)
        self.view.addSubview(legendView)
        legendView.reloadItems()
        // << chart-legend-outside-swift
    }
    
}
