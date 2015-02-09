##Building a Seismograph App with CoreMotion, Swift and Telerik UI for iOS

Data visualizations are important, especially on small screen areas, where Excel files or other tables are difficult to read and comprehend. Visualizations are even more important when you add the various sensors that an iPhone device offers, not to mention the different certified third-party devices. Today, I will show you how you can set up the Telerik Chart for iOS to live-stream the data coming from the accelerometer sensor using the CoreMotion API.

![Animated Chart Seismograph by Telerik](http://blogs.telerik.com/images/default-source/ui-for-ios-team/chart-seismograph.gif?sfvrsn=2 "Animated Chart Seismograph by Telerik")

The Chart will visualize the changes in phone acceleration in all three directions (X, Y or Z), depending on which direction the user has chosen. We will be gentle with the iPhone, I promise, so throwing the phone from the sixth floor to the ground is out of the question. We will also be able to start, stop or reset the Chart indications. All this we will do in both Swift and Objective-C.

<img alt="" width="310" height="384" src="https://developer.apple.com/library/ios/documentation/EventHandling/Conceptual/EventHandlingiPhoneOS/Art/acceleration_axes_2x.png">

####Getting Acceleration Data Using Core Motion

Let’s start with utilizing what Core Motion gives us. To do that, we create an instance of the CMMotionManager and let it send its data to an NSOperationQueue. The time interval by which the manager will send data to the queue will be 0.2 seconds. From there, we get the measured data, and depending on the currently selected direction, we pass the appropriate value to the chart.

Swift 


	func startOperations() {
	    motionManager.accelerometerUpdateInterval = 0.2
	    if motionManager.accelerometerAvailable {
	        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue(), withHandler: { accelerometerData, error in
	            
	            let acceleration = accelerometerData.acceleration
	            
	            switch self.aType {
	            case .X:
	                self.buildChartWithPoint(coefficient * acceleration.x)
	            case .Y:
	                self.buildChartWithPoint(coefficient * acceleration.y)
	            case .Z:
	                self.buildChartWithPoint(coefficient * acceleration.z)
	            default:
	                break
	            }
	        })
	    }
	}

Objective-C

	-(void)startOperations {
	    motionManager.accelerometerUpdateInterval = 0.2;
	    if(motionManager.accelerometerAvailable) {
	        [motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
	            CMAcceleration acceleration = accelerometerData.acceleration;
	         
	            switch (aType) {
	                case AxisTypeX:
	                    [self buildChartWithPoint:acceleration.x*coefficient];
	                    break;
	                case AxisTypeY:
	                    [self buildChartWithPoint:acceleration.y*coefficient];
	                    break;
	                case AxisTypeZ:
	                    [self buildChartWithPoint:acceleration.z*coefficient];
	                    break;
	                default:
	                    break;
	            }
	        }];
	    }
	}



Note we are multiplying the measured data by some coefficient, in this case 1,000, so that we have nicely plotted data even for some serious shaking gestures.
Setting Up the Chart

This is an example of a chart with data that's dynamically added and changed. First, I should mention that for performance optimization purposes, the chart does not refresh its UI automatically when the data is changed. We should take care about that. Therefore, the code that you see below is executed on every occurrence of a new data point added to the Chart.

Now, let’s analyze the implementation of the buildChartWithPoint method in detail:

First, for the reasons I mentioned above, we should remove all data and annotations from the chart:

Swift

	self.chart.removeAllData()
	self.chart.removeAllAnnotations()

Objective-C
	
	[_chart removeAllData];
	[_chart removeAllAnnotations];

Further, we should create a new data point for the new value measure by the accelerometer. A Chart with too many points may be difficult to read, so we will stick with up to 25 points in the chart. 

Swift

	let lastPoint = TKChartDataPoint(x: NSDate(), y: point)
	dataPoints.append(lastPoint)
	        
	if dataPoints.count > 25 {
	  dataPoints.removeAtIndex(0)
	}

