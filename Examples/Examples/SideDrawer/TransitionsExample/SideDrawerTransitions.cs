using System;
using UIKit;
using Foundation;
using CoreGraphics;
using ObjCRuntime;
using TelerikUI;

namespace Examples
{
	[Register("SideDrawerTransitions")]
	public class SideDrawerTransitions : SideDrawerGettingStarted
	{
		UIScrollView scrollView = new UIScrollView();
		float buttonY = 0;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			scrollView.Frame = CGRect.Empty;
			scrollView.ScrollEnabled = true;
			this.AddButtons ();

			this.SideDrawerView.MainView.AddSubview (scrollView);
			this.SideDrawerView.BackgroundColor = UIColor.Gray;
		}

		public override void ViewDidLayoutSubviews ()
		{
			base.ViewDidLayoutSubviews ();
			scrollView.Frame = new CGRect (0, 44, this.SideDrawerView.Bounds.Width, this.SideDrawerView.Bounds.Height - 44);
		}

		public virtual void AddButtons ()
		{
			this.CreateButton ("Push", this, new Selector ("PushTransition"));
			this.CreateButton ("Reveal", this, new Selector ("RevealTransition"));
			this.CreateButton ("Reverse Slide Out", this, new Selector ("ReverseSlideOutTransition"));
			this.CreateButton ("Slide Along", this, new Selector ("SlideAlongTransition"));
			this.CreateButton ("Slide In On Top", this, new Selector ("SlideInOnTopTransition"));
			this.CreateButton ("Scale Up", this, new Selector ("ScaleUpTransition"));
			this.CreateButton ("Fade In", this, new Selector ("FadeInTransition"));
			this.CreateButton ("Scale Down Pusher", this, new Selector ("ScaleDownPusherTransition"));
		}

		[Export ("PushTransition")]
		private void PushTransition() 
		{
			TKSideDrawer sideDrawer = this.SideDrawerView.SideDrawers [0];
			sideDrawer.TransitionType = TKSideDrawerTransitionType.Push;
			// >> drawer-transitions-duration-cs
			sideDrawer.TransitionDuration = 0.5f;
			// << drawer-transitions-duration-cs
			sideDrawer.Fill = new TKSolidFill (UIColor.Gray);
			sideDrawer.HeaderView = new SideDrawerHeader (false, null, null);
			sideDrawer.Show ();
		}

		[Export ("RevealTransition")]
		private void RevealTransition()
		{
			TKSideDrawer sideDrawer = this.SideDrawerView.SideDrawers [0];

			// >> drawer-transition-cs
			sideDrawer.TransitionType = TKSideDrawerTransitionType.Reveal;
			// << drawer-transition-cs

			sideDrawer.Fill = new TKSolidFill (UIColor.Gray);
			sideDrawer.HeaderView = new SideDrawerHeader (false, null, null);
			sideDrawer.Show ();
		}

		[Export ("ReverseSlideOutTransition")]
		private void ReverseSlideOutTransition()
		{
			TKSideDrawer sideDrawer = this.SideDrawerView.SideDrawers [0];
			sideDrawer.TransitionType = TKSideDrawerTransitionType.ReverseSlideOut;
			sideDrawer.Fill = new TKSolidFill (UIColor.Gray);
			sideDrawer.HeaderView = new SideDrawerHeader (false, null, null);
			sideDrawer.Show ();
		}

		[Export ("SlideAlongTransition")]
		private void SlideAlongTransition()
		{
			TKSideDrawer sideDrawer = this.SideDrawerView.SideDrawers [0];
			sideDrawer.TransitionType = TKSideDrawerTransitionType.SlideAlong;
			sideDrawer.Fill = new TKSolidFill (UIColor.Gray);
			sideDrawer.HeaderView = new SideDrawerHeader (false, null, null);
			sideDrawer.Show ();
		}

		[Export ("SlideInOnTopTransition")]
		private void SlideInOnTopTransition()
		{
			TKSideDrawer sideDrawer = this.SideDrawerView.SideDrawers [0];
			sideDrawer.TransitionType = TKSideDrawerTransitionType.SlideInOnTop;
			sideDrawer.Fill = new TKSolidFill (UIColor.Clear);
			sideDrawer.HeaderView = new SideDrawerHeader (true, this, new Selector("DismissSideDrawer"));
			sideDrawer.Show ();
		}

		[Export ("ScaleUpTransition")]
		private void ScaleUpTransition()
		{
			TKSideDrawer sideDrawer = this.SideDrawerView.SideDrawers [0];
			sideDrawer.TransitionType = TKSideDrawerTransitionType.ScaleUp;
			sideDrawer.Fill = new TKSolidFill (UIColor.Gray);
			sideDrawer.HeaderView = new SideDrawerHeader (false, null, null);
			sideDrawer.Show ();
		}

		[Export ("FadeInTransition")]
		private void FadeInTransition()
		{
			TKSideDrawer sideDrawer = this.SideDrawerView.SideDrawers [0];
			sideDrawer.TransitionType = TKSideDrawerTransitionType.FadeIn;
			sideDrawer.Fill = new TKSolidFill (UIColor.Gray);
			sideDrawer.HeaderView = new SideDrawerHeader (true, this, new Selector("DismissSideDrawer"));
			sideDrawer.Show ();
		}

		[Export ("ScaleDownPusherTransition")]
		private void ScaleDownPusherTransition () 
		{
			TKSideDrawer sideDrawer = this.SideDrawerView.SideDrawers [0];
			sideDrawer.Fill = new TKSolidFill (UIColor.Gray);
			sideDrawer.TransitionType = TKSideDrawerTransitionType.ScaleDownPusher;
			sideDrawer.HeaderView = new SideDrawerHeader (false, this, new Selector ("DismissSideDrawer"));
			sideDrawer.Show ();
		}

		public void CreateButton(string title, NSObject target, Selector selector)
		{
			NSString titleString = new NSString (title);
			UIStringAttributes attributes = new UIStringAttributes () { Font = UIFont.SystemFontOfSize (18) };
			CGSize titleSize = titleString.GetSizeUsingAttributes(attributes);
			UIButton button = new UIButton (new CGRect (15, 15 + buttonY, titleSize.Width, 44));
			button.TitleLabel.Font = UIFont.SystemFontOfSize (14);
			button.Layer.BorderWidth = 1.0f;
			button.Layer.BorderColor = UIColor.White.CGColor;
			button.Layer.CornerRadius = 3.0f;
			button.SetTitle (title, UIControlState.Normal);
			button.SetTitleColor (UIColor.White, UIControlState.Normal);
			button.AddTarget (target, selector, UIControlEvent.TouchUpInside);
			scrollView.AddSubview (button);
			buttonY += 50;
			scrollView.ContentSize = new CGSize (Math.Max (button.Frame.Width, scrollView.ContentSize.Width), buttonY + 15 + this.View.Bounds.Y);
		}
	}
}

