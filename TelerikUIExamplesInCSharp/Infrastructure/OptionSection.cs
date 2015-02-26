using System;
using System.Collections.Generic;

namespace Examples
{
	public class OptionSection
	{
		public string Title {
			get;
			set;
		}

		public List<OptionInfo> Items {
			get;
			set;
		}

		public int SelectedOption {
			get;
			set;
		}

		public OptionSection (string title)
		{
			this.Title = title;
			this.Items = new List<OptionInfo> ();
		}
	}
}

