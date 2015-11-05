//
//  ViewController.swift
//  Swift Examples
//
//  Copyright (c) 2014 Telerik. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var examples = [ExampleInfo]()
    
    func initWithExample(example:ExampleInfo) {
        self.examples = example.examples
        self.title = example.title
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()

        if (examples.count == 0) {
            self.initExamples()
            self.title = "Examples"
        }
        
        let table = UITableView(frame: self.view.bounds)
        table.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        table.delegate = self
        table.dataSource = self
        table.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(table)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initExamples() {
        
        examples.removeAll()

        examples.append(ExampleInfo(title: "Alert", exampleList: [
            ExampleInfo(title: "Getting started") { AlertGettingStarted() },
            ExampleInfo(title: "Animations") { AlertAnimations() },
            ExampleInfo(title: "Notifications") { AlertNotifications() },
            ExampleInfo(title: "Custom View") { AlertCustomView() },
            ExampleInfo(title: "Customize") { AlertCustomize() },
            ExampleInfo(title: "Settings") { AlertSettings() },
            ]))
        
        examples.append(ExampleInfo(title: "AppFeedback") { FeedbackExampleController(nibName: "FeedbackExampleController", bundle: nil) })
        
        examples.append(ExampleInfo(title: "AutoCompleteTextView (Beta)", exampleList:[
            ExampleInfo(title: "Getting Started") { AutoCompleteGettingStartedViewController() },
            ExampleInfo(title: "Customization") { AutoCompleteCustomization() },
            ExampleInfo(title: "Tokens") { AutoCompleteTokens() },
            ]))
        
        examples.append(ExampleInfo(title: "Calendar", exampleList:[
            ExampleInfo(title: "Calendar with events") { CalendarWithEvents() },
            ExampleInfo(title: "View modes") { CalendarViewModes() },
            ExampleInfo(title: "Transition effects") { CalendarTransitonEffects() },
            ExampleInfo(title: "Selection") { CalendarSelection() },
            ExampleInfo(title: "iOS 7 style calendar") { iOS7StyleCalendar() },
            ExampleInfo(title: "Customization") { CalendarCustomization() },
            ExampleInfo(title: "EventKit data binding") { CalendarEventKitDataBinding() },
            ExampleInfo(title: "Localized calendar") { LocalizedCalendar() },
            ExampleInfo(title: "Inline events") { InlineEvents() },
            ]))
        
        examples.append(ExampleInfo(title: "Chart", exampleList:[
            ExampleInfo(title: "Chart Types", exampleList:[
                ExampleInfo(title: "Column / Bar chart") { ColumnAndBarChart() },
                ExampleInfo(title: "Range Column / Bar chart") { RangeBarColumnChart() },
                ExampleInfo(title: "Line / Area / Spline chart") { LineAreaSpline() },
                ExampleInfo(title: "Scatter chart") { ScatterChart() },
                ExampleInfo(title: "Bubble chart") { BubbleChart() },
                ExampleInfo(title: "Pie chart") { PieDonut() },
                ExampleInfo(title: "Stacked Column chart") { StackedColumnChart() },
                ExampleInfo(title: "Stacked Area chart") { StackedAreaChart() },
                ExampleInfo(title: "Gaps Line / Spline / Area chart") { GapsLineSplineAreaChart() },
                ExampleInfo(title: "Financial chart") { FinancialChart() },
                ExampleInfo(title: "Indicators") { Indicators() },
                ]),
            ExampleInfo(title: "Axis Types", exampleList:[
                ExampleInfo(title: "Numeric axis") { NumericAxis() },
                ExampleInfo(title: "Categorical axis") { CategoricalAxis() },
                ExampleInfo(title: "Date/Time axis") { DateTimeAxis() },
                ExampleInfo(title:"Date/Time category axis") { DateTimeCategoryAxis() },
                ExampleInfo(title: "Multiple axes") { MultipleAxes() },
                ExampleInfo(title: "Negative values") { NegativeValues() },
                ExampleInfo(title: "Logarithmic axis") { LogarithmicAxis() },
                ExampleInfo(title: "CustomAxis"){ CustomAxis() }
                ]),
            ExampleInfo(title: "Animations", exampleList:[
                ExampleInfo(title: "Default animations") { DefaultAnimation() },
                ExampleInfo(title: "Custom animation - line chart") { CustomAnimationLineChart() },
                ExampleInfo(title: "Custom animation - area chart") { CustomAnimationAreaChart() },
                ExampleInfo(title: "Custom animation - pie chart") { CustomAnimationPieChart() },
                ExampleInfo(title: "UIKit dynamics animation") { UIKitDynamicsAnimation() }
                ]),
            ExampleInfo(title: "Binding", exampleList:[
                ExampleInfo(title: "Bind with data point") { BindWithDataPoint() },
                ExampleInfo(title: "Bind with custom object") { BindWithCustomObject() },
                ExampleInfo(title: "Bind with delegate") { BindWithDelegate() }
                ]),
            ExampleInfo(title: "Pan/Zoom") { PanZoom() },
            ExampleInfo(title: "Customize") { Customize() },
            ExampleInfo(title: "Annotations", exampleList:[
                ExampleInfo(title: "Band and line annotations") { BandAndLineAnnotation() },
                ExampleInfo(title: "Balloon annotation") { BalloonAnnotation() },
                ExampleInfo(title: "Layer annotation") { LayerAnnotation() },
                ExampleInfo(title: "View annotation") { ViewAnnotation() },
                ExampleInfo(title: "Cross line annotation") { CrossLineAnnotation() },
                ExampleInfo(title: "Custom annotation") { CustomAnnotation() },
                ExampleInfo(title: "Trackball") { Trackball() }
                ]),
            ExampleInfo(title: "Point Labels", exampleList: [
                ExampleInfo(title: "Point Labels") { PointLabels() },
                ExampleInfo(title: "Custom Label") { CustomPointLabels() },
                ExampleInfo(title: "Custom Label Render") { CustomPointLabelRender() }
                ]),
            ExampleInfo(title: "Live data") { LiveData() }
            ]))
        
        examples.append(ExampleInfo(title: "DataForm (New)", exampleList: [
            ExampleInfo(title: "Getting started") { DataFormGettingStarted()},
            ExampleInfo(title: "Validation") { DataFormValidation()},
            ExampleInfo(title: "Read Only") { DataFormReadOnly()},
            ExampleInfo(title: "Customization") { DataFormCustomization()},
            ExampleInfo(title: "Collapsible Groups") { DataFormCollapsibleGroups()},
            ExampleInfo(title: "Alignment") { DataFormLabelsAlignment()},
            ExampleInfo(title: "JSON Support") { DataFormJSONSupport()}
            ]))
        
        examples.append(ExampleInfo(title: "DataSource", exampleList:[
            ExampleInfo(title: "Getting started") { DataSourceGettingStarted() },
            ExampleInfo(title: "Descriptors API") { DataSourceDescriptorsAPI() },
            ExampleInfo(title: "Bind with UI controls") { DataSourceUIBindings() },
            ExampleInfo(title: "Consume web service") { DataSourceWithWebService() },
            ]))
        
        examples.append(ExampleInfo(title: "Gauges (New)", exampleList: [
            ExampleInfo(title: "Getting started") { GaugeGettingStarted() },
            ExampleInfo(title: "Customization") { GaugeCustomization() },
            ExampleInfo(title: "Interaction") { GaugeInteraction() },
            ExampleInfo(title: "Animations") { GaugeAnimations() },
            ExampleInfo(title: "Scales") { GaugeScales() },
            ExampleInfo(title: "Ranges") { GaugeRanges() },
            ]))
        
        examples.append(ExampleInfo(title: "ListView", exampleList: [
            ExampleInfo(title: "Getting started") { ListViewGettingStarted() },
            ExampleInfo(title: "Swipe cell") { ListViewSwipe() },
            ExampleInfo(title: "Items reorder") { ListViewReorder() },
            ExampleInfo(title: "Selection") { ListViewSelection() },
            ExampleInfo(title: "Grouping") { ListViewGroups() },
            ExampleInfo(title: "Layouts"){ ListViewLayout() },
            ExampleInfo(title: "Animations") { ListViewAnimations() },
            ExampleInfo(title: "Load on demand") { ListViewLoadOnDemand() },
            ExampleInfo(title: "Pull to refresh") { ListViewPullToRefresh() },
            ]))
        
        examples.append(ExampleInfo(title: "SideDrawer", exampleList: [
            ExampleInfo(title: "Getting Started") { SideDrawerGettingStarted() },
            ExampleInfo(title: "Transitions") { SideDrawerTransitions() },
            ExampleInfo(title: "Custom Content") { SideDrawerCustomContent() },
            ExampleInfo(title: "Custom Transition") { SideDrawerCustomTransition() },
            ExampleInfo(title: "Positions") { SideDrawerPositions() },
            ExampleInfo(title: "Multiple SideDrawers") { MultipleSideDrawers() }
            ]))
    }
    
//MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return examples.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")!
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.textLabel!.text = examples[indexPath.row].title
        return cell
    }
    
//MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let controller = examples[indexPath.row].createController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

