using System;
using System.Drawing;

using Foundation;
using UIKit;
using CoreGraphics;

using TelerikUI;


namespace Examples
{
	public class CustomCell : TKCalendarDayCell
	{
		static UIImage gDayImage;
		static UIImage gSelectedDayImage;
		static UIImage gCurrentDayImage;

		public UIImage CurrentImage {
			get;
			set;
		}

		public CustomCell (RectangleF frame) : base(frame)
		{
		}

		public CustomCell ()
		{
			this.Initialize ();
		}

		public void Initialize ()
		{
			gDayImage = UIImage.FromBundle ("calendar_cell.png");
			gDayImage = gDayImage.CreateResizableImage (new UIEdgeInsets (4, 4, 4, 4), UIImageResizingMode.Stretch);

			gCurrentDayImage = UIImage.FromBundle ("calendar_current_cell.png");
			gCurrentDayImage = gCurrentDayImage.CreateResizableImage (new UIEdgeInsets (4, 4, 4, 4), UIImageResizingMode.Stretch);

			gSelectedDayImage = UIImage.FromBundle ("calendar_selected_cell.png");
			gSelectedDayImage = gSelectedDayImage.CreateResizableImage (new UIEdgeInsets (4, 4, 4, 4), UIImageResizingMode.Stretch);
		}

		public override void UpdateVisuals ()
		{
			base.UpdateVisuals ();
			this.Style.BackgroundColor = UIColor.Clear;
			this.Style.Shape = null;
			this.Style.TopBorderColor = null;
			this.Style.BottomBorderColor = null;

			if ((this.State & TKCalendarDayState.Selected) != 0) {
				this.CurrentImage = gSelectedDayImage;
			} else if ((this.State & TKCalendarDayState.Today) != 0) {
				this.CurrentImage = gCurrentDayImage;
				this.Label.TextColor = UIColor.White;
			} else {
				this.CurrentImage = gDayImage;
			}
		}

		public override void Draw (CGRect rect)
		{
			this.CurrentImage.Draw (rect);
			base.Draw (rect);
		}
	}
}

