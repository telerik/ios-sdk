using System;
using TelerikUI;
using Foundation;
using ObjCRuntime;
using UIKit;

namespace Examples
{	
	[Register("DataFormGettingStarted")]
	// >> dataform-ctrl-cs
	public class DataFormGettingStarted : TKDataFormViewController
	{
	// << dataform-ctrl-cs
		TKDataFormEntityDataSourceHelper dataSource;
		GettingStartedDataFormDelegate dataFormDelegate;
		PersonalInfo personalInfo;

		// >> dataform-ctrl-setup-cs
		public override void ViewDidLoad()
		{
			base.ViewDidLoad ();
		
			this.personalInfo = new PersonalInfo ();
			this.dataSource = new TKDataFormEntityDataSourceHelper (this.personalInfo);
			this.dataFormDelegate = new GettingStartedDataFormDelegate ();

			this.dataSource["Password"].HintText = "Ask every time";
			this.dataSource ["Password"].EditorClass = new Class (typeof(TKDataFormPasswordEditor));
			this.dataSource["InfoProtocol"].ValuesProvider = NSArray.FromStrings(new string[] { "L2TP", "PPTP", "IPSec" });
			this.dataSource["EncryptionLevel"].ValuesProvider = NSArray.FromStrings(new string[] { "FIPS Compliant", "High", "Client Compatible", "Low" });

			this.dataSource.AddGroup(" ", new string[] { "InfoProtocol" });
			this.dataSource.AddGroup (" ", new string[] {
				"Details",
				"Server",
				"Account",
				"Secure",
				"Password",
				"EncryptionLevel",
				"SendAllTraffic"
			});
				
			this.DataForm.BackgroundColor = new UIColor (0.937f, 0.937f, 0.960f, 1.0f);
			this.DataForm.GroupSpacing = 20;
			this.DataForm.Delegate = this.dataFormDelegate;
			this.DataForm.WeakDataSource = this.dataSource.NativeObject;
		}
		// << dataform-ctrl-setup-cs
	}

	class GettingStartedDataFormDelegate : TKDataFormDelegate
	{
		// >> dataform-delegate-cs
		public override void UpdateEditor (TKDataForm dataForm, TKDataFormEditor editor, TKEntityProperty property)
		{
			TKGridLayoutCellDefinition feedbackDef = editor.GridLayout.DefinitionForView (editor.FeedbackLabel);
			editor.GridLayout.SetHeight (0, feedbackDef.Row.Int32Value);

			if (property.Name == "InfoProtocol") {
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				TKGridLayoutCellDefinition textLabelDef = editor.GridLayout.DefinitionForView (editor.TextLabel);
				editor.GridLayout.SetWidth (0, textLabelDef.Column.Int32Value);
			}

			if (editor.IsKindOfClass (new Class(typeof(TKDataFormTextFieldEditor))) && !(property.Name.Equals("Password"))) {
				property.HintText = "Required";
			}
		}
		// << dataform-delegate-cs
	// >> dataform-ctrl-cs
	}
	// << dataform-ctrl-cs
}


