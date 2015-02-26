using System;

using Foundation;
using UIKit;

namespace Examples
{
	public class OptionInfo
	{
		public string OptionText { get; set; }

		public EventHandler Handler { get; set; }

		public object Tag { get; set; }

		public OptionInfo (string text, EventHandler handler)
		{
			this.OptionText = text;
			this.Handler = handler;
		}

		public OptionInfo (string text, EventHandler handler, object tag)
		{
			this.OptionText = text;
			this.Handler = handler;
			this.Tag = tag;
		}
	}
}

