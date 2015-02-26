using System;

using Foundation;
using UIKit;

namespace Examples
{
	public class DSItem: NSObject
	{
		[Export("Name")]
		public string Name { get; set; }

		[Export("Value")]
		public nfloat Value { get; set; }

		[Export("Group")]
		public string Group { get; set; }

		[Export("Date")]
		public NSDate Date { get; set; }

		[Export("Image")]
		public UIImage Image { get; set; }
	}
}

