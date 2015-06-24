using System;

using Foundation;
using UIKit;
using CoreGraphics;
using TelerikUI;

namespace Examples
{
	public class AlertSettings : ExampleViewController
	{
		TKDataFormEntityDataSource dataSource;
		TKDataForm dataForm;
		Settings settings;

		public AlertSettings()
		{
			this.AddOption ("Show Alert", ShowAlert);
		}
			
		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			settings = new Settings ();

			dataSource = new TKDataFormEntityDataSource ();
			dataSource.SelectedObject = settings;
			dataSource.AllowPropertySorting = true;

			dataSource.EntityModel.PropertyWithName ("Title").PropertyIndex = 0;
			dataSource.EntityModel.PropertyWithName ("Message").PropertyIndex = 1;
			dataSource.EntityModel.PropertyWithName ("AllowParallaxEffect").PropertyIndex = 2;
			dataSource.EntityModel.PropertyWithName ("BackgroundStyle").PropertyIndex = 3;
			dataSource.EntityModel.PropertyWithName ("ActionsLayout").PropertyIndex = 4;
			dataSource.EntityModel.PropertyWithName ("DismissMode").PropertyIndex = 5;
			dataSource.EntityModel.PropertyWithName ("DismissDirection").PropertyIndex = 6;
			dataSource.EntityModel.PropertyWithName ("AnimationDuration").PropertyIndex = 7;
			dataSource.EntityModel.PropertyWithName ("BackgroundDim").PropertyIndex = 8;

			dataForm = new TKDataForm ();
			dataForm.Frame = this.ExampleBounds;
			dataForm.Delegate = new DataFormDelegate ();
			this.View.AddSubview (dataForm);

			dataForm.RegisterEditor (new ObjCRuntime.Class (typeof(TKDataFormSegmentedEditor)), dataSource.EntityModel.PropertyWithName ("ActionsLayout"));
			dataForm.RegisterEditor (new ObjCRuntime.Class (typeof(TKDataFormSegmentedEditor)), dataSource.EntityModel.PropertyWithName ("BackgroundStyle"));
			dataForm.RegisterEditor (new ObjCRuntime.Class (typeof(TKDataFormSegmentedEditor)), dataSource.EntityModel.PropertyWithName ("DismissMode"));
			dataForm.RegisterEditor (new ObjCRuntime.Class (typeof(TKDataFormSegmentedEditor)), dataSource.EntityModel.PropertyWithName ("DismissDirection"));
			dataForm.CommitMode = TKDataFormCommitMode.Delayed;
			dataForm.AutoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
			dataForm.DataSource = dataSource;

			this.View.BackgroundColor = new UIColor(0.937f, 0.937f, 0.957f, 1.00f);
		}

		public void ShowAlert(Object sender, EventArgs e)
		{
			dataForm.Commit ();

			TKAlert alert = new TKAlert ();

			alert.Title = settings.Title;
			alert.Message = settings.Message;
			alert.AllowParallaxEffect = settings.AllowParallaxEffect;
			alert.Style.BackgroundStyle = settings.BackgroundStyle;
			alert.ActionsLayout = settings.ActionsLayout;
			alert.DismissMode = settings.DismissMode;
			alert.SwipeDismissDirection = settings.DismissDirection;
			alert.AnimationDuration = (float)settings.AnimationDuration;
			alert.Style.BackgroundDimAlpha = (float)settings.BackgroundDim;

			alert.AddActionWithTitle("Shake",  (TKAlert al, TKAlertAction action) => {
				alert.Shake();
				return false;
			});

			alert.AddActionWithTitle("Touch", (TKAlert al, TKAlertAction action) => false);

			alert.AddActionWithTitle("Close",  (TKAlert al, TKAlertAction action) => {
				Console.WriteLine("Close");
				return true;
			});

			alert.Show (true);
		}
	}

	class DataFormDelegate : TKDataFormDelegate
	{
		public override void UpdateEditor (TKDataForm dataForm, TKDataFormEditor editor, TKDataFormEntityProperty property)
		{
			if (property.Name == "ActionsLayout") {
				TKDataFormSegmentedEditor segmentedEditor = (TKDataFormSegmentedEditor)editor;
				segmentedEditor.Segments = new NSObject[] {new NSString("Horizontal"), new NSString("Vertical")};
			}

			if (property.Name == "BackgroundStyle") {
				TKDataFormSegmentedEditor segmentedEditor = (TKDataFormSegmentedEditor)editor;
				segmentedEditor.Segments = new NSObject[] {new NSString("Blur"), new NSString("Dim")};
			}

			if (property.Name == "DismissMode") {
				TKDataFormSegmentedEditor segmentedEditor = (TKDataFormSegmentedEditor)editor;
				segmentedEditor.Segments = new NSObject[] {new NSString("None"), new NSString("Tap"), new NSString("Swipe")};
			}

			if (property.Name == "DismissDirection") {
				TKDataFormSegmentedEditor segmentedEditor = (TKDataFormSegmentedEditor)editor;
				segmentedEditor.Segments = new NSObject[] {new NSString("Horizontal"), new NSString("Vertical")};
			}
		}
	}
}

