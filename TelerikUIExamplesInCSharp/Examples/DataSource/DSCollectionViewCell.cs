using System;

using Foundation;
using UIKit;
using CoreGraphics;


namespace Examples
{
	public class DSCollectionViewCell: UICollectionViewCell
	{
		public UILabel Label { get; set; }

		public UIImageView ImageView { get; set; }

		public DSCollectionViewCell(IntPtr handle): base(handle) 
		{
			float size = (float)Math.Min (this.Frame.Size.Width - 60f, this.Frame.Size.Height - 40f); 
			this.ImageView = new UIImageView (new CGRect ((this.Frame.Size.Width - size) / 2.0f, 0, size, size));
			this.ImageView.Layer.CornerRadius = size / 2.0f;
			this.ImageView.Layer.MasksToBounds = true;
			this.Add (this.ImageView);

			this.Label = new UILabel (new CGRect (0, this.Bounds.Size.Height - 30, this.Bounds.Size.Width, 30));
			this.Label.Font = UIFont.SystemFontOfSize (20);
			this.Label.TextAlignment = UITextAlignment.Center;
			this.Add (this.Label);
		}
	}
}

