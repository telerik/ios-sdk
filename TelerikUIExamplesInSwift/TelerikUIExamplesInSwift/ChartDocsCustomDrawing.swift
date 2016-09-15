//
//  ChartDocsCustomDrawing.swift
//  TelerikUIExamplesInSwift
//
//  Copyright © 2016 Telerik. All rights reserved.
//

class ChartDocsCustomDrawing: UIViewController {
    let chart = TKChart()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chart.frame = CGRectInset(self.view.bounds, 10, 10)
        self.view.addSubview(chart)
        
        let gdpInPoundsValues = [80, 92, 73, 85, 59]
        var gdpInPoundsPoints = [TKChartDataPoint]()
        for i in 0 ..< gdpInPoundsValues.count {
            gdpInPoundsPoints.append(TKChartDataPoint(x: self.dateWithYear(i + 2009, month: 12, day: 31), y: gdpInPoundsValues[i]))
        }
        
        // >> chart-drawing-cycling-swift
        let series = TKChartColumnSeries(items: gdpInPoundsPoints)
        // >> chart-drawing-pallete-swift
        series.style.palette = TKChartPalette()
        // << chart-drawing-pallete-swift
        
        // >> chart-drawing-solid-fill-swift
        let redFill = TKSolidFill(color: UIColor.redColor())
        // << chart-drawing-solid-fill-swift
        
        series.style.palette!.addPaletteItem(TKChartPaletteItem(fill: redFill))
        
        let blueFill = TKSolidFill(color: UIColor.blueColor())
        series.style.palette!.addPaletteItem(TKChartPaletteItem(fill: blueFill))
        
        let greenFill = TKSolidFill(color: UIColor.greenColor())
        series.style.palette!.addPaletteItem(TKChartPaletteItem(fill: greenFill))
        
        series.style.paletteMode = TKChartSeriesStylePaletteMode.UseItemIndex
        
        chart.addSeries(series)
        // << chart-drawing-cycling-swift
        
        series.style.palette = TKChartPalette()
        
         // >> chart-drawing-pallete-mode-index-swift
        series.style.paletteMode = TKChartSeriesStylePaletteMode.UseItemIndex
         // << chart-drawing-pallete-mode-index-swift
        
        // >> chart-drawing-pallete-mode-series-swift
        series.style.paletteMode = TKChartSeriesStylePaletteMode.UseSeriesIndex
        // << chart-drawing-pallete-mode-series-swift
        
        // >> chart-drawing-pallete-items-swift
        let paletteItem1 = TKChartPaletteItem(fill: TKSolidFill(color: UIColor.redColor()))
        let paletteItem2 = TKChartPaletteItem(stroke: TKStroke(color: UIColor.blueColor()))
        let paletteItem3 = TKChartPaletteItem(stroke: TKStroke(color: UIColor.blueColor()), andFill: TKSolidFill(color: UIColor.redColor()))
        
        series.style.palette!.addPaletteItem(paletteItem1)
        series.style.palette!.addPaletteItem(paletteItem2)
        series.style.palette!.addPaletteItem(paletteItem3)

        // << chart-drawing-pallete-items-swift
        
        let xValues = [460, 510, 600, 640, 700, 760, 800, 890, 920, 1000, 1060, 1120, 1200, 1342, 1440]
        let yValues = [7, 9 ,12, 17, 19, 25, 32, 42, 50, 16, 56, 77, 24, 80, 90]
        var scatterPoints = [TKChartDataPoint]()
        for i in 0 ..< xValues.count{
            scatterPoints.append(TKChartDataPoint(x: xValues[i], y: yValues[i]))
        }
        
