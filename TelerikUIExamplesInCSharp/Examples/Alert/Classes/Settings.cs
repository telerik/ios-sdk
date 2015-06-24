using System;

using Foundation;
using UIKit;
using CoreGraphics;
using TelerikUI;

namespace Examples
{
	public class Settings : NSObject
	{
		[Export("Title")]
		public NSString Title { get; set; } = new NSString("Alert");

		[Export("Message")]
		public NSString Message { get; set; } = new NSString("Hello world");

		[Export("AllowParallaxEffect")] 
		public bool AllowParallaxEffect { get; set; } = false;

		[Export("BackgroundStyle")] 
		public TKAlertBackgroundStyle BackgroundStyle { get; set; } = TKAlertBackgroundStyle.Dim;

		[Export("ActionsLayout")] 
		public TKAlertActionsLayout ActionsLayout { get; set; } = TKAlertActionsLayout.Horizontal;

		[Export("DismissMode")] 
		public TKAlertDismissMode DismissMode { get; set; } = TKAlertDismissMode.None;

		[Export("DismissDirection")] 
		public TKAlertSwipeDismissDirection DismissDirection { get; set; } = TKAlertSwipeDismissDirection.Horizontal;

		[Export("AnimationDuration")] 
		public double AnimationDuration { get; set; } = 0.3;

		[Export("BackgroundDim")] 
		public double BackgroundDim { get; set; } = 0.3;
	}
}

