using System;
using TelerikUI;
using Foundation;
using ObjCRuntime;
using UIKit;
using CoreAnimation;

namespace Examples
{
	[Register("DataFormLabelAlignment")]
	public class DataFormLabelAlignment : XamarinExampleViewController
	{
		TKDataForm dataForm;
		TKDataFormEntityDataSourceHelper dataSource;
		DataFormAlignmentDelegate dataFormDelegate;
		EmployeeInfo info;
		public string alignment = "Top";

		public override void ViewDidLoad ()
		{
			AddOption ("Top Alignment", PrepareTopAlignment);
			AddOption ("Left Alignment", PrepareLeftAlignment);
			AddOption ("Top Inline Alignment", PrepareTopInlineAlignment);
			AddOption ("Table View Layout", PrepareTableLayout);

			base.ViewDidLoad ();

			this.info = new EmployeeInfo ();
			this.dataSource = new TKDataFormEntityDataSourceHelper (this.info);
			this.dataFormDelegate = new DataFormAlignmentDelegate (this);

			this.dataForm = new TKDataForm (this.View.Bounds);
			this.dataForm.AutoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
			this.dataForm.BackgroundColor = new UIColor (0.937f, 0.937f, 0.960f, 1.0f);
			this.dataForm.Delegate = this.dataFormDelegate;
			this.View.AddSubview (this.dataForm);

			this.dataSource.AddGroup ("Personal Info", new string[] {
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
		}
			
		private void PrepareTopAlignment ()
		{
			this.alignment = "Top";
			this.dataForm.ReloadData ();
		}
			
		private void PrepareLeftAlignment () 
		{
			this.alignment = "Left";
			this.dataForm.ReloadData ();
		}
			
		private void PrepareTopInlineAlignment ()
		{
			this.alignment = "TopInline";
			this.dataForm.ReloadData ();
		}
			
		private void PrepareTableLayout () 
		{
			this.alignment = "Table";
			this.dataForm.ReloadData ();
		}
	}

	class DataFormAlignmentDelegate: TKDataFormDelegate
	{
		DataFormLabelAlignment owner;

		public DataFormAlignmentDelegate(DataFormLabelAlignment owner) {
			this.owner = owner;
		}

		public override void UpdateEditor (TKDataForm dataForm, TKDataFormEditor editor, TKEntityProperty property)
		{
			property.HintText = property.DisplayName;
			if (owner.alignment == "Top") {
				this.PerformTopAlignmentSettingsForEditor (editor, property);
			} else if (owner.alignment == "TopInline") {
				this.PerformTopInlineAlignmentSettingsForEditor (editor, property);
			} else if (owner.alignment == "Left") {
				this.PerformLeftAlignmentSettingsForEditor (editor, property);
			}
		}

		public override nfloat HeightForHeader (TKDataForm dataForm, uint groupIndex)
		{
			return 40;
		}

		public override nfloat HeightForEditor (TKDataForm dataForm, uint groupIndex, uint editorIndex)
		{
			if (owner.alignment == "Top") {
				if (groupIndex == 0 && editorIndex == 2) {
					return 20;
				}

				return 65;
			}

			if (owner.alignment == "TopInline" && groupIndex == 0 && editorIndex == 4) {
				return 75;
			}

			return 44;
		}

		public override void UpdateGroupView (TKDataForm dataForm, TKEntityPropertyGroupView groupView, uint groupIndex)
		{
			groupView.EditorsContainer.BackgroundColor = UIColor.White;
			if (owner.alignment != "Table") {
				((TKStackLayout)groupView.EditorsContainer.Layout).Spacing = 7;
			}
		}

		public override void DidSelectEditor (TKDataForm dataForm, TKDataFormEditor editor, TKEntityProperty property)
		{
			var borderColor = new UIColor (0.000f, 0.478f, 1.000f, 1.00f);
			var layer = editor.Editor.Layer;

			if (editor.IsKindOfClass(new ObjCRuntime.Class(typeof(TKDataFormDatePickerEditor)))) {
				var dateEditor = editor as TKDataFormDatePickerEditor;
				layer = dateEditor.EditorValueLabel.Layer;
			}

			var currentBorderColor = new UIColor(layer.BorderColor);
			layer.BorderColor = borderColor.CGColor;
			var animate = CABasicAnimation.FromKeyPath ("borderColor");
			animate.From = currentBorderColor;
			animate.To = borderColor;
			animate.Duration = 0.4;
			layer.AddAnimation(animate, "borderColor");
		}

		public override void DidDeselectEditor (TKDataForm dataForm, TKDataFormEditor editor, TKEntityProperty property)
		{
			if (editor.IsKindOfClass(new ObjCRuntime.Class(typeof(TKDataFormDatePickerEditor)))) {
				var dateEditor = editor as TKDataFormDatePickerEditor;
				dateEditor.EditorValueLabel.Layer.BorderColor = new UIColor(0.784f, 0.780f, 0.800f, 1.00f).CGColor;
			}
			editor.Editor.Layer.BorderColor = new UIColor(0.880f, 0.880f, 0.880f, 1.00f).CGColor;
		}

		private void PerformTopAlignmentSettingsForEditor(TKDataFormEditor editor, TKEntityProperty property)
		{
			editor.Style.SeparatorColor = null;
			editor.TextLabel.Font = UIFont.SystemFontOfSize (15);
			editor.Style.Insets = new UIEdgeInsets (1, editor.Style.Insets.Left, 5, editor.Style.Insets.Right);
			
			if (property.Name != "Gender") {
				TKGridLayout gridLayout = editor.GridLayout;
				TKGridLayoutCellDefinition editorDef = gridLayout.DefinitionForView (editor.Editor);
				if (editorDef != null) {
					editorDef.Row = new NSNumber (1);
					editorDef.Column = new NSNumber (1);
				}

				if (property.Name == "DateOfBirth") {
					TKDataFormDatePickerEditor dateEditor = (TKDataFormDatePickerEditor)editor;
					TKGridLayoutCellDefinition labelDef = gridLayout.DefinitionForView (dateEditor.EditorValueLabel);
					labelDef.Row = new NSNumber (1);
					labelDef.Column = new NSNumber (1);
				}

				TKGridLayoutCellDefinition feedbackDef = editor.GridLayout.DefinitionForView (editor.FeedbackLabel);
				feedbackDef.Row = new NSNumber (2);
				feedbackDef.Column = new NSNumber (1);
				feedbackDef.ColumnSpan = 1;

				this.SetEditorStyle (editor);
			}
		}

		private void PerformLeftAlignmentSettingsForEditor(TKDataFormEditor editor, TKEntityProperty property)
		{
			editor.Style.SeparatorColor = null;
			editor.Style.Insets = new UIEdgeInsets (6, editor.Style.Insets.Left, 6, editor.Style.Insets.Right);

			if (property.Name != "Gender") {
				this.SetEditorStyle (editor);
			}
		}

		private void PerformTopInlineAlignmentSettingsForEditor(TKDataFormEditor editor, TKEntityProperty property)
		{
			editor.Style.SeparatorColor = null;
			editor.Style.Insets = new UIEdgeInsets (6, editor.Style.Insets.Left, 6, editor.Style.Insets.Right);

			TKGridLayout gridLayout = editor.GridLayout;

			this.SetEditorStyle (editor);

			if (property.Name == "DateOfBirth") {
				TKDataFormDatePickerEditor dateEditor = (TKDataFormDatePickerEditor)editor;
				TKGridLayoutCellDefinition labelDef = gridLayout.DefinitionForView (dateEditor.EditorValueLabel);
				labelDef.Row = new NSNumber (1);
				labelDef.Column = new NSNumber (1);
				gridLayout.SetHeight (44, labelDef.Row.Int32Value);

				TKGridLayoutCellDefinition feedbackDef = editor.GridLayout.DefinitionForView (editor.FeedbackLabel);
				feedbackDef.Row = new NSNumber (2);
				feedbackDef.Column = new NSNumber (1);
				feedbackDef.ColumnSpan = 1;
			}

			if (editor.IsKindOfClass (new Class(typeof(TKDataFormTextFieldEditor)))) {
				editor.Style.TextLabelDisplayMode = TKDataFormEditorTextLabelDisplayMode.Hidden;
				TKGridLayoutCellDefinition titleDef = editor.GridLayout.DefinitionForView (editor.TextLabel);
				gridLayout.SetWidth (0, titleDef.Column.Int32Value);
			}
		}

		void SetEditorStyle(TKDataFormEditor editor) 
		{
			var layer = editor.Editor.Layer;

			if (editor.IsKindOfClass(new ObjCRuntime.Class(typeof(TKDataFormDatePickerEditor)))) {
				var dateEditor = editor as TKDataFormDatePickerEditor;
				layer = dateEditor.EditorValueLabel.Layer;
				dateEditor.EditorValueLabel.Layer.BorderWidth = 1.0f;
				dateEditor.EditorValueLabel.Layer.BorderColor = UIColor.Gray.CGColor;
				dateEditor.ShowAccessoryImage = false;
				dateEditor.EditorValueLabel.TextInsets = new UIEdgeInsets(0, 7, 0, 0);
			}
			else if (editor.IsKindOfClass(new ObjCRuntime.Class(typeof(TKDataFormTextFieldEditor)))) {
				layer = editor.Editor.Layer;
				(editor.Editor as TKTextField).TextInsets = new UIEdgeInsets (0, 7, 0, 0);
			}

			layer.BorderColor = new UIColor (0.880f, 0.880f, 0.880f, 1.00f).CGColor;
			layer.BorderWidth = 1.0f;
			layer.CornerRadius = 4;
		}
	}
}