        // >> chart-drawing-pallete-point-swift
        let scatterSeries = TKChartScatterSeries(items: scatterPoints)
        scatterSeries.style.pointShape = TKPredefinedShape(type: TKShapeType.Rhombus, andSize: CGSizeMake(15, 15))
        // << chart-drawing-pallete-point-swift
    }
    
    func paletteItemsWithSeries(series: TKChartSeries) {
        // >> chart-drawing-pallete-items-arrays-swift
        series.style.palette = TKChartPalette()
        let redFill = TKSolidFill(color: UIColor.redColor(), cornerRadius: 2.0)
        let stroke1 = TKStroke(color: UIColor.yellowColor(), width: 1.0, cornerRadius: 2.0)
        stroke1.insets = UIEdgeInsetsMake(1, 1, 1, 1)
        
        let stroke2 = TKStroke(color: UIColor.blackColor(), width: 1.0, cornerRadius: 2.0)
        series.style.palette!.addPaletteItem(TKChartPaletteItem(drawables: [redFill, stroke1, stroke2]))
        // << chart-drawing-pallete-items-arrays-swift
    }
    
    func simpleStroke() {
        // >> chart-drawing-stroke-swift
        let stroke = TKStroke(color: UIColor.blueColor())
        // << chart-drawing-stroke-swift
        print("\(stroke)")
    }
    
    func simpleStroke2() {
        // >> chart-drawing-stroke-rounded-corners-swift
        let stroke = TKStroke(color: UIColor.blueColor(), width: 1.0, cornerRadius: 5.0)
        // << chart-drawing-stroke-rounded-corners-swift
        print("\(stroke)")
    }
    
    func simpleStrokeLinear() {
        // >> chart-drawing-stroke-gradient-swift
        let fill = TKLinearGradientFill(colors: [UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.6),
            UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.6),
            UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.6)])
        let stroke = TKStroke(fill: fill, width: 1.0, cornerRadius: 5.0)
        // << chart-drawing-stroke-gradient-swift
        print("\(stroke)")
    }
    
    func strokeCombinedWithFill() {
        // >> chart-drawing-stroke-combined-swift
        let fill = TKLinearGradientFill(colors:
            [UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.6),
                UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.6),
                UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.6)])
        let stroke = TKStroke(fill: fill, width: 1.0, cornerRadius: 5.0)
        stroke.dashPattern = [2, 2, 5, 2]
        stroke.corners = UIRectCorner(rawValue: UIRectCorner.TopRight.rawValue | UIRectCorner.BottomLeft.rawValue)
        // << chart-drawing-stroke-combined-swift
        print("\(stroke)")
    }
    
    func simpleStrokeDash() {
        // >> chart-drawing-stroke-dashed-swift
        let stroke = TKStroke(color: UIColor.blueColor(), width: 1.0, cornerRadius: 5.0)
        stroke.dashPattern = [2, 2, 5, 2]
        // << chart-drawing-stroke-dashed-swift
    }
    
    func simpleFill() {
        let fill = TKSolidFill(color: UIColor.redColor())
        print("\(fill)")
    }
    
    func simpleFillRadius() {
        // >> chart-drawing-solid-fill-radius-swift
        let fill = TKSolidFill(color: UIColor.redColor(), cornerRadius: 5.0)
        // << chart-drawing-solid-fill-radius-swift
        print("\(fill)")
    }
    
    func simpleFillDiffCornersToRound() {
        // >> chart-drawing-round-corners-swift
        let fill = TKSolidFill(color: UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5), cornerRadius: 8.0)
        fill.corners = UIRectCorner(rawValue: UIRectCorner.TopRight.rawValue | UIRectCorner.BottomLeft.rawValue)
        // << chart-drawing-round-corners-swift
        print("\(fill)")
    }
    
    func gradientFill() {
        // >> chart-drawing-gradient-swift
        let fill = TKLinearGradientFill(colors: [UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.6),
            UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.6),
            UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.6)])
        // << chart-drawing-gradient-swift
        print("\(fill)")
    }
    
    func gradientFillCustomized() {
        // >> chart-drawing-gradient-direction-swift
        let fill = TKLinearGradientFill(colors: [UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.6),
            UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.6),
            UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 0.6)],
                                        locations: [0.6, 0.8, 1.0],
                                        startPoint: CGPointMake(0, 0),
                                        endPoint: CGPointMake(1, 1))
        // << chart-drawing-gradient-direction-swift
        print("\(fill)")
    }
    
    func radialFill() {
        // >> chart-drawing-gradient-radial-swift
        let fill = TKRadialGradientFill(
            colors: [UIColor(red: 0.0, green: 1.0, blue: 0.0, alpha: 0.7),
                UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.0)],
            startCenter: CGPointMake(0.5, 0.5),
            startRadius: 0.7,
            endCenter: CGPointMake(0, 1),
            endRadius: 0.3,
            radiusType: TKGradientRadiusType.RectMax)
        // << chart-drawing-gradient-radial-swift
        print("\(fill)")
    }
    
    func imageFill() {
        // >> chart-drawing-image-fill-swift
        let fill = TKImageFill(image: UIImage(named: "pattern1")!, cornerRadius: 4.0)
        fill.resizingMode = TKImageFillResizingMode.Tile
        // << chart-drawing-image-fill-swift
        print("\(fill)")
    }
    
    func imageFillStretch() {
        // >> chart-drawing-image-fill-stretch-swift
        let fill = TKImageFill(image: UIImage(named: "building1")!, cornerRadius: 4.0)
        // << chart-drawing-image-fill-stretch-swift
        print("\(fill)")
    }
    
    func onwStretchableImage() {
        // >> chart-drawing-image-resize-swift
        let fill = TKImageFill(image: UIImage(named: "pattern2")!.resizableImageWithCapInsets(UIEdgeInsetsMake(10, 10, 10, 10)))
        fill.resizingMode = TKImageFillResizingMode.None
        // << chart-drawing-image-resize-swift
        print("\(fill)")
    }
    
    func dateWithYear(year: Int, month: Int, day: Int) -> NSDate{
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let components = NSDateComponents()
        components.year = year
        components.month = month
        components.day = day
        return calendar!.dateFromComponents(components)!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
