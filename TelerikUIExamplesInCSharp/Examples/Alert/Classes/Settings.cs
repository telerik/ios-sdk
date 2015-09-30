using System;

using Foundation;
using UIKit;
using CoreGraphics;
using TelerikUI;

namespace Examples
{
	public class Settings : NSObject
	{
		public Settings()
		{
			this.Title = new NSString ("Alert");
			this.Message = new NSString ("Hello World");
			this.AllowParallaxEffect = false;
			this.BackgroundStyle = TKAlertBackgroundStyle.Dim;
			this.ActionsLayout = TKAlertActionsLayout.Horizontal;
			this.DismissMode = TKAlertDismissMode.None;
			this.DismissDirection = TKAlertSwipeDismissDirection.Horizontal;
			this.AnimationDuration = 0.3;
			this.BackgroundDim = 0.3;
		}

		[Export("Title")]
		public NSString Title { get; set; }

		[Export("Message")]
		public NSString Message { get; set; }

		[Export("AllowParallax")] 
		public bool AllowParallaxEffect { get; set; }

		[Export("BackgroundStyle")] 
		public TKAlertBackgroundStyle BackgroundStyle { get; set; }

		[Export("ActionsLayout")] 
		public TKAlertActionsLayout ActionsLayout { get; set; }

		[Export("DismissMode")] 
		public TKAlertDismissMode DismissMode { get; set; }

		[Export("DismissDirection")] 
		public TKAlertSwipeDismissDirection DismissDirection { get; set; }

		[Export("AnimationDuration")] 
		public double AnimationDuration { get; set; }

		[Export("BackgroundDim")] 
		public double BackgroundDim { get; set; }
	}
}

