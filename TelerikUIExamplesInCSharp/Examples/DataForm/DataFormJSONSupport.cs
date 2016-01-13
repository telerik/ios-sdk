
using System;
using TelerikUI;
using Foundation;
using UIKit;
using ObjCRuntime;

namespace Examples
{
	[Register("DataFormJSONSupport")]	
	public partial class DataFormJSONSupport : XamarinExampleViewController
	{
		DataFormDelegate dataFormDelegate;
		TKAlert alert;
		public TKDataForm DataForm {
			get;
			set;
		}

		public TKDataFormEntityDataSourceHelper DataSource {
			get;
			set;
		}

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();
			AddOption ("Save", CommitDataForm);
			
			// Perform any additional setup after loading the view, typically from a nib.
			this.DataForm = new TKDataForm (this.View.Bounds);
			this.DataForm.AutoresizingMask = UIViewAutoresizing.FlexibleHeight | UIViewAutoresizing.FlexibleWidth;
			this.DataForm.AllowScroll = false;
			dataFormDelegate = new DataFormDelegate ();
			this.DataForm.Delegate = dataFormDelegate;
			this.View.AddSubview (this.DataForm);

			this.DataSource =new TKDataFormEntityDataSourceHelper ("user", "json", (string)null);
			this.DataSource ["name"].Index = 0;
			this.DataSource ["age"].Index = 1;

			this.DataSource ["gender"].ValuesProvider = NSArray.FromStrings (new string[] { "Male", "Female" });
			this.DataSource ["gender"].EditorClass = new Class (typeof(TKDataFormSegmentedEditor));
			this.DataSource ["gender"].Index = 2;
			this.DataSource ["gender"].PickersUseIndexValue = false;

			this.DataSource ["email"].Index = 3;
			this.DataSource ["email"].EditorClass = new Class (typeof(TKDataFormEmailEditor));

			this.DataForm.WeakDataSource = this.DataSource.NativeObject;
			this.DataForm.CommitMode = TKDataFormCommitMode.Manual;

			UIBarButtonItem save = new UIBarButtonItem ("Save", UIBarButtonItemStyle.Done, this, new Selector ("CommitDataForm"));
			this.NavigationItem.RightBarButtonItem = save;
		}

		[Export ("CommitDataForm")]
		void CommitDataForm ()
		{
			this.DataForm.Commit ();
			this.alert = new TKAlert ();
			this.alert.Title = "Saved";
			this.alert.Message = this.DataSource.WriteJSONToString ();
			this.alert.AddActionWithTitle("OK",  (TKAlert al, TKAlertAction action) => {
				return true;
			});
			this.alert.Show (true);

		}
	}
		
	class DataFormDelegate : TKDataFormDelegate
	{
		public override void UpdateEditor (TKDataForm dataForm, TKDataFormEditor editor, TKEntityProperty property)
		{
			if (property.Name == "age") {
				TKGridLayoutCellDefinition labelDef = editor.GridLayout.DefinitionForView (((TKDataFormStepperEditor)editor).ValueLabel);
				labelDef.ContentOffset = new UIOffset (-25, 0);
			}
		}
	}
}

