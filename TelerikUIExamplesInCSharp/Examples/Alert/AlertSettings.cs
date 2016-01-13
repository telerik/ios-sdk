using System;

using Foundation;
using UIKit;
using CoreGraphics;
using TelerikUI;

namespace Examples
{
	[Register("AlertSettings")]
	public class AlertSettings : XamarinExampleViewController
	{
		TKDataFormEntityDataSourceHelper dataSource;
		TKDataForm dataForm;
		Settings settings;
			
		public override void ViewDidLoad ()
		{
			this.AddOption ("Show Alert", ShowAlert);

			base.ViewDidLoad ();

			this.AutomaticallyAdjustsScrollViewInsets = false;

			settings = new Settings ();
			this.dataSource = new TKDataFormEntityDataSourceHelper (settings);

			dataSource["Title"].Index = 0;
			dataSource["Message"].Index = 1;
			dataSource["AllowParallax"].Index = 2;
			dataSource["BackgroundStyle"].Index = 3;
			dataSource["ActionsLayout"].Index = 4;
			dataSource["DismissMode"].Index = 5;
			dataSource["DismissDirection"].Index = 6;
			dataSource["AnimationDuration"].Index = 7;
			dataSource["BackgroundDim"].Index = 8;

			dataSource["ActionsLayout"].ValuesProvider = NSArray.FromObjects(new string[] { "Horizontal", "Vertical" });
			dataSource["BackgroundStyle"].ValuesProvider = NSArray.FromObjects(new string[] { "Blur", "Dim" });
			dataSource["DismissMode"].ValuesProvider = NSArray.FromObjects (new string[] { "None", "Tap", "Swipe" });
			dataSource["DismissDirection"].ValuesProvider = NSArray.FromObjects (new string[] { "Horizontal", "Vertical" });

			dataForm = new TKDataForm (this.View.Bounds);
			dataForm.WeakDataSource = this.dataSource.NativeObject;
			dataForm.CommitMode = TKDataFormCommitMode.Manual;
			dataForm.AutoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
			this.View.AddSubview (dataForm);

			if (UIDevice.CurrentDevice.UserInterfaceIdiom == UIUserInterfaceIdiom.Pad) {
				dataForm.Frame = this.View.Bounds;
				this.View.BackgroundColor = new UIColor(0.937f, 0.937f, 0.957f, 1.00f);
			}

			this.View.BackgroundColor = new UIColor(0.937f, 0.937f, 0.957f, 1.00f);
		}

		public void ShowAlert()
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
}

