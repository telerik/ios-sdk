using System;
using TelerikUI;
using Foundation;
using System.Collections.Generic;

namespace Examples
{
	public class ChartDocsIndicators
	{
		public ChartDocsIndicators ()
		{
		}

		TKChart financialChart = new TKChart();
		List<TKChartDataPoint> financialDataPoints = null;

		void snippet1()
		{
			// >> chart-indicators-bollinger-cs
			var candlesticks = new TKChartCandlestickSeries (financialDataPoints.ToArray ());
			var bollingerBands = new TKChartBollingerBandIndicator (candlesticks);
			financialChart.AddSeries (candlesticks);
			financialChart.AddSeries (bollingerBands);
			// << chart-indicators-bollinger-cs
		}

		void snippet2()
		{
			// >> chart-indicators-technical-cs
			var candlesticks = new TKChartCandlestickSeries (financialDataPoints.ToArray());
			var macdIndicator = new TKChartMACDIndicator (candlesticks);
			macdIndicator.LongPeriod = 26;
			macdIndicator.ShortPeriod = 12;
			macdIndicator.SignalPeriod = 9;
			financialChart.AddSeries (macdIndicator);
			// << chart-indicators-technical-cs
		}
	}
}

