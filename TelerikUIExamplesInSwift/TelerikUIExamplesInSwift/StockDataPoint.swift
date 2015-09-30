//
//  StockDataPoint.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import Foundation

class StockDataPoint: TKChartFinancialDataPoint/*, NSCoding*/ {
    
    class func stockPoints() -> [StockDataPoint] {
        var dataPoints = [StockDataPoint]()
        let filePath = NSBundle.mainBundle().pathForResource("AppleStockPrices", ofType: "json")
        let json = NSData(contentsOfFile: filePath!)!
        do {
            let data = try NSJSONSerialization.JSONObjectWithData(json, options: NSJSONReadingOptions.AllowFragments) as! [NSDictionary]
            let formatter = NSDateFormatter()
            formatter.dateFormat = "dd-MM-yyyy"
            
            for jsonPoint in data {
                let datapoint = StockDataPoint()
                datapoint.dataXValue = formatter.dateFromString(jsonPoint["date"] as! String)
                datapoint.open = jsonPoint["open"] as? NSNumber
                datapoint.high = jsonPoint["high"] as? NSNumber
                datapoint.low = jsonPoint["low"] as? NSNumber
                datapoint.close = jsonPoint["close"] as? NSNumber
                datapoint.volume = jsonPoint["volume"] as? NSNumber
                dataPoints.append(datapoint)
            }
        }
        catch {
        }
        return dataPoints
    }
    
    class func stockPoints(count: Int) -> [StockDataPoint] {
        let data = StockDataPoint.stockPoints()
        var dataPoints = [StockDataPoint]()
        for i in 0..<count {
            dataPoints.append(data[i])
        }
        return dataPoints
    }
}
