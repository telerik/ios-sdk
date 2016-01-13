using System;
using TelerikUI;
using UIKit;
using Foundation;
using System.Collections.Generic;
using CoreGraphics;

namespace Examples
{
	[Register("DataFormCustomization")]
	public class DataFormCustomization : TKDataFormViewController
	{
		CustomizationDataFormDelegate dataFormDelegate;
		TKDataFormEntityDataSourceHelper dataSource;
		ReservationForm reservationForm;
		UIButton btn;

		public override void ViewDidLoad ()
		{
			base.ViewDidLoad ();

			this.View.BackgroundColor = UIColor.White;

			this.reservationForm = new ReservationForm ();
			this.dataSource = new TKDataFormEntityDataSourceHelper (this.reservationForm);
			this.dataFormDelegate = new CustomizationDataFormDelegate ();

			NSDateFormatter formatter = new NSDateFormatter ();
			formatter.DateFormat = "h:mm a";
			this.dataSource.PropertyWithName ("Time").Formatter = formatter;

			this.dataSource["Name"].Image = UIImage.FromBundle ("guest-name.png");
			this.dataSource["Phone"].Image = UIImage.FromBundle ("phone.png");
			this.dataSource["Date"].Image = UIImage.FromBundle ("calendar.png");
			this.dataSource["Time"].Image = UIImage.FromBundle ("time.png");
			this.dataSource["Guests"].Image = UIImage.FromBundle ("guest-number.png");
			this.dataSource["Table"].Image = UIImage.FromBundle ("table-number.png");

			this.dataSource["Name"].HintText = "Name";
			this.dataSource["Name"].ErrorMessage = @"Please fill in the guest name";
			this.dataSource["Time"].EditorClass = new ObjCRuntime.Class(typeof(TKDataFormTimePickerEditor));
			this.dataSource["Phone"].EditorClass = new ObjCRuntime.Class(typeof(CallEditor));
			this.dataSource ["Phone"].HintText = "Phone";
			this.dataSource["Origin"].EditorClass = new ObjCRuntime.Class(typeof(TKDataFormSegmentedEditor));

			this.dataSource["Guests"].Range = new TKRange (new NSNumber(1), new NSNumber(10));
			this.dataSource["Section"].ValuesProvider = NSArray.FromStrings (new string[] {
				"Section 1",
				"Section 2",
				"Section 3",
				"Section 4"
			});
			this.dataSource["Table"].ValuesProvider = NSArray.FromStrings(new string[] { "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15" });
			this.dataSource["Origin"].ValuesProvider = NSArray.FromStrings (new string[] {
				"phone",
				"in-person",
				"online",
				"other"
			});

			this.dataSource.AddGroup ("RESERVATION DETAILS", new string[] { "Name", "Phone", "Date", "Time", "Guests" });
			this.dataSource.AddGroup ("TABLE DETAILS", new string[] { "Section", "Table" });
			this.dataSource.AddGroup ("ORIGIN", new string[] { "Origin" });
				
			this.DataForm.BackgroundColor = UIColor.FromPatternImage (UIImage.FromBundle ("wood-pattern.png"));
			this.DataForm.Frame = new CGRect (0, 0, this.View.Bounds.Size.Width, this.View.Bounds.Size.Height - 66);
			this.DataForm.TintColor = new UIColor (0.780f, 0.2f, 0.223f, 1.0f);
			this.DataForm.Delegate = this.dataFormDelegate;
			this.DataForm.WeakDataSource = this.dataSource.NativeObject;

			btn = new UIButton (new CGRect (0, this.DataForm.Frame.Size.Height, this.View.Bounds.Size.Width, 66));
			btn.SetTitle ("Cancel Reservation", UIControlState.Normal);
			btn.SetTitleColor (new UIColor (0.780f, 0.2f, 0.223f, 1.0f), UIControlState.Normal);
			btn.AddTarget (this, new ObjCRuntime.Selector ("CancelReservation"), UIControlEvent.TouchUpInside);
			this.View.AddSubview (btn);
		}

