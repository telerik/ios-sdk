using System;
using System.Drawing;
using System.Collections.Generic;

using Foundation;
using UIKit;

namespace Examples
{
	public partial class ViewController : UIViewController
	{
		UITableView tableView;
		TableViewDataSource tableViewDataSource;
		TableViewDelegate tableViewDelegate;
		public ExampleInfo[] Examples;

		public ViewController(ExampleInfo[] examples)
		{
			this.Examples = examples;
		}
			
		#region View lifecycle

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			if (this.Examples == null) {
				ExampleInfo[] examples = new ExampleInfo[] { 

					new ExampleInfo("Alert", new ExampleInfo[] {
						new ExampleInfo("Getting Started", typeof(AlertGettingStarted)),
						new ExampleInfo("Notifications", typeof(AlertNotifications)),
						new ExampleInfo("Animations", typeof(AlertAnimations)),
						new ExampleInfo("Custom View", typeof(AlertCustomView)),
						new ExampleInfo("Customize", typeof(AlertViewCustomize)),
						new ExampleInfo("Settings", typeof(AlertSettings)),
					}),

					new ExampleInfo("AppFeedback", typeof(FeedbackExampleController)),

					new ExampleInfo("AutoCompleteTextView (Beta)", new ExampleInfo[] {
						new ExampleInfo("Getting Started", typeof(AutoCompleteGettingStarted)),
						new ExampleInfo("Customization", typeof(AutoCompleteCustomize)),
						new ExampleInfo("Tokens", typeof(AutoCompleteTokens)),
					}),

					new ExampleInfo("Calendar", new ExampleInfo[] {
						new ExampleInfo("Calendar with events", typeof(CalendarWithEvents)),
						new ExampleInfo("Transition Effects", typeof(CalendarTransitionEffects)),
						new ExampleInfo("Selection", typeof(CalendarSelection)),
						new ExampleInfo("iOS 7 style calendar", typeof(iOS7StyleCalendar)),
						new ExampleInfo("View modes", typeof(CalendarViewModes)),
						new ExampleInfo("Customization", typeof(CalendarCustomization)),
						new ExampleInfo("EventKit data binding", typeof(CalendarEventKitDataBinding)),
						new ExampleInfo("Localized calendar", typeof(LocalizedCalendar)),
						new ExampleInfo("Inline events", typeof(InlineEvents)),
					}),

					new ExampleInfo("Chart", new ExampleInfo[] {

						new ExampleInfo("Chart Types", new ExampleInfo[] {
							new ExampleInfo("Column / Bar chart", typeof(ColumnAndBarChart)),
							new ExampleInfo("Range Column / Bar chart", typeof(RangeColumnBarChart)),
							new ExampleInfo("Line / Area / Spline chart", typeof(LineAreaSpline)),
							new ExampleInfo("Scatter chart", typeof(ScatterChart)),
							new ExampleInfo("Bubble chart", typeof(BubbleChart)),
							new ExampleInfo("Pie chart", typeof(PieDonut)),
							new ExampleInfo("Stacked Column chart", typeof(StackedColumnChart)),
							new ExampleInfo("Stacked Area chart", typeof(StackedAreaChart)),
							new ExampleInfo("Gaps Line / Spline / Area chart", typeof(GapsLineSplineAreaChart)),
							new ExampleInfo("Financial chart", typeof(FinancialChart)),
							new ExampleInfo("Indicators", typeof(IndicatorsChart)),
						}),

						new ExampleInfo("Axis Types", new ExampleInfo[] {
							new ExampleInfo("Numeric axis", typeof(NumericAxis)),
							new ExampleInfo("Categorical axis", typeof(CategoricalAxis)),
							new ExampleInfo("Date/Time axis", typeof(DateTimeAxis)),
							new ExampleInfo("Date/Time category axis", typeof(DateTimeCategoryAxis)),
							new ExampleInfo("Multiple axes", typeof(MultipleAxes)),
							new ExampleInfo("Negative values", typeof(NegativeValues)),
							new ExampleInfo("Logarithmic Axis", typeof(LogarithmicAxis)),
							new ExampleInfo("Custom Axis", typeof(CustomAxis))
						}),

						new ExampleInfo("Animations", new ExampleInfo[] {
							new ExampleInfo("Default animations", typeof(DefaultAnimation)),
							new ExampleInfo("Custom animation - line chart", typeof(CustomAnimationLineChart)),
							new ExampleInfo("Custom animation - area chart", typeof(CustomAnimationAreaChart)),
							new ExampleInfo("Custom animation - pie chart", typeof(CustomAnimationPieChart)),
							new ExampleInfo("UIKit dynamics animation", typeof(UIKitDynamicsAnimation)),
						}),

						new ExampleInfo("Binding", new ExampleInfo[] {
							new ExampleInfo("Bind with data point", typeof(BindingWithDataPoint)),
							new ExampleInfo("Bind with custom object", typeof(BindingWithCustomObject)),
							new ExampleInfo("Bind with delegate", typeof(BindingWithDelegate)),
						}),

						new ExampleInfo("Pan/Zoom", typeof(PanZoom)),
						new ExampleInfo("Customize", typeof(Customize)),

						new ExampleInfo("Annotations", new ExampleInfo[] {
							new ExampleInfo("Band and line annotations", typeof(BandAndLineAnnotations)),
							new ExampleInfo("Balloon annotation", typeof(BalloonAnnotation)),
							new ExampleInfo("Layer annotation", typeof(LayerAnnotation)),
							new ExampleInfo("View annotation", typeof(ViewAnnotation)),
							new ExampleInfo("Cross line annotation", typeof(CrossLineAnnotation)),
							new ExampleInfo("Custom annotation", typeof(CustomAnnotation)),
							new ExampleInfo("Trackball", typeof(Trackball)),
						}),

						new ExampleInfo("Point Labels", new ExampleInfo[] {
							new ExampleInfo("Point Labels", typeof(PointLabels)),
							new ExampleInfo("Custom Point Label", typeof(CustomPointLabels)),
							new ExampleInfo("Custom Label Render",typeof(CustomPointLabelRender))
						}),
						new ExampleInfo("Live data", typeof(LiveData))
					}),

					new ExampleInfo("DataForm (New)", new ExampleInfo[] {
						new ExampleInfo("Getting Started", typeof(DataFormGettingStarted)),
						new ExampleInfo("Read Only", typeof(DataFormReadOnly)),
						new ExampleInfo("Validation", typeof(DataFormValidation)),
						new ExampleInfo("Customization", typeof(DataFormCustomization)),
						new ExampleInfo("Collapsable Groups", typeof(DataFormCollapsibleGroups)),
						new ExampleInfo("Alignment", typeof(DataFormAlignment)),
						new ExampleInfo("JSON Support", typeof(DataFormJSONSupport))
					}),

					new ExampleInfo("DataSource", new ExampleInfo[] {
						new ExampleInfo("Getting started", typeof(DataSourceGettingStarted)),
						new ExampleInfo("Descriptors API", typeof(DataSourceDescriptorsAPI)),
						new ExampleInfo("Bind with UI controls", typeof(DataSourceUIBindings)),
						new ExampleInfo("Consume web service", typeof(DataSourceWithWebService)),
					}),

					new ExampleInfo("ListView", new ExampleInfo[] {
						new ExampleInfo("Getting Started", typeof(ListViewGettingStarted)),
						new ExampleInfo("Swipe cell", typeof(ListViewSwipe)),
						new ExampleInfo("Items reorder", typeof(ListViewReorder)),
						new ExampleInfo("Selection", typeof(ListViewSelection)),
						new ExampleInfo("Grouping", typeof(ListViewGroups)),
						new ExampleInfo("Layouts", typeof(ListViewLayout)),
						new ExampleInfo("Animations", typeof(ListViewAnimations)),
						new ExampleInfo("Load on demand", typeof(ListViewLoadOnDemand)),
						new ExampleInfo("Pull to refresh", typeof(ListViewPullToRefresh)),
					}),

					new ExampleInfo("SideDrawer", new ExampleInfo[] {
						new ExampleInfo("Getting Started", typeof(SideDrawerGettingStarted)),
						new ExampleInfo("Transitions", typeof(SideDrawerTransitions)),
						new ExampleInfo("Positions", typeof(SideDrawerPositions)),
						new ExampleInfo("Custom Content", typeof(SideDrawerCustomContent)),
						new ExampleInfo("Custom Transition", typeof(SideDrawerCustomTransition)),
						new ExampleInfo("Multiple SideDrawers", typeof(MultipleSideDrawers))
					}),

					new ExampleInfo("Gauges (New)", new ExampleInfo[] {
						new ExampleInfo("Getting Started", typeof(GaugesGettingStarted)),
						new ExampleInfo("Customization", typeof(GaugeCustomization)),
						new ExampleInfo("Interaction", typeof(GaugeInteraction)),
						new ExampleInfo("Animations", typeof(GaugeValueAnimation)),
						new ExampleInfo("Scales", typeof(GaugeMultipleScales)),
						new ExampleInfo("Ranges", typeof(GaugeMultipleRanges)),
					}),
				};
				this.Examples = examples;
				this.Title = "Examples";
			}

