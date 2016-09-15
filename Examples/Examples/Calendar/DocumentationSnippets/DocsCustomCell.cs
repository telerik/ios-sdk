using System;
using System.Drawing;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;

namespace Examples
{
// >> customization-customcell-cs	
	public class DocsCustomCell : TKCalendarDayCell
	{
		public DocsCustomCell ()
		{
		}

		public override void UpdateVisuals ()
		{
			base.UpdateVisuals ();

			if ((this.State & TKCalendarDayState.Today) != 0) {
				this.Label.TextColor = UIColor.Green;
			} else {
				this.Label.TextColor = UIColor.Blue;
			}
		}
	}
// << customization-customcell-cs
}

