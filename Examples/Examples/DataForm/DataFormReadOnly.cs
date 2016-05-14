using System;
using TelerikUI;
using Foundation;
using UIKit;
using ObjCRuntime;
using System.Collections.Generic;

namespace Examples
{
	[Register("DataFormReadOnly")]	
	public class DataFormReadOnly : XamarinExampleViewController
	{
		TKDataFormEntityDataSourceHelper dataSource;
		ReadOnlyDataFormDelegate dataFormDelegate;
		CardInfo cardInfo;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.cardInfo = new CardInfo ();
			this.dataSource = new TKDataFormEntityDataSourceHelper (this.cardInfo);
			this.dataFormDelegate = new ReadOnlyDataFormDelegate (this);

			dataSource["Edit"].DisplayName = "Allow Edit";
			dataSource["FirstName"].HintText = "First Name (Must match card)";
			dataSource["LastName"].HintText = "Last Name (Must match card)";
			dataSource["CardNumber"].HintText = "Card number";

			dataSource.AddGroup (" ", new string[] { "Edit" });
			dataSource.AddGroup (" ", new string[] { "FirstName", "LastName", "CardNumber", "ZipCode", "ExpirationDate" });

			foreach (var property in dataSource.Properties) {
				property.ReadOnly = property.Name != "Edit";
			}

			TKDataForm form = new TKDataForm(this.View.Bounds);
			form.BackgroundColor = new UIColor (0.937f, 0.937f, 0.960f, 1.0f);
			form.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			form.Delegate = this.dataFormDelegate;
			form.WeakDataSource = this.dataSource.NativeObject;
			form.GroupSpacing = 20;
			this.View.AddSubview(form);
		}

		class ReadOnlyDataFormDelegate : TKDataFormDelegate
		{
		
			private DataFormReadOnly owner;

			public ReadOnlyDataFormDelegate(DataFormReadOnly owner){
				this.owner = owner;
			}

			public override void UpdateEditor (TKDataForm dataForm, TKDataFormEditor editor, TKEntityProperty property)
			{
				List<string> properties = new List<string> () { "FirstName", "LastName", "CardNumber" };
				if (properties.Contains(property.Name)) {
					editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
					TKGridLayoutCellDefinition titleDef = editor.GridLayout.DefinitionForView (editor.TextLabel);
					editor.GridLayout.SetWidth (0, titleDef.Column.Int32Value);
				}
			}

			public override void DidEditProperty (TKDataForm dataForm, TKEntityProperty property)
			{
				if (property.Name == "Edit") {
					bool isReadOnly = !((NSNumber)property.ValueCandidate).BoolValue;
					foreach (TKEntityProperty prop in this.owner.dataSource.Properties) {
						if (prop.Name != "Edit") {
							prop.ReadOnly = isReadOnly;
						}
					}
					dataForm.Update();
				}
			}
		}
	}
}

