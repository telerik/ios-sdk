using System;
using UIKit;
using TelerikUI;

namespace Examples
{
	/*This file has purpose only for the documentation snippets, it is not an actual example!
 It is commented because the build of the project won't pass.*/
	
	public class SideDrawerDocsSetup : UIViewController
	{
		public SideDrawerDocsSetup ()
		{
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

        /*This piece of code is supposed to be placed in the didFinishLaunchingWithOptions method in AppDelegate 
          in order to have a global sideDrawer for every screen in your application */

			/*
			// >> sidedrawer-appdelegate-cs
			[Register ("AppDelegate")]
			public partial class AppDelegate : UIApplicationDelegate
			{
				// class-level declarations

				public override UIWindow Window {
					get;
					set;
				}

				public override bool FinishedLaunching (UIApplication application, NSDictionary launchOptions)
				{
					SideDrawerGettingStarted main = new SideDrawerGettingStarted ();
					TKSideDrawerController sideDrawerController = new TKSideDrawerController (main);
					this.Window.RootViewController = sideDrawerController;

					return true;
				}

				//..
			}
			// << sidedrawer-appdelegate-cs

			// >> sidedrawer-appdelegate-ctrl-cs
			public class SideDrawerGettingStarted : UIViewController
			{
				TKSideDrawer SideDrawer;

				public override void ViewDidLoad ()
				{
					base.ViewDidLoad ();

					this.View.BackgroundColor = UIColor.Gray;

					UINavigationBar navBar = new UINavigationBar (new CGRect (0, 0, this.View.Frame.Size.Width, 64));
					UINavigationItem navItem = new UINavigationItem ("Getting Started");
					UIBarButtonItem showSideDrawerButton = new UIBarButtonItem ("Show", UIBarButtonItemStyle.Plain, this, new Selector ("ShowSideDrawer"));
					navItem.LeftBarButtonItem = showSideDrawerButton;
					navBar.Items = new UINavigationItem[]{ navItem };
					this.View.AddSubview (navBar);

					this.SideDrawer = TKSideDrawer.FindSideDrawer (0, this);
					TKSideDrawerSection sectionPrimary = this.SideDrawer.AddSection ("Primary");
					sectionPrimary.AddItem ("Social");
					sectionPrimary.AddItem ("Promotions");

					TKSideDrawerSection sectionLabels = this.SideDrawer.AddSection ("Labels");
					sectionLabels.AddItem ("Important");
					sectionLabels.AddItem ("Starred");
					sectionLabels.AddItem ("Sent Mail");
					sectionLabels.AddItem ("Drafts");
				}

				[Export ("ShowSideDrawer")]
				public void ShowSideDrawer ()
				{
					this.SideDrawer.Show ();
				}
			}
			// << sidedrawer-appdelegate-ctrl-cs
			*/
		}
	}
}

