using System;
using TelerikUI;
using Foundation;
using UIKit;

namespace Examples
{
	public class DataFormValidation : TKDataFormViewController
	{
		TKDataFormEntityDataSource dataSource;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.dataSource = new TKDataFormEntityDataSource ();
			this.dataSource.SelectedObject = new RegistrationInfo ();
			this.dataSource.AllowPropertySorting = true;


			TKDataFormEntityProperty emailProperty = this.dataSource.EntityModel.PropertyWithName("Email");
			emailProperty.Validators = new NSObject[] { new EmailValidator() };
			emailProperty.GroupKey = "Account";
			emailProperty.Validators = new NSObject[] { new EmailValidator () };
			emailProperty.PropertyIndex = 0;

			TKDataFormEntityProperty password = this.dataSource.EntityModel.PropertyWithName("Password");
			password.Validators = new NSObject[] { new PasswordValidator() };
			password.GroupKey = "Account";
			password.Validators = new NSObject[] { new PasswordValidator () };
			password.PropertyIndex = 1;

			dataSource.EntityModel.PropertyWithName("RepeatPassword").GroupKey = "Account";
			dataSource.EntityModel.PropertyWithName("RepeatPassword").PropertyIndex = 2;

			dataSource.EntityModel.PropertyWithName("RememberMe").GroupKey = "Account";
			dataSource.EntityModel.PropertyWithName("RememberMe").PropertyIndex = 3;

			dataSource.EntityModel.PropertyWithName("Name").GroupKey = "Details";
			dataSource.EntityModel.PropertyWithName("Name").PropertyIndex = 0;

			dataSource.EntityModel.PropertyWithName("DateOfBirth").GroupKey = "Details";
			dataSource.EntityModel.PropertyWithName("DateOfBirth").PropertyIndex = 1;

			dataSource.EntityModel.PropertyWithName("Gender").GroupKey = "Details";
			dataSource.EntityModel.PropertyWithName("Gender").PropertyIndex = 2;

			dataSource.EntityModel.PropertyWithName("Country").GroupKey = "Details";
			dataSource.EntityModel.PropertyWithName("Country").PropertyIndex = 3;

			ValidationDataFormDelegate validationDelegate = new ValidationDataFormDelegate (this.dataSource);
			this.DataForm.Delegate = validationDelegate;
			this.DataForm.DataSource = dataSource;

			this.DataForm.RegisterEditor (new ObjCRuntime.Class (typeof(TKDataFormOptionsEditor)), this.dataSource.EntityModel.PropertyWithName ("Gender"));
			this.DataForm.RegisterEditor (new ObjCRuntime.Class (typeof(TKDataFormOptionsEditor)), this.dataSource.EntityModel.PropertyWithName ("Country"));
			this.DataForm.RegisterEditor (new ObjCRuntime.Class (typeof(TKDataFormDatePickerEditor)), this.dataSource.EntityModel.PropertyWithName ("DateOfBirth"));
		}
	}

	public class ValidationDataFormDelegate: TKDataFormDelegate{
	
		TKDataFormEntityDataSource dataSource;

		public ValidationDataFormDelegate(TKDataFormEntityDataSource dataSource) {
		
			this.dataSource = dataSource;
		}

		public override void DidValidateProperty (TKDataForm dataForm, TKDataFormEntityProperty propery, TKDataFormEditor editor)
		{
			if (propery.Name == "RepeatPassword") {
				if (propery.IsValid) {
					propery.FeedbackMessage = null;
				} else {
					propery.FeedbackMessage = "Incorrect password!";
				}
			}
		}

		public override bool ValidateProperty (TKDataForm dataForm, TKDataFormEntityProperty propery, TKDataFormEditor editor)
		{
			if (propery.Name == "RepeatPassword") {
				var repeatedPassword = propery.Value;
				var passwordProperty = this.dataSource.EntityModel.PropertyWithName ("Password");
				var password = passwordProperty.Value;
				if (repeatedPassword == password) {
					return false;
				}
				return true;
			}
			return propery.IsValid;
		}

		public override void UpdateEditor (TKDataForm dataForm, TKDataFormEditor editor, TKDataFormEntityProperty property)
		{
			if (property.Name == "Gender") 
			{
				((TKDataFormOptionsEditor)editor).Options = new NSString[] { (NSString)"Male", (NSString)"Female" };
			} 
			else if (property.Name == "Email") 
			{
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				UITextField textField = (UITextField)editor.Editor;
				textField.KeyboardType = UIKeyboardType.EmailAddress;
				textField.Placeholder = "E-mail(Required)";
			} 
			else if (property.Name == "Password") 
			{
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				UITextField textField = (UITextField)editor.Editor;
				textField.Placeholder = "Password (Minimum 6 characters)";
				textField.SecureTextEntry = true;
			} 
			else if (property.Name == "RepeatPassword") 
			{
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				UITextField textField = (UITextField)editor.Editor;
				textField.Placeholder = "Confirm Password";
				textField.SecureTextEntry = true;
			} 
			else if (property.Name == "Name") 
			{
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				UITextField textField = (UITextField)editor.Editor;
				textField.KeyboardType = UIKeyboardType.EmailAddress;
				textField.Placeholder = "Name(Optional)";
			} 
			else if (property.Name == "Country") {
				((TKDataFormOptionsEditor)editor).Options = new NSString[] {
					(NSString)"Bulgaria",
					(NSString)"United Kingdom",
					(NSString)"Germany",
					(NSString)"France",
					(NSString)"Italy",
					(NSString)"Belgium",
					(NSString)"Norway",
					(NSString)"Sweden",
					(NSString)"Russia",
					(NSString)"Turkey"
				};
				editor.Style.SeparatorLeadingSpace = 0;
			} 
			else if (property.Name == "RememberMe") 
			{
				editor.Style.SeparatorLeadingSpace = 0;
			}

			if (!property.IsValid) {
				editor.Style.Fill = new TKSolidFill (new UIColor (1f, 0f, 0f, 0.3f));
			} else {
				editor.Style.Fill = new TKSolidFill (UIColor.Clear);
			}
		}
	}
}

