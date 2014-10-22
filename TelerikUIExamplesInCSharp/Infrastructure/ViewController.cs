using System;
using System.Drawing;
using System.Collections.Generic;

using MonoTouch.Foundation;
using MonoTouch.UIKit;

namespace Examples
{
	public partial class ViewController : UIViewController
	{
		UITableView tableView;

		public ExampleInfo[] Examples { get; set; }

		public ViewController()
		{
			this.Examples = new ExampleInfo[] { 
				new ExampleInfo("Chart", new ExampleInfo[] {

					new ExampleInfo("Chart Types", new ExampleInfo[] {
						new ExampleInfo("Column / Bar chart", typeof(ColumnAndBarChart)),
						new ExampleInfo("Line / Area / Spline chart", typeof(LineAreaSpline)),
						new ExampleInfo("Scatter chart", typeof(ScatterChart)),
						new ExampleInfo("Bubble chart", typeof(BubbleChart)),
						new ExampleInfo("Pie chart", typeof(PieDonut)),
						new ExampleInfo("Stacked Column chart", typeof(StackedColumnChart)),
						new ExampleInfo("Stacked Area chart", typeof(StackedAreaChart)),
						new ExampleInfo("Financial chart", typeof(FinancialChart)),
						new ExampleInfo("Indicators", typeof(IndicatorsChart)),
					}),

					new ExampleInfo("Axis Types", new ExampleInfo[] {
						new ExampleInfo("Numeric axis", typeof(NumericAxis)),
						new ExampleInfo("Categorical axis", typeof(CategoricalAxis)),
						new ExampleInfo("Date/Time axis", typeof(DateTimeAxis)),
						new ExampleInfo("Multiple axes", typeof(MultipleAxes)),
						new ExampleInfo("Negative values", typeof(NegativeValues)),
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
				new ExampleInfo("Calendar", new ExampleInfo[] {
					new ExampleInfo("Calendar with events", typeof(CalendarWithEvents)),
					new ExampleInfo("Transition Effects", typeof(CalendarTransitionEffects)),
					new ExampleInfo("Selection", typeof(CalendarSelection)),
					new ExampleInfo("iOS 7 style calendar", typeof(iOS7StyleCalendar)),
					new ExampleInfo("View modes", typeof(CalendarViewModes)),
					new ExampleInfo("Customization", typeof(CalendarCustomization)),
					new ExampleInfo("EventKit data binding", typeof(CalendarEventKitDataBinding)),
					new ExampleInfo("Localized calendar", typeof(LocalizedCalendar))
				}),
				new ExampleInfo("Feedback", typeof(FeedbackExampleController))
			};
		}

		public ViewController(ExampleInfo[] examples)
		{
			this.Examples = examples;
		}

		public override void DidReceiveMemoryWarning ()
		{
			// Releases the view if it doesn't have a superview.
			base.DidReceiveMemoryWarning ();
			
			// Release any cached data, images, etc that aren't in use.
		}

		#region View lifecycle

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();


			// Perform any additional setup after loading the view, typically from a nib.

			this.tableView = new UITableView ();
			this.tableView.RegisterClassForCellReuse (typeof(UITableViewCell), new NSString("cell"));
			this.tableView.Frame = this.View.Bounds;
			if (this.Examples != null) {
				this.tableView.DataSource = new TableViewDataSource(this);
				this.tableView.Delegate = new TableViewDelegate (this);
			}
			this.View.AddSubview (this.tableView);
		}

		public override void ViewWillAppear (bool animated)
		{
			base.ViewWillAppear (animated);
		}

		public override void ViewDidAppear (bool animated)
		{
			base.ViewDidAppear (animated);
		}

		public override void ViewWillDisappear (bool animated)
		{
			base.ViewWillDisappear (animated);
		}

		public override void ViewDidDisappear (bool animated)
		{
			base.ViewDidDisappear (animated);
		}

		#endregion

		public class TableViewDataSource: UITableViewDataSource
		{
			ViewController owner;

			public TableViewDataSource(ViewController owner)
			{
				this.owner = owner;
			}

			public override int RowsInSection (UITableView tableView, int section)
			{
				return owner.Examples.Length;
			}

			public override UITableViewCell GetCell (UITableView tableView, NSIndexPath indexPath)
			{
				ExampleInfo info = owner.Examples [indexPath.Row];
				UITableViewCell cell = tableView.DequeueReusableCell ("cell");
				cell.TextLabel.Text = info.Title;
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

			public override void RowSelected (UITableView tableView, NSIndexPath indexPath)
			{
				ExampleInfo info = owner.Examples [indexPath.Row];
				UIViewController viewController = info.CreateViewController ();
				owner.NavigationController.PushViewController (viewController, true);
			}
		}
	}
}

