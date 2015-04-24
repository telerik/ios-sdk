//
//  Customize.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class Customize: ExampleViewController, TKChartDelegate {
    
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.frame = self.exampleBoundsWithInset
        chart.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        chart.delegate = self
        self.view.addSubview(chart)
        
        var array1 = [TKChartDataPoint]()
        var array2 = [TKChartDataPoint]()
        for i in 0..<10 {
            array1.append(TKChartDataPoint(x: i, y: Int(arc4random() % (100))))
            array2.append(TKChartDataPoint(x: i, y: Int(arc4random() % (100))))
        }
        
        let columnSeries = TKChartColumnSeries(items: array1)
        columnSeries.selectionMode = TKChartSeriesSelectionMode.Series
        chart.addSeries(columnSeries)
        
        let areaSeries = TKChartAreaSeries(items: array2)
        areaSeries.style.pointShape = TKPredefinedShape(type: TKShapeType.Star, andSize: CGSizeMake(20, 20))
        areaSeries.style.shapeMode = TKChartSeriesStyleShapeMode.AlwaysShow
        areaSeries.selectionMode = TKChartSeriesSelectionMode.Series
        chart.addSeries(areaSeries)
        
        chart.yAxis.style.labelStyle.font = UIFont.systemFontOfSize(18)
        chart.yAxis.style.labelStyle.textColor = UIColor.blackColor()
        
        chart.xAxis.style.labelStyle.font = UIFont.systemFontOfSize(18)
        chart.xAxis.style.labelStyle.textColor = UIColor.blackColor()
        chart.gridStyle().horizontalAlternateFill = TKSolidFill(color: UIColor(white: 0.9, alpha: 0.8))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func chart(chart: TKChart!, paletteItemForSeries series: TKChartSeries!, atIndex index: Int) -> TKChartPaletteItem! {
        var item:TKChartPaletteItem
        if(series.index == 1) {
            let colors = [UIColor(red: 0, green: 1, blue: 0, alpha: 0.4),
                          UIColor(red: 1, green: 0, blue: 0, alpha: 0.4),
                          UIColor(red: 0, green: 0, blue: 1, alpha: 0.4)]
            let gradient = TKLinearGradientFill(colors: colors, startPoint: CGPointMake(0.5, 0.0), endPoint: CGPointMake(0.5, 1.0))
            item = TKChartPaletteItem(fill: gradient)
        }
        else {
            let image = TKImageFill(image: UIImage(named: "pattern1"), cornerRadius: 5.0)
            image.resizingMode = TKImageFillResizingMode.Tile
            let stroke = TKStroke(color: UIColor.blackColor(), width: 1, cornerRadius: 5)
            stroke.dashPattern = [2, 2, 5, 2]
            item = TKChartPaletteItem(drawables: [image, stroke])
        }
        return item
    }
}