using System;
using TelerikUI;
using UIKit;
using Foundation;

namespace Examples
{
	public class DataFormCustomization : TKDataFormViewController
	{
		TKDataFormEntityDataSource dataSource;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.dataSource = new TKDataFormEntityDataSource ();
			this.dataSource.AllowPropertySorting = true;
			this.dataSource.SelectedObject = new ReservationForm ();
			this.dataSource.EntityModel.PropertyWithName ("Name").Image = new UIImage ("guest-name.png");
			this.dataSource.EntityModel.PropertyWithName ("Phone").Image = new UIImage ("phone.png");
			this.dataSource.EntityModel.PropertyWithName ("Date").Image = new UIImage ("calendar.png");
			this.dataSource.EntityModel.PropertyWithName ("Time").Image = new UIImage ("time.png");
			this.dataSource.EntityModel.PropertyWithName ("Guests").Image = new UIImage ("guest-number.png");
			this.dataSource.EntityModel.PropertyWithName ("Table").Image = new UIImage ("table-number.png");

			dataSource.EntityModel.PropertyWithName ("Name").PropertyIndex = 0;
			dataSource.EntityModel.PropertyWithName ("Phone").PropertyIndex = 1;
			dataSource.EntityModel.PropertyWithName ("Date").PropertyIndex = 2;
			dataSource.EntityModel.PropertyWithName ("Time").PropertyIndex = 3;
			dataSource.EntityModel.PropertyWithName ("Guests").PropertyIndex = 4;
			dataSource.EntityModel.PropertyWithName ("Section").PropertyIndex = 5;
			dataSource.EntityModel.PropertyWithName ("Origin").PropertyIndex = 6;
			dataSource.EntityModel.PropertyWithName ("CancelReservation").PropertyIndex = 7;

			foreach (TKDataFormEntityProperty property in this.dataSource.EntityModel.Properties) {
				if (property.Name == "Section" || property.Name == "Table") {
					property.GroupKey = @"TABLE DETAILS";
				}
				else if (property.Name == "Origin" || property.Name == "CancelReservation") {
					property.GroupKey = @"ORIGIN";
				}
				else {
					property.GroupKey = @"RESERVATION DETAILS";
				}
			}
				
			this.DataForm.BackgroundColor = UIColor.FromPatternImage (new UIImage ("wood-pattern.png"));
			this.DataForm.RegisterEditor (new ObjCRuntime.Class (typeof(CallEditor)), this.dataSource.EntityModel.PropertyWithName ("Phone"));
			this.DataForm.RegisterEditor (new ObjCRuntime.Class (typeof(CallEditor)), this.dataSource.EntityModel.PropertyWithName ("CancelReservation"));
			this.DataForm.RegisterEditor (new ObjCRuntime.Class (typeof(TKDataFormOptionsEditor)), this.dataSource.EntityModel.PropertyWithName ("Section"));
			this.DataForm.RegisterEditor (new ObjCRuntime.Class (typeof(TKDataFormOptionsEditor)), this.dataSource.EntityModel.PropertyWithName ("Table"));
			this.DataForm.RegisterEditor (new ObjCRuntime.Class (typeof(TKDataFormSegmentedEditor)), this.dataSource.EntityModel.PropertyWithName ("Origin"));
			this.DataForm.RegisterEditor(new ObjCRuntime.Class(typeof (TKDataFormDatePickerEditor)), this.dataSource.EntityModel.PropertyWithName("Date"));
			this.DataForm.RegisterEditor(new ObjCRuntime.Class(typeof (TKDataFormDatePickerEditor)), this.dataSource.EntityModel.PropertyWithName("Time"));