Objective-C

	TKChartDataPoint *dataPoint = [[TKChartDataPoint alloc] initWithX:[NSDate date] Y:@(point)];
	[dataPoints addObject:dataPoint];
	 
	if (dataPoints.count > 25) {
	    [dataPoints removeObjectAtIndex:0];
	}

Now, we’ll create the YAxis. For the numeric values that we measure, the YAxis will be of type TKChartNumericAxis. And, because we want a nice, symmetrical Chart (symmetrical around the line where iPhone is in peace), we are going to place the XAxis in the middle of the Chart by setting the offset and baseline properties: 

Swift

	let yAxis = TKChartNumericAxis(minimum: -coefficient, andMaximum: coefficient)
	yAxis.position = TKChartAxisPosition.Left
	yAxis.majorTickInterval = 200
	yAxis.minorTickInterval = 1
	yAxis.offset = 0
	yAxis.baseline = 0
	yAxis.style.labelStyle.fitMode = TKChartAxisLabelFitMode.Rotate
	yAxis.style.labelStyle.firstLabelTextAlignment = TKChartAxisLabelAlignment.Left
	self.chart.yAxis = yAxis

Objective-C

	TKChartNumericAxis *yAxis = [[TKChartNumericAxis alloc] initWithMinimum:@(-coefficient) andMaximum:@(coefficient)];
	yAxis.position = TKChartAxisPositionLeft;
	yAxis.majorTickInterval = @200;
	yAxis.minorTickInterval = @1;
	yAxis.offset = @0;
	yAxis.baseline = @0;
	yAxis.style.labelStyle.fitMode = TKChartAxisLabelFitModeRotate;
	yAxis.style.labelStyle.firstLabelTextAlignment = TKChartAxisLabelAlignmentLeft;
	_chart.yAxis = yAxis;

Let’s now set the series that will visualize the measured data. This series will be a line series of type TKChartLineSeries: 

Swift 

	let lineSeries = TKChartLineSeries(items: dataPoints)
	lineSeries.style.palette = TKChartPalette()
	let strokeRed = TKStroke(color: UIColor.redColor(), width: 1.5)
	lineSeries.style.palette.addPaletteItem(TKChartPaletteItem(stroke: strokeRed))
	chart.addSeries(lineSeries)

Objective-C

	lineSeries = [[TKChartLineSeries alloc] initWithItems:dataPoints];
	lineSeries.style.palette = [TKChartPalette new];
	TKStroke *strokeRed = [TKStroke strokeWithColor:[UIColor colorWithRed:1 green:0 blue:0 alpha:1]];
	strokeRed.width = 1.5;
	[lineSeries.style.palette addPaletteItem:[TKChartPaletteItem paletteItemWithDrawables:@[strokeRed]]];
	[_chart addSeries:lineSeries];

Based and the data-points we add, the Chart is smart enough to create a TKChartDateTimeAxis for us and set it as an XAxis. We are not really interested in the exact moment of time a measurement is shown, so let’s hide the ticks and the labels. For better visibility, the XAxis are black: 

Swift

	let axisColor = TKStroke(color: UIColor.blackColor(), width: 1)
	chart.xAxis.style.lineStroke = axisColor
	chart.xAxis.style.majorTickStyle.ticksHidden = true
	chart.xAxis.style.labelStyle.textHidden = true

Objective-C

	TKStroke *axisColor = [TKStroke strokeWithColor:[UIColor blackColor]];
	axisColor.width = 1;
	_chart.xAxis.style.lineStroke = axisColor;
	_chart.xAxis.style.majorTickStyle.ticksHidden = YES;
	_chart.xAxis.style.labelStyle.textHidden = YES;

