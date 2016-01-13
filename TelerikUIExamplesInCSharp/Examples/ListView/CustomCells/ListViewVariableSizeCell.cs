using System;

using TelerikUI;
using UIKit;
using CoreGraphics;
using Foundation;

namespace Examples
{
	public class ListViewVariableSizeCell: TKListViewCell
	{
		public UILabel label;

		public ListViewVariableSizeCell(IntPtr handle)
			: base(handle)
		{
			this.label = new UILabel (CGRect.Empty);
			this.label.TranslatesAutoresizingMaskIntoConstraints = false;
			this.label.Lines = 0;
			this.AddSubview (this.label);

			var views = new NSMutableDictionary ();
			views.Add (new NSString("v"), this.label);

			this.AddConstraints (NSLayoutConstraint.FromVisualFormat ("V:|-10-[v]-10-|", 0, null, views));
			this.AddConstraints (NSLayoutConstraint.FromVisualFormat ("V:|-10-[v]-10-|", 0, null, views));
		}
			
		public override void LayoutSubviews ()
		{
			label.PreferredMaxLayoutWidth = this.Bounds.Size.Width - 20;
			base.LayoutSubviews ();
		}
	}
}

