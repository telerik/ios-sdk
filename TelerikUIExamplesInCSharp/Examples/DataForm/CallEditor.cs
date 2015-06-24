using System;
using UIKit;
using TelerikUI;
using Foundation;
using CoreGraphics;

namespace Examples
{
	public class CallEditor : TKDataFormEditor
	{
		public UIButton ActionButton{ get; set;}
		UITextField textField;

		public CallEditor ()
		{
			this.ActionButton = new UIButton ();
			this.ActionButton.SetTitle ("Call", UIControlState.Normal);
			this.ActionButton.SetTitleColor (new UIColor (0.780f, 0.2f, 0.233f, 1.0f), UIControlState.Normal);
			this.AddSubview (this.ActionButton);
			this.textField = new UITextField ();
			this.textField.KeyboardType = UIKeyboardType.PhonePad;
			this.AddSubview (this.textField);
		}

		public override TKDataFormEntityProperty Property {
			get {
				return base.Property;
			}
			set {
				base.Property = value;
				this.textField.Placeholder = this.Property.DisplayName.Trim();
			}
		}

		public override UIView Editor {
			get {
				return this.textField;
			}
		}

		public override void LayoutSubviews ()
		{
			base.LayoutSubviews ();
			this.TextLabel.Frame = CGRect.Empty;

			var bounds = new CGRect (this.Bounds.X, this.Bounds.Y ,
				             this.Bounds.Size.Width,
				this.Bounds.Size.Height);

			var buttonSize = ((NSString)this.ActionButton.TitleLabel.Text).GetSizeUsingAttributes(new UIStringAttributes(new NSDictionary(UIStringAttributeKey.Font, this.ActionButton.TitleLabel.Font,
				UIStringAttributeKey.BackgroundColor, this.ActionButton.TitleLabel.TextColor)));

			this.ActionButton.Frame = new CGRect (Bounds.X - 10 + Bounds.Size.Width + this.Style.EditorOffset.Horizontal - buttonSize.Width,
				(double)Bounds.GetMidY() - buttonSize.Height / 2.0 + this.Style.EditorOffset.Vertical, buttonSize.Width, buttonSize.Height);

			this.textField.Frame = new CGRect (Bounds.X + 15 + this.Style.TextLabelOffset.Horizontal,  Bounds.GetMidY() - bounds.Size.Height / 2.0,
				ActionButton.Frame.X - (Bounds.X + this.Style.TextLabelOffset.Horizontal), Bounds.Size.Height);

			if(this.Style.TextLabelDisplayMode == TKDataFormEditorTextLabelDisplayMode.Hidden){
					textField.Frame = CGRect.Empty;
				ActionButton.Frame = new CGRect(this.Bounds.X + this.Style.EditorOffset.Horizontal,
					bounds.GetMidY() - buttonSize.Height / 2.0 + this.Style.EditorOffset.Vertical, buttonSize.Width, buttonSize.Height);
		}
		}


	}
}