![Chart Seismograph by Telerik](http://blogs.telerik.com/images/default-source/ui-for-ios-team/chart-seismograph21DCD07E4482.png?sfvrsn=2 "Chart Seismograph by Telerik")

To beautify the chart and outline the critical vs. normal deviations from the still iPhone state, let’s add several line and band annotations. The band annotations are green, yellow and red, and the line annotations are set with a dash pattern: 

Swift

	let dashStroke = TKStroke(color: UIColor(red: 0, green: 0, blue: 0, alpha: 0.5), width: 0.5)
	dashStroke.dashPattern = [6, 1]
	 
	let annotationBandRed = TKChartBandAnnotation(range: TKRange(minimum: -1000, andMaximum: 1000), forAxis: chart.yAxis)
	annotationBandRed.style.fill = TKSolidFill(color: UIColor(red: 255/255, green: 149/255, blue: 149/255, alpha: 0.7))
	chart.addAnnotation(annotationBandRed)
	 
	let annotationBandYellow = TKChartBandAnnotation(range: TKRange(minimum: -500, andMaximum: 500), forAxis: chart.yAxis)
	annotationBandYellow.style.fill = TKSolidFill(color: UIColor(red: 255/255, green: 255/255, blue: 138/255, alpha: 0.7))
	chart.addAnnotation(annotationBandYellow)
	 
	let annotationBandGreen = TKChartBandAnnotation(range: TKRange(minimum: -300, andMaximum: 300), forAxis: chart.yAxis)
	annotationBandGreen.style.fill = TKSolidFill(color: UIColor(red: 152/255, green: 255/255, blue: 149/255, alpha: 1))
	chart.addAnnotation(annotationBandGreen)
	 
	let positiveDashAnnotation = TKChartGridLineAnnotation(value: 150, forAxis: chart.yAxis)
	positiveDashAnnotation.style.stroke = dashStroke
	chart.addAnnotation(positiveDashAnnotation)
	 
	let negativeDashAnnotation = TKChartGridLineAnnotation(value: -150, forAxis: chart.yAxis)
	negativeDashAnnotation.style.stroke = dashStroke
	chart.addAnnotation(negativeDashAnnotation)

Objective-C

	TKStroke *dashStroke = [TKStroke strokeWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
	dashStroke.dashPattern = @[@6, @1];
	dashStroke.width = 0.5;
	    
	TKChartBandAnnotation *annotationBandRed = [[TKChartBandAnnotation alloc] initWithRange:[[TKRange alloc] initWithMinimum:@(-1000) andMaximum:@(1000)] forAxis:_chart.yAxis];
	annotationBandRed.style.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:255/255.0 green:149/255.0 blue:149/255.0 alpha:0.7]];
	[_chart addAnnotation:annotationBandRed];
	    
	TKChartBandAnnotation *annotationBandYellow = [[TKChartBandAnnotation alloc] initWithRange:[[TKRange alloc] initWithMinimum:@-500 andMaximum:@500] forAxis:_chart.yAxis];
	annotationBandYellow.style.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:252/255.0 green:255/255.0 blue:138/255.0 alpha:0.7]];
	[_chart addAnnotation:annotationBandYellow];
	    
	TKChartBandAnnotation *annotationBandGreen = [[TKChartBandAnnotation alloc] initWithRange:[[TKRange alloc] initWithMinimum:@-300 andMaximum:@300] forAxis:_chart.yAxis];
	annotationBandGreen.style.fill = [TKSolidFill solidFillWithColor:[UIColor colorWithRed:152/255.0 green:255/255.0 blue:149/255.0 alpha:1]];
	[_chart addAnnotation:annotationBandGreen];
	    
	TKChartGridLineAnnotation *positiveDashAnnotation = [[TKChartGridLineAnnotation alloc] initWithValue:@150 forAxis:_chart.yAxis];
	positiveDashAnnotation.style.stroke = dashStroke;
	[_chart addAnnotation:positiveDashAnnotation];
	 
	TKChartGridLineAnnotation *negativeDashAnnotation = [[TKChartGridLineAnnotation alloc] initWithValue:@-150 forAxis:_chart.yAxis];
	negativeDashAnnotation.style.stroke = dashStroke;
	[_chart addAnnotation:negativeDashAnnotation]

