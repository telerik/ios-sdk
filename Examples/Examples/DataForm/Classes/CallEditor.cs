using System;
using UIKit;
using TelerikUI;
using Foundation;
using CoreGraphics;

namespace Examples
{
	public class CallEditor : TKDataFormTextFieldEditor
	{
		public UIButton ActionButton{ get; set;}

		public CallEditor ()
		{
			this.ActionButton = new UIButton ();
			this.ActionButton.SetTitle ("Call", UIControlState.Normal);
			this.ActionButton.SetTitleColor (new UIColor (0.780f, 0.2f, 0.233f, 1.0f), UIControlState.Normal);
			this.AddSubview (this.ActionButton);
			this.GridLayout.AddArrangedView (this.ActionButton);
			TKGridLayoutCellDefinition btnDef = this.GridLayout.DefinitionForView (this.ActionButton);
			btnDef.Row = new NSNumber (0);
			btnDef.Column = new NSNumber (3);
			this.GridLayout.SetWidth (this.ActionButton.SizeThatFits (new CGSize ()).Width, 3);
		}
	}
}