		public override void ViewWillLayoutSubviews ()
		{
			base.ViewWillLayoutSubviews ();
			btn.Frame = new CGRect (0, this.DataForm.Frame.Size.Height, this.View.Bounds.Size.Width, 66);
		}

		[Export ("CancelReservation")]
		void CancelReservation()
		{
			TKAlert alert = new TKAlert();

			alert.Style.CornerRadius = 3;
			alert.Title = "Cancel Reservation";
			alert.Message = "Reservation Canceled!";

			alert.AddActionWithTitle ("OK", (TKAlert a, TKAlertAction action) => { return true; });
			alert.Show(true);
		}
	}
		
	class CustomizationDataFormDelegate: TKDataFormDelegate
	{
		public override bool ValidateProperty (TKDataForm dataForm, TKEntityProperty property, TKDataFormEditor editor)
		{
			if (property.Name == "Name") {
				NSString value = (NSString)property.ValueCandidate;
				if (value.Length == 0) {
					return false;
				}
			}

			return true;
		}

		public override void UpdateEditor (TKDataForm dataForm, TKDataFormEditor editor, TKEntityProperty property)
		{
			editor.Style.TextLabelOffset = new UIOffset (10, 0);
			editor.Style.SeparatorLeadingSpace = 40;
			editor.Style.AccessoryArrowStroke = new TKStroke (new UIColor (0.780f, 0.2f, 0.233f, 1.0f));
			List<string> properties = new List<string> () { "Origin", "Date", "Time", "Name", "Phone" };

			if (properties.Contains(property.Name)) {
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				TKGridLayoutCellDefinition titleDef = editor.GridLayout.DefinitionForView (editor.TextLabel);
				editor.GridLayout.SetWidth (0, titleDef.Column.Int32Value);
				editor.Style.EditorOffset = new UIOffset (10, 0);
			}

			if (property.Name == "Origin") {
				editor.Style.EditorOffset = new UIOffset (0, 0);
				editor.Style.SeparatorColor = null;
			}

			if (property.Name == "Name") {
				editor.Style.FeedbackLabelOffset = new UIOffset (10, 0);
				editor.FeedbackLabel.Font = UIFont.ItalicSystemFontOfSize (10);
			}

			if (property.Name == "Guests") {
				TKGridLayoutCellDefinition labelDef = editor.GridLayout.DefinitionForView (((TKDataFormStepperEditor)editor).ValueLabel);
				labelDef.ContentOffset = new UIOffset (-25, 0);
			}

			if (property.Name == "Section") {
				UIImage img = UIImage.FromBundle ("guest-name.png");
				editor.Style.TextLabelOffset = new UIOffset (img.Size.Width + 10, 0);
			}

			if (property.Name == "Table" || property.Name == "Section") {
				editor.TextLabel.TextColor = UIColor.White;
				editor.BackgroundColor = UIColor.Clear;
				((TKDataFormOptionsEditor)editor).SelectedOptionLabel.TextColor = UIColor.White;
				((TKDataFormOptionsEditor)editor).SelectedOptionLabel.TextAlignment = UITextAlignment.Right;
				editor.Style.EditorOffset = new UIOffset (-10, 0);
			}
		}

		public override void UpdateGroupView (TKDataForm dataForm, TKEntityPropertyGroupView groupView, uint groupIndex)
		{
			groupView.TitleView.TitleLabel.TextColor = UIColor.LightGray;
			groupView.TitleView.TitleLabel.Font = UIFont.SystemFontOfSize (13);
			groupView.TitleView.Style.Insets = new UIEdgeInsets (0, 10, 0, 0);
			if (groupIndex == 1) {
				groupView.EditorsContainer.BackgroundColor = UIColor.Clear;
			}
		}
			
	}
}