			this.tableView = new UITableView ();
			this.tableView.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.tableView.RegisterClassForCellReuse (typeof(UITableViewCell), new NSString("cell"));
			this.tableView.Frame = this.View.Bounds;
			this.tableViewDataSource = new TableViewDataSource (this);
			this.tableViewDelegate = new TableViewDelegate (this);
			this.tableView.DataSource = this.tableViewDataSource;
			this.tableView.Delegate = this.tableViewDelegate;
			this.View.AddSubview (this.tableView);
		}

		#endregion

		public class TableViewDataSource: UITableViewDataSource
		{
			ViewController owner;

			public TableViewDataSource(ViewController owner)
			{
				this.owner = owner;
			}

			protected override void Dispose (bool disposing)
			{
				base.Dispose (disposing);
				this.owner = null;
			}

			public override nint RowsInSection (UITableView tableView, nint section)
			{
				return owner.Examples.Length;
			}

			public override UITableViewCell GetCell (UITableView tableView, NSIndexPath indexPath)
			{
				ExampleInfo info = owner.Examples [indexPath.Row];
				UITableViewCell cell = tableView.DequeueReusableCell ("cell");
				cell.TextLabel.Text = info.Title;
				cell.SelectionStyle = UITableViewCellSelectionStyle.None;
				return cell;
			}
		}

		public class TableViewDelegate: UITableViewDelegate
		{
			ViewController owner;

			public TableViewDelegate(ViewController owner)
			{
				this.owner = owner;
			}

			protected override void Dispose (bool disposing)
			{
				base.Dispose (disposing);
				this.owner = null;
			}

			public override void RowSelected (UITableView tableView, NSIndexPath indexPath)
			{
				ExampleInfo info = owner.Examples [indexPath.Row];
				UIViewController viewController = info.CreateViewController ();
				owner.NavigationController.PushViewController (viewController, true);
				GC.Collect (GC.MaxGeneration, GCCollectionMode.Forced);
			}
		}
	}
}

