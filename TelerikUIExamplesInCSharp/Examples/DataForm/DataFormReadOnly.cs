using System;
using TelerikUI;
using Foundation;
using UIKit;
using ObjCRuntime;

namespace Examples
{
	public class DataFormReadOnly : ExampleViewController
	{
		private TKDataFormEntityDataSource dataSource;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			dataSource = new TKDataFormEntityDataSource();
			dataSource.AllowPropertySorting = true;

			this.dataSource.SelectedObject = new CardInfo ();

			TKDataFormEntityProperty property = this.dataSource.EntityModel.PropertyWithName ("Edit");
			property.GroupKey = " ";
			property.DisplayName = "Allow Edit";

			dataSource.EntityModel.PropertyWithName ("FirstName").PropertyIndex = 0;
			dataSource.EntityModel.PropertyWithName ("LastName").PropertyIndex = 1;
			dataSource.EntityModel.PropertyWithName ("CardNumber").PropertyIndex = 2;
			dataSource.EntityModel.PropertyWithName ("ZipCode").PropertyIndex = 3;
			dataSource.EntityModel.PropertyWithName ("ExpirationDate").PropertyIndex = 4;

			foreach (TKDataFormEntityProperty p in this.dataSource.EntityModel.Properties) {
				p.Readonly = p.Name != "Edit";
			}
				
			ReadOnlyDataFormDelegate currentDelegate = new ReadOnlyDataFormDelegate (this.dataSource);

			TKDataForm form = new TKDataForm(this.View.Bounds);
			form.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			form.Delegate = currentDelegate;
			form.DataSource = this.dataSource;
			form.RegisterEditor(new Class(typeof (TKDataFormDatePickerEditor)), this.dataSource.EntityModel.PropertyWithName("ExpirationDate"));
			this.View.AddSubview(form);

		}
	}

	public class ReadOnlyDataFormDelegate : TKDataFormDelegate{
	
		private TKDataFormEntityDataSource dataSource;

		public ReadOnlyDataFormDelegate(TKDataFormEntityDataSource dataSource){
			this.dataSource = dataSource;
		}

		public override void UpdateEditor (TKDataForm dataForm, TKDataFormEditor editor, TKDataFormEntityProperty property)
		{
			if (property.Name == "FirstName") {
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				((UITextField) editor.Editor).Placeholder = "First Name (Must match card)";
			}

			else if (property.Name == "LastName") {
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				((UITextField) editor.Editor).Placeholder = "Last Name (Must match card)";
			}

			else if (property.Name == "CardNumber") {
				UITextField textField = (UITextField)editor.Editor;
				textField.KeyboardType = UIKeyboardType.NumberPad;
				textField.Placeholder = "Card Number";
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
			}
		}

		public override void DidEditProperty (TKDataForm dataForm, TKDataFormEntityProperty property)
		{
			if (property.Name == "Edit") {
				bool isReadOnly = !((NSNumber)property.Value).BoolValue;
				foreach (TKDataFormEntityProperty prop in this.dataSource.EntityModel.Properties) {
					if (prop.Name != "Edit") {
						prop.Readonly = isReadOnly;
					}
				}
				dataForm.UpdateEditors();
			}
		}
	}
}

