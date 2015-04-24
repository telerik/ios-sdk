using System;
using TelerikUI;
using Foundation;
using UIKit;
using CoreAnimation;
using CoreGraphics;

namespace Examples
{
	public class MyTransition : TKSideDrawerTransition
	{
		private CGPoint sideDrawerIdentityCenter;
		private CGPoint hostviewIdentityCenter;

		public MyTransition(TKSideDrawer sideDrawer) : base(sideDrawer)
		{
		}

		public override void Show ()
		{
			if (!this.SideDrawer.IsVisible) {
				this.SideDrawer.Frame = new CGRect (0, -this.SideDrawer.Superview.Bounds.Size.Height, this.SideDrawer.Width, this.SideDrawer.Superview.Bounds.Size.Height);
				sideDrawerIdentityCenter = this.SideDrawer.Center;
				hostviewIdentityCenter = this.SideDrawer.Hostview.Center;
			}

			this.TransitionBegan (true);
			UIView.Animate (this.SideDrawer.TransitionDuration, delegate {
				this.SideDrawer.Center = new CGPoint(sideDrawerIdentityCenter.X, sideDrawerIdentityCenter.Y + this.SideDrawer.Bounds.Size.Height);
				this.SideDrawer.Hostview.Center = new CGPoint(hostviewIdentityCenter.X + this.SideDrawer.Width, hostviewIdentityCenter.Y);
			}, delegate {
				this.TransitionEnded(true);
			});
		}

		public override void Dismiss ()
		{
			this.TransitionBegan (false);
			UIView.Animate (this.SideDrawer.TransitionDuration, delegate {
				this.SideDrawer.Center = sideDrawerIdentityCenter;
				this.SideDrawer.Hostview.Center = hostviewIdentityCenter;
			}, delegate {
				this.TransitionEnded(false);
			});
		}

		public override void TransitionBegan (bool showing)
		{
			if (showing) {
				this.SideDrawer.Hidden = false;
				this.SideDrawer.Superview.BringSubviewToFront (this.SideDrawer.Hostview);
				this.SideDrawer.Hostview.UserInteractionEnabled = false;
			}
		}

		public override void TransitionEnded (bool showing)
		{
			if (!showing) {
				this.SideDrawer.Hidden = true;
				this.SideDrawer.Hostview.UserInteractionEnabled = true;
			}
		}
	}
}

