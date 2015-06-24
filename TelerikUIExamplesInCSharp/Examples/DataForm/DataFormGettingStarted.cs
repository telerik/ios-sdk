using System;
using TelerikUI;
using Foundation;
using ObjCRuntime;
using UIKit;

namespace Examples
{
	public class DataFormGettingStarted : TKDataFormViewController
	{
		TKDataFormEntityDataSource dataSource;

		public override void ViewDidLoad()
		{
			base.ViewDidLoad ();

			this.dataSource = new TKDataFormEntityDataSource ();
			this.dataSource.SelectedObject = new PersonalInfo ();
			this.dataSource.AllowPropertySorting = true;

			dataSource.EntityModel.PropertyWithName("InfoProtocol").GroupKey = " ";

			dataSource.EntityModel.PropertyWithName ("Server").PropertyIndex = 0;
			dataSource.EntityModel.PropertyWithName ("Details").PropertyIndex = 2;
			dataSource.EntityModel.PropertyWithName ("Account").PropertyIndex = 3;
			dataSource.EntityModel.PropertyWithName ("Secure").PropertyIndex = 4;
			dataSource.EntityModel.PropertyWithName ("Password").PropertyIndex = 5;
			dataSource.EntityModel.PropertyWithName ("EncryptionLevel").PropertyIndex = 6;
			dataSource.EntityModel.PropertyWithName ("SendAllTraffic").PropertyIndex = 7;

			GettingStartedDataFormDelegate currentDelegate = new GettingStartedDataFormDelegate ();
			this.DataForm.Delegate = currentDelegate;
			this.DataForm.DataSource = this.dataSource;
			this.DataForm.RegisterEditor(new Class(typeof (TKDataFormSegmentedEditor)), this.dataSource.EntityModel.PropertyWithName("InfoProtocol"));
			this.DataForm.RegisterEditor (new Class (typeof(TKDataFormOptionsEditor)), this.dataSource.EntityModel.PropertyWithName("EncryptionLevel"));
		}
	}

	public class GettingStartedDataFormDelegate : TKDataFormDelegate
	{
		public override void UpdateEditor (TKDataForm dataForm, TKDataFormEditor editor, TKDataFormEntityProperty property)
		{
			if (property.Name == "InfoProtocol") {
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				((TKDataFormSegmentedEditor)editor).Segments = new NSObject[] { (NSString)"L2TP", (NSString)"PPTP", (NSString)"IPSec" };
				editor.Style.SeparatorLeadingSpace = 0;
			}

			if (property.Name == "EncryptionLevel") {
				((TKDataFormOptionsEditor)editor).Options = new NSObject[] {
					(NSString)"FIPS Compilant",
					(NSString)"High",
					(NSString)"Client Compatable",
					(NSString)"Low"
				};
			}

			if (editor.IsKindOfClass (new Class(typeof(TKDataFormTextFieldEditor)))) {
				((UITextField)editor.Editor).Placeholder = "Required";
			}

			if (property.Name == "Password") {
				((UITextField) editor.Editor).Placeholder = "Ask every time";
				((UITextField)editor.Editor).SecureTextEntry = true;
			}

			if (property.Name == "SendAllTraffic") {
				editor.Style.SeparatorLeadingSpace = 0;
			}
		}
	}
}

