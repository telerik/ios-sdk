//
//  CustomAxis.swift
//  TelerikUIExamplesInSwift
//
//  Copyright (c) 2015 г. Telerik. All rights reserved.
//

import Foundation

class CustomAxis: ExampleViewController {
    
    override func viewDidLoad() {
        var chart: TKChart!

        super.viewDidLoad()
        chart = TKChart(frame: self.exampleBoundsWithInset)
        chart.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.FlexibleWidth.rawValue | UIViewAutoresizing.FlexibleHeight.rawValue)
        self.view.addSubview(chart)
        
        let yAxis = MyAxis(minimum: 100, andMaximum: 450)
        chart.yAxis = yAxis
        chart.legend.hidden = false
        
        let names = ["Upper class", "Upper middle class", "Middle class", "Lower middle class"]
        let offsets = [350, 250, 150, 100]
        let strokes = [UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5),
            UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.6),
            UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.6),
            UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.6)]
        
        let fills = [[UIColor(red: 0.78, green: 0.81, blue: 0.86, alpha: 0.5), UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)],
            [UIColor(red: 0.78, green: 0.76, blue: 0.70, alpha: 1.0), UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)],
            [UIColor(red: 0.80, green: 0.73, blue: 0.67, alpha: 1.0), UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)],
            [UIColor(red: 0.70, green: 0.58, blue: 0.58, alpha: 1.0), UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)]]
        
        for i in 0 ..< names.count {
            var items = [TKChartDataPoint]()
            for j in 0 ..< 10 {
                let date = self.date(j + 2001, month: 1, day: 1)
                let offset = offsets[i]
                let yValue = Double(arc4random_uniform(50)) + Double(offset)
                let point = TKChartDataPoint(x: date, y: yValue)
                items.append(point)
            }
            
            let series = TKChartSplineAreaSeries(items: items)
            series.title = names[i]
            series.style.palette = TKChartPalette()
            let paletteItem = TKChartPaletteItem()
            paletteItem.stroke = TKStroke(color: strokes[i], width: 1.5)
            paletteItem.fill = TKLinearGradientFill(colors: fills[i])
            series.style.palette?.addPaletteItem(paletteItem)
            chart.addSeries(series)
        }
    }
    
    func date(year: Int, month: Int, day: Int) -> NSDate
    {
        let calendar = NSCalendar(identifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        return calendar!.dateFromComponents(components)!
    }
}
