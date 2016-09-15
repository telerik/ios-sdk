using System;
using TelerikUI;
using Foundation;
using ObjCRuntime;
using UIKit;

namespace Examples
{
	[Register("DataFormCollapsibleGroups")]
	public class DataFormCollapsibleGroups : UIViewController
	{
		TKDataForm dataForm;
		TKDataFormEntityDataSourceHelper dataSource;
		CollapsableGroupsDataFormDelegate dataFormDelegate;
		EmployeeInfo info;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.dataFormDelegate = new CollapsableGroupsDataFormDelegate ();

			// >> dataform-obj-cs
			this.dataForm = new TKDataForm (this.View.Bounds);
			this.dataForm.Delegate = this.dataFormDelegate;
			this.View.AddSubview (this.dataForm);
			// << dataform-obj-cs

			this.dataForm.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.dataForm.BackgroundColor = new UIColor(0.937f, 0.937f, 0.960f, 1.0f);

			// >> dataform-obj-cs
			this.info = new EmployeeInfo ();
			this.dataSource = new TKDataFormEntityDataSourceHelper (this.info);
			this.dataSource.AddGroup("Personal Info", new string[] {
				"GivenNames",
				"Surname",
				"Gender",
				"IdNumber",
				"DateOfBirth"
			});
			this.dataSource.AddGroup ("Contact Info", new string[] { "EmployeeId", "PhoneNumber" });

			this.dataSource ["Gender"].EditorClass = new Class ("TKDataFormSegmentedEditor");
			this.dataSource ["Gender"].ValuesProvider = NSArray.FromStrings (new string[] { "Male", "Female" });

			this.dataSource ["IdNumber"].EditorClass = new Class ("TKDataFormNumberEditor");
			this.dataSource ["EmployeeId"].EditorClass = new Class ("TKDataFormNumberEditor");
			this.dataForm.WeakDataSource = this.dataSource.NativeObject;
			// << dataform-obj-cs
		}
	}

	class CollapsableGroupsDataFormDelegate : TKDataFormDelegate
	{
		// >> dataform-collapse-cs
		public override void UpdateGroupView (TKDataForm dataForm, TKEntityPropertyGroupView groupView, uint groupIndex)
		{
			groupView.Collapsible = true;
			groupView.TitleView.Style.SeparatorColor = new TKSolidFill (new UIColor (0.784f, 0.780f, 0.8f, 1.0f));
		}
		// << dataform-collapse-cs

		public override nfloat HeightForHeader (TKDataForm dataForm, uint groupIndex)
		{
			return 44.0f;
		}
	}
}