			CustomizationDataFormDelegate currentDelegate = new CustomizationDataFormDelegate ();
			this.DataForm.Delegate = currentDelegate;
			this.DataForm.DataSource = dataSource;
		}
	}

	public class CustomizationDataFormDelegate: TKDataFormDelegate
	{
		bool cancelAdded;

		void CancelReservation(object sender, EventArgs e)
		{
			TKAlert alert = new TKAlert();

			alert.Style.CornerRadius = 3;
			alert.Title = "Cancel Reservation";
			alert.Message = "Reservation Canceled!";

			alert.AddActionWithTitle ("OK", (TKAlert a, TKAlertAction action) => { return true; });

			alert.Show(true);
		}

		public override bool ValidateProperty (TKDataForm dataForm, TKDataFormEntityProperty propery, TKDataFormEditor editor)
		{
			if (propery.Name == "Name") {
				NSString value = (NSString)propery.Value;
				if (value.Length == 0) {
					return false;
				}
			}

			return true;
		}

		public override void DidValidateProperty (TKDataForm dataForm, TKDataFormEntityProperty propery, TKDataFormEditor editor)
		{
			if (propery.Name == "Name") {
				if (!propery.IsValid) {
					propery.FeedbackMessage = "Please fill in the guest name";
				} else {
					propery.FeedbackMessage = null;
				}
			}
		}

		public override void UpdateEditor (TKDataForm dataForm, TKDataFormEditor editor, TKDataFormEntityProperty property)
		{
			editor.Style.TextLabelOffset = new UIOffset (25, 0);
			editor.Style.SeparatorLeadingSpace = 40;
			editor.Style.AccessoryArrowStroke = new TKStroke (new UIColor (0.780f, 0.2f, 0.233f, 1.0f));
			if (property.Name == "Name") {
				if (!property.IsValid) {
					editor.Style.FeedbackLabelOffset = new UIOffset (25, -5);
					editor.Style.EditorOffset = new UIOffset (25, -7);
				} else {
					editor.Style.FeedbackLabelOffset = new UIOffset (25, 0);
					editor.Style.EditorOffset = new UIOffset (25, 0);
				}

				editor.FeedbackLabel.Font = UIFont.ItalicSystemFontOfSize (10);
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				((UITextField)editor.Editor).Placeholder = "Name";
			}

			if (property.Name == "Time") {
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				editor.Style.TextLabelOffset = new UIOffset (25, 0);
				((TKDataFormDatePickerEditor)editor).DateFormatter.DateFormat = "h:mm:a";
				((UIDatePicker)editor.Editor).Mode = UIDatePickerMode.Time;
			}

			if (property.Name == "Date") {
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				editor.Style.TextLabelOffset = new UIOffset (25, 0);
			}

			if (property.Name == "Guests") {
				var stepper = (UIStepper)editor.Editor;
				stepper.MinimumValue = 1;
				stepper.TintColor = new UIColor (0.780f, 0.2f, 0.223f, 1.0f);
				stepper.SetIncrementImage (new UIImage ("plus.png"), UIControlState.Normal);
				stepper.SetDecrementImage (new UIImage ("minus.png"), UIControlState.Normal);
			}

			if (property.Name == "Section") {
				editor.TextLabel.TextColor = UIColor.White;
				editor.BackgroundColor = UIColor.Clear;
				((TKDataFormOptionsEditor)editor).Options = new NSString[] {(NSString)"Section 1", (NSString)"Section 2", (NSString)"Section 3", (NSString)"Section 4"};
				((TKDataFormOptionsEditor)editor).SelectedOptionLabel.TextColor = UIColor.White;
			}

			if (property.Name == "Table") {
				editor.TextLabel.TextColor = UIColor.White;
				editor.BackgroundColor = UIColor.Clear;
				((TKDataFormOptionsEditor)editor).Options = new NSString[] {
					(NSString)"1",
					(NSString)"2",
					(NSString)"3",
					(NSString)"4",
					(NSString)"5",
					(NSString)"6",
					(NSString)"7",
					(NSString)"8",
					(NSString)"9",
					(NSString)"10",
					(NSString)"11",
					(NSString)"12",
					(NSString)"13",
					(NSString)"14",
					(NSString)"15",
				};

				((TKDataFormOptionsEditor)editor).SelectedOptionLabel.TextColor = UIColor.White;
			}

			if (property.Name == "Origin") {
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				editor.Style.EditorOffset = new UIOffset (25, 0);
				((TKDataFormSegmentedEditor)editor).Segments = new NSString[] { (NSString)"phone", (NSString)"in-person", (NSString)"online", (NSString)"other" };
				UISegmentedControl segmentedControl = (UISegmentedControl)editor.Editor;
				segmentedControl.TintColor = new UIColor (0.780f, 0.2f, 0.223f, 1.0f);
			}

			if (property.Name == "CancelReservation") {
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				editor.Style.EditorOffset = new UIOffset (35, 0);
				((CallEditor)editor).ActionButton.SetTitle (property.DisplayName, UIControlState.Normal);
				if (!cancelAdded) {
					((CallEditor)editor).ActionButton.AddTarget (CancelReservation, UIControlEvent.TouchUpInside);
					cancelAdded = true;
				}
			}
		}

		public override UIView Header (TKDataForm dataForm, nint section)
		{
			TKDataFormHeaderView header = new TKDataFormHeaderView ();
			header.TitleLabel.TextColor = UIColor.Gray;
			header.Insets = new UIEdgeInsets(0, 40, 0, 0);
			if (section == 0) {
				header.TitleLabel.Text = "RESERVATION DETAILS";
			} else if (section == 1) {
				header.TitleLabel.Text = "TABLE DETAILS";
			} else {
				header.TitleLabel.Text = "ORIGIN";
			}

			return header;
		}

		public override nfloat HeaderHeight (TKDataForm dataForm, nint section)
		{
			return 30;
		}
	}
}