![Chart Seismograph with Annotations by Telerik](http://blogs.telerik.com/images/default-source/ui-for-ios-team/chart-seismograph-annotations.png?sfvrsn=2 "Chart Seismograph with Annotations by Telerik")

Finally, let’s add the needle. It’s actually a custom annotation and it’s an example of the flexibility you can achieve with the annotations in TKChart. Note that we are adding the needle when there are more than one point. This is needed by TKChart to create appropriate data range, so that the needle can be displayed at the desired place: 

Swift 

	if dataPoints.count > 1 {
	    let needle = NeedleAnnotation(point:lastPoint, forSeries: lineSeries)
	    needle.zPosition = TKChartAnnotationZPosition.AboveSeries
	    chart.addAnnotation(needle)
	}

Objective-C

	if(dataPoints.count > 1) {
	    NeedleAnnotation *needle = [[NeedleAnnotation alloc] initWithX:dataPoint.dataXValue Y:dataPoint.dataYValue forSeries:lineSeries];
	    needle.zPosition = TKChartAnnotationZPositionAboveSeries;
	    [_chart addAnnotation:needle];
	}



Here is the NeedleAnnotation implementation: 

Swift

	@implementation NeedleAnnotation
	{
	    CGPoint center;
	}
	 
	- (void)layoutInRect:(CGRect)bounds
	{
	    double xval = [self.series.xAxis numericValue:[self.position dataXValue]];
	    double x = [TKChartSeriesRender locationOfValue:xval forAxis:self.series.xAxis inRect:bounds];
	    double yval = [self.series.yAxis numericValue:[self.position dataYValue]];
	    double y = [TKChartSeriesRender locationOfValue:yval forAxis: self.series.yAxis inRect: bounds];
	    center = CGPointMake(x, y);
	}
	 
	- (void)drawInContext:(CGContextRef)context
	{
	    CGContextBeginPath(context);
	    CGContextMoveToPoint(context, center.x-20, center.y);
	    CGContextAddLineToPoint(context, center.x+20, center.y+20);
	    CGContextAddLineToPoint(context, center.x+20, center.y-20);
	        
	    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
	    CGContextFillPath(context);
	}
	 
	@end

Objective-C

	class NeedleAnnotation : TKChartPointAnnotation {
	    
	    var center: CGPoint = CGPoint.zeroPoint
	    
	    override func layoutInRect(bounds: CGRect) {
	        let xval = self.series.xAxis.numericValue(self.position.dataXValue())
	        let x = TKChartSeriesRender.locationOfValue(xval, forAxis: self.series.xAxis, inRect: bounds)
	        let yval = self.series.yAxis.numericValue(self.position.dataYValue())
	        let y = TKChartSeriesRender.locationOfValue(yval, forAxis: self.series.yAxis, inRect: bounds)
	        center = CGPointMake(x, y)
	    }
	    
	    override func drawInContext(context: CGContextRef) {
	        CGContextBeginPath(context)
	        CGContextMoveToPoint(context, center.x-20, center.y)
	        CGContextAddLineToPoint(context, center.x+20, center.y+20)
	        CGContextAddLineToPoint(context, center.x+20, center.y-20)
	        
	        CGContextSetRGBFillColor(context, 0, 0, 0, 1)
	        CGContextFillPath(context)
	    }
	}


![Chart Seismograph with Needle Annotation by Telerik](http://blogs.telerik.com/images/default-source/ui-for-ios-team/chart-seismograph-needle.png?sfvrsn=2 "Chart Seismograph with Needle Annotation by Telerik")

This is all you need to achieve a nice looking seismograph app. Of course, using the simulator will not allow you to simulate the device movement, so you will end up with a blank screen. The image at the beginning of this article was made with the help of a real device, and the new Mac OS X Yosemite’s QuickTime feature that allows you to cast your phone screen.

Note that this project will require UI for iOS to be installed. [Download UI for iOS here](http://www.telerik.com/download/ios-ui) if you have not done so already.

Happy coding!